package com.lijiaqi.bedrock.plugin;


/*
 * Author : LiJiqqi
 * Date : 2020/7/6
 */

import android.app.Activity;
import android.app.Application;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.core.content.FileProvider;

import com.lijiaqi.bedrock.test.TestPage1;

import java.io.File;
import java.lang.ref.WeakReference;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class BedrockPlugin implements FlutterPlugin, ActivityAware, MethodChannel.MethodCallHandler {

    private static final String PLUGIN_NAME = "com.lijiaqi.bedrock";

    ///======Test zone=====
    private static final String childThreadException = "child_exception";
    private static final String uIThreadException = "ui_exception";
    private static final String startUpException = "start_up_exception";

    private MethodChannel mMethodChannel;
    private Application mApplication;
    private WeakReference<Activity> mActivity;

    public BedrockPlugin(Activity mActivity) {
        this.mActivity = new WeakReference<Activity>(mActivity);
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        mMethodChannel = new MethodChannel(binding.getBinaryMessenger(),PLUGIN_NAME);
        mApplication = (Application) binding.getApplicationContext();
        mMethodChannel.setMethodCallHandler(this);

    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        mMethodChannel.setMethodCallHandler(null);
        mMethodChannel = null;

    }


    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method){
            case "install_apk":
                invokeInstall(call.argument("path"));
                break;
            ///======= Test zone =======
            ///you can delete the code in this =Test zone=.
            case childThreadException:
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        throw new RuntimeException("抛出一个子线程异常");
                    }
                }).start();
                break;
            case uIThreadException:
            case startUpException:
                mActivity.get().startActivity(new Intent(mActivity.get(), TestPage1.class));
                break;
            ///======= Test zone =======
            default:
                break;
        }

    }

    private static final String provider = "com.lijiaqi.flutter_bedrock.fileProvider";

    //安装
    private void invokeInstall(String apkPath){
        if(apkPath != null && ! apkPath.isEmpty()){
            log(apkPath);

            Intent intent = new Intent(Intent.ACTION_VIEW);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            ///< 判断是否是AndroidN以及更高的版本
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                // 不能再用setFlags了， setflags会重置之前的设置， 要么 setflags 多个|拼接，要么addflag
                intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
                Uri contentUri = FileProvider.getUriForFile(mActivity.get(), provider, new File(apkPath));
                intent.setDataAndType(contentUri, "application/vnd.android.package-archive");
            } else {
                intent.setDataAndType(Uri.fromFile(new File(apkPath)), "application/vnd.android.package-archive");
            }
            mActivity.get().startActivity(intent);

        }
    }

    private void log(String msg){
        Log.i("native method",msg);
    }


    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {

    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {

    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

    }

    @Override
    public void onDetachedFromActivity() {

    }

}
