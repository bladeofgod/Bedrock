package com.lijiaqi.bedrock;


/*
 * Author : LiJiqqi
 * Date : 2020/7/6
 */

import androidx.annotation.NonNull;

import com.lijiaqi.bedrock.plugin.BedrockPlugin;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        flutterEngine.getPlugins().add(new BedrockPlugin(this));
    }
}
