package com.example.ontime
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

import io.flutter.embedding.android.FlutterFragmentActivity 

class MainActivity: FlutterActivity () {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    MapKitFactory.setLocale("YOUR_LOCALE") // Your preferred language. Not required, defaults to system language
    MapKitFactory.setApiKey("e4ff9a33-a49f-49b0-be08-411eac340721") // Your generated API key
    super.configureFlutterEngine(flutterEngine)
  }
}
