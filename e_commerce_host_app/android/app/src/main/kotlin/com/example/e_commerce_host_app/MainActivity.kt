package com.example.e_commerce_host_app

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.FlutterEngineGroup
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class MainActivity : FlutterActivity() {

    companion object {
        private const val CHANNEL_LAUNCH = "com.jodetx.payment/launch"
        private const val ENGINE_ID = "payment_engine"
        private const val ENTRYPOINT = "main" // 🔥 FINAL: Call "main", not "startPayment"
    }

    private lateinit var flutterEngineGroup: FlutterEngineGroup

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_LAUNCH)
            .setMethodCallHandler { call, result ->
                if (call.method == "launchPayment") {
                    launchFlutterSDK()
                    result.success("✅ Payment UI launched")
                } else {
                    result.notImplemented()
                }
            }
    }

    private fun launchFlutterSDK() {
        val flutterLoader = FlutterInjector.instance().flutterLoader()
        flutterLoader.startInitialization(applicationContext)
        flutterLoader.ensureInitializationComplete(applicationContext, null)

        flutterEngineGroup = FlutterEngineGroup(applicationContext)

        val engine = flutterEngineGroup.createAndRunEngine(
            this,
            DartExecutor.DartEntrypoint(
                flutterLoader.findAppBundlePath(),
                ENTRYPOINT // ✅ Use main
            )
        )

        FlutterEngineCache.getInstance().put(ENGINE_ID, engine)

        startActivity(
            FlutterActivity
                .withCachedEngine(ENGINE_ID)
                .build(this)
        )
    }
}
