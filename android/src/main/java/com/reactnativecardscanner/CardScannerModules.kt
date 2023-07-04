package com.reactnativecardscanner

import android.app.Activity
import android.content.Intent
import android.util.Log
import com.facebook.react.bridge.*
import com.reactnativecardscanner.cardmodules.ScanActivity


class CardScannerModules(
        private val reactContext: ReactApplicationContext
) : ReactContextBaseJavaModule(reactContext), ActivityEventListener {
    private val MODULE_NAME: String = "CardScannerModules"

    private lateinit var promiseResult: Promise

    override fun getName(): String {
        return MODULE_NAME
    }

    init {
        reactContext.addActivityEventListener(this)
    }

    @ReactMethod
    fun startScanner(promise: Promise) {
        promiseResult = promise

        currentActivity?.let {
            ScanActivity.warmUp(it)
            ScanActivity.start(it)
        }
    }

    override fun onActivityResult(activity: Activity?, requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == 51234) {
            when (resultCode) {
                Activity.RESULT_OK -> {
                    val number = data?.getStringExtra("cardNumber")
                    val validDate = data?.getStringExtra("validDate")
                    val params = WritableNativeMap()
                    params.putString("cardNumber", number ?: "")
                    params.putString("cardExpiredDate", "")
                    params.putString("cardValidDate", "")
                    promiseResult.resolve(params)
                }
                Activity.RESULT_CANCELED -> {
                    Log.i("HIEU", "Scan canceled")
                }
                else -> {
                    Log.i("HIEU", "Scan failed")
                }
            }
        }
    }

    override fun onNewIntent(intent: Intent?) {

    }
}
