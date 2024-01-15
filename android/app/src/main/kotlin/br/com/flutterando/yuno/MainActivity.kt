package br.com.flutterando.yuno

import android.view.KeyEvent
import android.view.MotionEvent
import android.view.InputDevice
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import android.net.Uri
import android.util.Log
import java.io.BufferedReader
import java.io.InputStreamReader

class MainActivity: FlutterActivity() {
    private val CHANNEL = "br.com.flutterando.yuno/gamepad"
    private lateinit var channel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler { call, result ->
            if (call.method == "launchApp") {
                val packageName = call.argument<String>("packageName")
                launchApp(packageName)
                result.success(null)
            }
        }
    }

    private fun launchApp(packageName: String?) {
        packageName?.let {
            val launchIntent = packageManager.getLaunchIntentForPackage(it)
            if (launchIntent != null) {
                startActivity(launchIntent)
            }
        }
    }
    

    override fun onGenericMotionEvent(event: MotionEvent): Boolean {
        if (event.source and InputDevice.SOURCE_JOYSTICK == InputDevice.SOURCE_JOYSTICK) {
            if (event.action == MotionEvent.ACTION_MOVE) {
                val hatX = event.getAxisValue(MotionEvent.AXIS_HAT_X)
                val hatY = event.getAxisValue(MotionEvent.AXIS_HAT_Y)

                Log.d("YUNO", "hatX: $hatX")
                Log.d("YUNO", "hatY: $hatY")

                when {
                    hatY == -1f -> channel.invokeMethod("dpadUpPressed", null)
                    hatY == 1f -> channel.invokeMethod("dpadDownPressed", null)
                    hatX == -1f -> channel.invokeMethod("dpadLeftPressed", null)
                    hatX == 1f -> channel.invokeMethod("dpadRightPressed", null)
                }
    
                val axisX = event.getAxisValue(MotionEvent.AXIS_X)
                val axisY = event.getAxisValue(MotionEvent.AXIS_Y)
    
                when {
                    axisY < -0.5f -> channel.invokeMethod("leftStickUp", null)
                    axisY > 0.5f -> channel.invokeMethod("leftStickDown", null)
                    axisX < -0.5f -> channel.invokeMethod("leftStickLeft", null)
                    axisX > 0.5f -> channel.invokeMethod("leftStickRight", null)
                }
                return true
            }
        }
        return super.onGenericMotionEvent(event)
    }
    
    

    override fun onKeyDown(keyCode: Int, event: KeyEvent): Boolean {
        if (event.source and InputDevice.SOURCE_GAMEPAD == InputDevice.SOURCE_GAMEPAD) {
            Log.d("YUNO", "KeyEvent: $keyCode")
            when (keyCode) {
                KeyEvent.KEYCODE_BUTTON_A -> {
                    channel.invokeMethod("buttonAPressed", null)
                    return true
                }
                KeyEvent.KEYCODE_BUTTON_B -> {
                    channel.invokeMethod("buttonBPressed", null)
                    return true
                }
                KeyEvent.KEYCODE_BUTTON_X -> {
                    channel.invokeMethod("buttonXPressed", null)
                    return true
                }
                KeyEvent.KEYCODE_BUTTON_Y -> {
                    channel.invokeMethod("buttonYPressed", null)
                    return true
                }
                KeyEvent.KEYCODE_DPAD_UP -> {
                    channel.invokeMethod("dpadUpPressed", null)
                    return true
                }
                KeyEvent.KEYCODE_DPAD_DOWN -> {
                    channel.invokeMethod("dpadDownPressed", null)
                    return true
                }
                KeyEvent.KEYCODE_DPAD_LEFT -> {
                    channel.invokeMethod("dpadLeftPressed", null)
                    return true
                }
                KeyEvent.KEYCODE_DPAD_RIGHT -> {
                    channel.invokeMethod("dpadRightPressed", null)
                    return true
                }
                KeyEvent.KEYCODE_BUTTON_THUMBL -> {
                    channel.invokeMethod("leftThumbPressed", null)
                    return true
                }
                KeyEvent.KEYCODE_BUTTON_THUMBR -> {
                    channel.invokeMethod("rightThumbPressed", null)
                    return true
                }
                KeyEvent.KEYCODE_BUTTON_START -> {
                    channel.invokeMethod("startPressed", null)
                    return true
                }
                KeyEvent.KEYCODE_BUTTON_SELECT -> {
                    channel.invokeMethod("selectPressed", null)
                    return true
                }
                KeyEvent.KEYCODE_BUTTON_L1, KeyEvent.KEYCODE_BUTTON_L2 -> {
                    channel.invokeMethod("LBPressed", null)
                    return true
                }
                KeyEvent.KEYCODE_BUTTON_R1, KeyEvent.KEYCODE_BUTTON_R2 -> {
                    channel.invokeMethod("RBPressed", null)
                    return true
                }
            }
        }
        return super.onKeyDown(keyCode, event)
    }
    
}
