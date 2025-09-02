package com.example.gym_app

import android.media.Ringtone
import android.media.RingtoneManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private var ringtone: Ringtone? = null
    private val CHANNEL = "com.example.gym_app/sound"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "playAlarm") {
                playAlarmSound()
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun playAlarmSound() {
        val alarmUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM) ?: 
                       RingtoneManager.getDefaultUri(RingtoneManager.TYPE_RINGTONE)
        ringtone = RingtoneManager.getRingtone(this, alarmUri)
        ringtone?.play()
    }
}
