package com.magicstep.cube.buynow


import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import android.app.NotificationChannel

import android.app.NotificationManager
import android.content.Context
import android.net.Uri
import android.os.Build
import androidx.annotation.RequiresApi
import androidx.annotation.NonNull



class MainActivity: FlutterActivity() {
   
    
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
       

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val notificationChannel = NotificationChannel("your_channel_id", "your_channel_name", NotificationManager.IMPORTANCE_HIGH)
            
            val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(notificationChannel)
        }
        

        
    }
}

 // companion object {
    //     private const val CHANNEL = "upi_payment"
    // }
    // private val GOOGLE_PAY_PACKAGE_NAME = "com.google.android.apps.nbu.paisa.user"
    // private val GOOGLE_PAY_REQUEST_CODE = 123

 // MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
        //     if (call.method == "initiateTransaction") {
        //         val merchantVpa = call.argument<String>("merchantVpa")
        //         val merchantName = call.argument<String>("merchantName")
        //         val merchantCode = call.argument<String>("merchantCode")
        //         val transactionRefId = call.argument<String>("transactionRefId")
        //         val transactionNote = call.argument<String>("transactionNote")
        //         val orderAmount = call.argument<String>("orderAmount")
        //         val transactionUrl = call.argument<String>("transactionUrl")

        //         // Build the UPI URI
        //         val uri = Uri.Builder()
        //             .scheme("upi")
        //             .authority("pay")
        //             .appendQueryParameter("pa", merchantVpa)
        //             .appendQueryParameter("pn", merchantName)
        //             .appendQueryParameter("mc", merchantCode)
        //             .appendQueryParameter("tr", transactionRefId)
        //             .appendQueryParameter("tn", transactionNote)
        //             .appendQueryParameter("am", orderAmount)
        //             .appendQueryParameter("cu", "INR")
        //             .appendQueryParameter("url", transactionUrl)
        //             .build()

        //         // Initiate the UPI transaction using the Google Pay app
        //         val intent = Intent(Intent.ACTION_VIEW)
        //         intent.data = uri
        //         intent.setPackage(GOOGLE_PAY_PACKAGE_NAME)
        //         startActivityForResult(intent, GOOGLE_PAY_REQUEST_CODE)

        //         result.success(null)
        //     } else {
        //         result.notImplemented()
        //     }
        // }
