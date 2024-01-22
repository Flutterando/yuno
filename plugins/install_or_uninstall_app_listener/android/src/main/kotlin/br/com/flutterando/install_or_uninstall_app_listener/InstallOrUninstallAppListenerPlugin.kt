package br.com.flutterando.install_or_uninstall_app_listener

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter

/** InstallOrUninstallAppListenerPlugin */
class InstallOrUninstallAppListenerPlugin : FlutterPlugin,
    EventChannel.StreamHandler {

    private lateinit var channel: EventChannel

    private lateinit var context: Context
    private var eventSink: EventChannel.EventSink? = null
    private lateinit var receiver: BroadcastReceiver

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel =
            EventChannel(
                flutterPluginBinding.binaryMessenger,
                "br.com.flutterando.install_or_uninstall_app_listener"
            )
        channel.setStreamHandler(this)
        context = flutterPluginBinding.applicationContext
        setupBroadcastReceiver()
    }

    private fun setupBroadcastReceiver() {
        receiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                val packageName = intent.data?.encodedSchemeSpecificPart
                when (intent.action) {
                    Intent.ACTION_PACKAGE_ADDED -> eventSink?.success("Installed: $packageName")
                    Intent.ACTION_PACKAGE_REMOVED -> eventSink?.success("Uninstalled: $packageName")
                }
            }
        }

        val filter = IntentFilter().apply {
            addAction(Intent.ACTION_PACKAGE_ADDED)
            addAction(Intent.ACTION_PACKAGE_REMOVED)
            addDataScheme("package")
        }
        context.registerReceiver(receiver, filter)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        context.unregisterReceiver(receiver)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }
}
