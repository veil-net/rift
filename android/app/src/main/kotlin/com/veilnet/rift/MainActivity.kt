package com.veilnet.rift

import android.app.Activity
import android.content.Intent
import android.net.VpnService
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channel = "veilnet/service"
    private var currentResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)
            .setMethodCallHandler { call, result ->
                currentResult = result
                when (call.method) {
                    "requestPermission" -> {
                        val intent = VpnService.prepare(this)
                        if (intent != null) {
                            startActivityForResult(intent, 1001)
                        } else {
                            result.success(true)
                        }
                    }

                    "start" -> {
                        try {
                            val guardian = call.argument<String>("guardian")
                            val token = call.argument<String>("token")
                            if (guardian == null || token == null) {
                                result.error(
                                    "Missing argument",
                                    "Guardian Url or VeilNet token is missing",
                                    null
                                )
                            }
                            val intent = Intent(this, VeilNet::class.java)
                            intent.putExtra("guardian", guardian)
                            intent.putExtra("token", token)
                            startService(intent)
                            result.success(true)
                        } catch (e: Exception) {
                            result.error("Fail to start", e.message, null)
                        }
                    }

                    "stop" -> {
                        try {
                            val ok = VeilNet.stop()
                            result.success(ok)
                        } catch (e: Exception) {
                            result.error("Fail to stop", e.message, null)
                        }
                    }

                    else -> result.notImplemented()
                }
    }
}

override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
    when (requestCode) {
        1001 -> {
            if (resultCode == Activity.RESULT_OK) {
                currentResult?.success(true)
            } else {
                currentResult?.success(false)
            }
        }

        else -> super.onActivityResult(requestCode, resultCode, data)
    }
}
}
