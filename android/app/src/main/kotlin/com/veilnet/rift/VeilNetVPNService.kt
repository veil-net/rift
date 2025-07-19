package com.veilnet.rift

import android.content.Intent
import android.net.VpnService
import android.os.Build
import android.os.ParcelFileDescriptor
import android.system.OsConstants
import android.util.Log
import androidx.annotation.RequiresApi
import kotlinx.coroutines.*
import java.io.FileInputStream
import java.io.FileOutputStream
import veilnet.Veilnet

class VeilNet : VpnService() {

    companion object {
        @Volatile
        private var instance: VeilNet? = null

        fun stopVeilNet(): Boolean {
            val service = instance ?: return false
            service.stop()
            return true
        }
    }

    private var tunInterface: ParcelFileDescriptor? = null
    private var anchor: veilnet.Anchor? = null
    private val vpnScope = CoroutineScope(Dispatchers.IO + SupervisorJob())
    private val stopScope = CoroutineScope(Dispatchers.IO + SupervisorJob())

    override fun onCreate() {
        super.onCreate()
        instance = this
    }

    override fun onDestroy() {
        vpnScope.cancel()
        stopScope.cancel()
        if (tunInterface != null) {
            tunInterface!!.close()
            tunInterface = null
        }
        if (anchor != null) {
            anchor!!.stop()
            anchor = null
        }
        instance = null
        super.onDestroy()
    }

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val guardianUrl = intent?.getStringExtra("guardian_url")
        val anchorToken = intent?.getStringExtra("anchor_token")

        if (guardianUrl == null || anchorToken == null) {
            Log.e("VeilNet", "Guardian URL or anchor token is missing")
            stopSelf()
            return START_NOT_STICKY
        }

        vpnScope.launch {
            try {
                anchor = Veilnet.newAnchor()
                anchor!!.start(guardianUrl, anchorToken, false)
            } catch (e: Exception) {
                Log.e("VeilNet", "VPN start failed", e)
                stopSelf()
                return@launch
            }

            val cidr = try {
                anchor!!.cidr
            } catch (e: Exception) {
                Log.e("VeilNet", "Failed to get CIDR", e)
                stopSelf()
                return@launch
            }

            val (ip, mask) = cidr.split("/")
            val builder = this@VeilNet.Builder()
                .setSession("VeilNet")
                .addAddress(ip, mask.toInt())
                .addDnsServer("1.1.1.1")
                .addRoute("0.0.0.0", 0)
                .allowFamily(OsConstants.AF_INET)
                .setMtu(1500)
                .addDisallowedApplication(applicationContext.packageName)

            tunInterface = builder.establish()
            if (tunInterface == null) {
                Log.e("VeilNet", "Failed to establish TUN interface")
                stopSelf()
                return@launch
            }

            launch { egress() }
            launch { ingress() }
            launch { liveliness() }
        }

        return START_STICKY
    }


    private fun stop() {
        try {
            stopScope.launch {
                vpnScope.cancel()
                if (tunInterface != null) {
                    tunInterface!!.close()
                    tunInterface = null
                }
                if (anchor != null) {
                    anchor!!.stop()
                    anchor = null
                }
                stopSelf()
            }
        } catch (e: Exception) {
            Log.w("VeilNet", "Failed to stop VPN service", e)
            throw e
        }
    }

    private suspend fun egress() = withContext(Dispatchers.IO) {
        tunInterface?.fileDescriptor?.let { fd ->
            FileInputStream(fd).use { input ->
                val buffer = ByteArray(1500)
                while (isActive) {
                    try {
                        val len = input.read(buffer)
                        if (len > 0) {
                            anchor?.writePacket(buffer, len.toLong())
                        }
                    } catch (e: Exception) {
                        Log.e("VeilNet", "Egress error", e)
                    }
                }
            }
        }
    }

    private suspend fun ingress() = withContext(Dispatchers.IO) {
        tunInterface?.fileDescriptor?.let { fd ->
            FileOutputStream(fd).use { output ->
                val buffer = ByteArray(1500)
                while (isActive) {
                    try {
                        val len = anchor?.readPacket(buffer) ?: break
                        if (len > 0) {
                            output.write(buffer, 0, len.toInt())
                            output.flush()
                        }
                    } catch (e: Exception) {
                        Log.e("VeilNet", "Ingress error", e)
                    }
                }
            }
        }
    }

    private suspend fun liveliness() = withContext(Dispatchers.IO) {
        while (isActive) {
            val isAnchorAlive = anchor?.isAlive ?: false
            if (!isAnchorAlive) {
                Log.w("VeilNet", "Anchor is no longer alive. Stopping VPN service.")
                stop() // this stops the VPN and the anchor
                break
            }
        }
    }
}
