package com.example.e_commerce_host_app

import android.app.Activity
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import io.flutter.embedding.android.FlutterView
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.android.ExclusiveAppComponent

class PaymentActivity : AppCompatActivity(), ExclusiveAppComponent<Activity> {

    private lateinit var flutterView: FlutterView
    private lateinit var flutterEngine: FlutterEngine

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // ✅ Set up the FlutterView before attaching
        flutterView = FlutterView(this)
        setContentView(flutterView)

        // ✅ Get cached engine from MainActivity
        flutterEngine = FlutterEngineCache.getInstance().get("payment_engine")!!

        // ✅ Attach the FlutterView to the engine
        flutterEngine.activityControlSurface.attachToActivity(this, lifecycle)
        flutterView.attachToFlutterEngine(flutterEngine)

        // ✅ Resume app lifecycle
        flutterEngine.lifecycleChannel.appIsResumed()
    }

    override fun onBackPressed() {
        flutterEngine.navigationChannel.popRoute()
    }

    override fun onDestroy() {
        flutterEngine.activityControlSurface.detachFromActivity()
        flutterView.detachFromFlutterEngine()
        flutterEngine.lifecycleChannel.appIsDetached()
        super.onDestroy()
    }

    override fun detachFromFlutterEngine() {
        flutterEngine.activityControlSurface.detachFromActivity()
    }

    override fun getAppComponent(): Activity = this
}
