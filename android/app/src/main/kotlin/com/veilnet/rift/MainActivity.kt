package com.veilnet.rift

import android.app.Activity
import android.content.Intent
import android.net.VpnService
import android.os.Build
import androidx.annotation.RequiresApi
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channel = "veilnet/channel"
    private val vpnRequestCode = 1001
    private var pendingResult: MethodChannel.Result? = null

    @RequiresApi(Build.VERSION_CODES.N)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "requestVpnPermission" -> {
                        val intent = VpnService.prepare(this)
                        if (intent != null) {
                            pendingResult = result
                            startActivityForResult(intent, vpnRequestCode)
                        } else {
                            // Already granted
                            result.success(true)
                        }
                    }

                    "startVpnService" -> {
                        val config = call.argument<Map<String, Any>>("config")
                        if (config == null) {
                            result.error("MISSING_CONFIG", "VPN config is required", null)
                            return@setMethodCallHandler
                        }

                        val serviceIntent = Intent(this, VeilNet::class.java).apply {
                            putExtra("api_base_url", config["api_base_url"] as? String)
                            putExtra("anchor_token", config["anchor_token"] as? String)
                            putExtra("anchor_name", config["anchor_name"] as? String)
                            putExtra("domain", config["domain"] as? String)
                            putExtra("region", config["region"] as? String)
                            putExtra("public", config["public"] as? Boolean ?: false)
                        }

                        try {
                            startService(serviceIntent)
                            result.success(true)
                        } catch (e: Exception) {
                            result.error("VeilNet Failed to Start", e.message, null)
                        }
                    }

                    "shutdownVpn" -> {
                        try {
                            val ok = VeilNet.stopVeilNet()
                            result.success(ok)
                        } catch (e: Exception) {
                            result.error("VeilNet Failed to Shutdown", e.message, null)
                        }
                    }

                    else -> result.notImplemented()
                }
            }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == vpnRequestCode) {
            val granted = resultCode == Activity.RESULT_OK
            pendingResult?.success(granted)
            pendingResult = null
        } else {
            super.onActivityResult(requestCode, resultCode, data)
        }
    }
}
