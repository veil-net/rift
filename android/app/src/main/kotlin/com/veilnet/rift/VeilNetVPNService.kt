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

    override fun onCreate() {
        super.onCreate()
        instance = this
    }

    override fun onDestroy() {
        instance = null
        if (anchor != null) {
            anchor!!.stop()
        }
        super.onDestroy()
    }

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val apiBaseUrl = intent?.getStringExtra("api_base_url")
        val anchorToken = intent?.getStringExtra("anchor_token")
        val anchorName = intent?.getStringExtra("anchor_name")
        val domainName = intent?.getStringExtra("domain")
        val region = intent?.getStringExtra("region")
        val isPublic = intent?.getBooleanExtra("public", false) ?: false

        if (apiBaseUrl == null || anchorToken == null || anchorName == null || domainName == null || region == null) {
            Log.e("VeilNet", "Missing VPN config parameters")
            stopSelf()
            return START_NOT_STICKY
        }

        try {
            anchor = Veilnet.newAnchor(false, isPublic)
            anchor!!.start(apiBaseUrl, anchorToken, anchorName, domainName, region)
        } catch (e: Exception) {
            Log.e("VeilNet", "VPN start failed", e)
            anchor!!.stop()
            stopSelf()
            return START_NOT_STICKY
        }

        val cidr = try {
            anchor!!.cidr
        } catch (e: Exception) {
            Log.e("VeilNet", "Invalid CIDR after start", e)
            anchor!!.stop()
            stopSelf()
            return START_NOT_STICKY
        }

        val (ip, mask) = cidr.split("/")
        val builder = this.Builder()
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
            anchor!!.stop()
            stopSelf()
            return START_NOT_STICKY
        }

        vpnScope.launch {
            val egressJob = launch { egress() }
            val ingressJob = launch { ingress() }
            val livelinessJob = launch { liveliness() }
            joinAll(egressJob, ingressJob, livelinessJob)
        }

        return START_STICKY
    }


    private fun stop() {
        try {
            vpnScope.cancel()
            tunInterface?.close()
            anchor?.stop()
            anchor = null
            stopSelf()
        } catch (e: Exception) {
            Log.w("VeilNet", "Cleanup failed", e)
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
