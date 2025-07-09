package com.example.e_commerce_host_app

import android.util.Log
import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineGroup
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.FlutterInjector
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    companion object {
        private const val CHANNEL_NATIVE = "com.jodetx.payment/native"
        private const val ENGINE_ID = "payment_engine"
        private const val ENTRYPOINT = "startPayment"
    }

    private lateinit var flutterEngineGroup: FlutterEngineGroup
    private lateinit var paymentEngine: FlutterEngine

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val flutterLoader = FlutterInjector.instance().flutterLoader()
        flutterLoader.startInitialization(applicationContext)
        flutterLoader.ensureInitializationComplete(applicationContext, null)

        flutterEngineGroup = FlutterEngineGroup(applicationContext)
        paymentEngine = flutterEngineGroup.createAndRunEngine(
            this,
            DartExecutor.DartEntrypoint(
                flutterLoader.findAppBundlePath(), "startPayment"
            )
        )

        FlutterEngineCache.getInstance().put(ENGINE_ID, paymentEngine)

        Log.d("MainActivity", "✅ PaymentEngine created with entrypoint: $ENTRYPOINT")
    }

    // Register MethodChannel on host FlutterEngine (default engine)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_NATIVE)
            .setMethodCallHandler { call, result ->
                if (call.method == "launchPayment") {
                    // Launch PaymentActivity that hosts the SDK FlutterEngine
                    startActivity(Intent(this, PaymentActivity::class.java))
                    result.success("✅ Payment Activity started")
                } else {
                    result.notImplemented()
                }
            }
    }
}
