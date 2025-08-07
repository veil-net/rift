package com.veilnet.rift

import android.content.Intent
import android.net.VpnService
import android.os.ParcelFileDescriptor
import android.util.Log
import kotlinx.coroutines.*
import java.io.FileInputStream
import java.io.FileOutputStream
import veilnet.Anchor
import veilnet.Veilnet.newAnchor

class VeilNet : VpnService() {

    companion object {
        @Volatile
        private var instance: VeilNet? = null

        fun stop(): Boolean {
            val service = instance ?: return false
            service.anchorScope.launch {
                service.egress.cancel()
                service.ingress.cancel()
                service.anchor?.stop()
                service.tunInterface?.close()
                service.stopSelf()
            }
            return true
        }
    }

    private var tunInterface: ParcelFileDescriptor? = null
    private var anchor: Anchor? = null
    private var anchorScope: CoroutineScope = CoroutineScope(Dispatchers.Default + SupervisorJob())
    private var egress: CoroutineScope = CoroutineScope(Dispatchers.IO)
    private var ingress: CoroutineScope = CoroutineScope(Dispatchers.IO)

    override fun onCreate() {
        super.onCreate()
        instance = this
    }

    override fun onDestroy() {
        anchorScope.cancel()
        instance = null
        super.onDestroy()
    }

    override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {
        val guardian = intent.getStringExtra("guardian")
        val token = intent.getStringExtra("token")

        if (guardian == null || token == null) {
            Log.e("VeilNet", "Guardian Url or VeilNet token is missing")
            stopSelf()
            return START_NOT_STICKY
        }

        anchorScope.launch {
            try {
                anchor = newAnchor()
            } catch (e: Exception) {
                Log.e("VeilNet", "Failed to create anchor instance")
                stopSelf()
                return@launch
            }

            try {
                anchor!!.start(guardian, token, false)
            } catch (e: Exception) {
                Log.e("VeilNet", "Failed to start anchor")
                stopSelf()
                return@launch
            }

            try {
                val cidr = anchor!!.cidr
                val (ip, mask) = cidr!!.split("/")
                val builder = Builder()
                    .setSession("VeilNet")
                    .addAddress(ip, mask.toInt())
                    .addDnsServer("1.1.1.1")
                    .addRoute("0.0.0.0", 0)
                    .setMtu(1500)
                    .addDisallowedApplication(applicationContext.packageName)
                tunInterface = builder.establish()
            } catch (e: Exception) {
                Log.e("VeilNet", "Failed to create tunnel interface")
                stopSelf()
                return@launch
            }
            startEgress()
            startIngress()
            if (anchor?.isAlive == false) {
                stop()
                return@launch
            }
        }
        return START_REDELIVER_INTENT
    }

    private fun startEgress() {
        egress.launch {
            try {
                FileInputStream(tunInterface?.fileDescriptor).use { tunnelInput ->
                    val buffer = ByteArray(1500)
                    while (isActive) {  // Check if coroutine is still active
                        try {
                            val size = tunnelInput.read(buffer)
                            if (size > 0) {
                                anchor?.writePacket(buffer, size.toLong())
                            }
                        } catch (e: Exception) {
                            Log.e("VeilNet", "Egress has encountered an error: ${e.message}")
                        }
                    }
                }
            } catch (e: Exception) {
                Log.e("VeilNet", "Failed to start egress: ${e.message}")
                stopSelf()
            }
        }
    }

    private fun startIngress() {
        ingress.launch {
            try {
                FileOutputStream(tunInterface?.fileDescriptor).use { tunnelOutput ->
                    val buffer = ByteArray(1500)
                    while (isActive) {  // Check if coroutine is still active
                        try {
                            val size = anchor?.readPacket(buffer)
                            if (size != null && size > 0) {
                                tunnelOutput.write(buffer, 0, size.toInt())
                            }
                        } catch (e: Exception) {
                            Log.e("VeilNet", "Ingress has encountered an error: ${e.message}")
                        }
                    }
                }
            } catch (e: Exception) {
                Log.e("VeilNet", "Failed to start ingress: ${e.message}")
                stopSelf()
            }
        }
    }
}
