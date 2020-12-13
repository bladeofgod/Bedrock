package com.lijiaqi.bedrock;

import com.lijiaqi.bedrock.protect.AndroidPlatformProtect;

import io.flutter.app.FlutterApplication;

/**
 * @author LiJiaqi
 * @date 2020/12/12
 * Description:
 */
class BaseApp extends FlutterApplication {
    @Override
    public void onCreate() {
        super.onCreate();
        AndroidPlatformProtect.getInstance()
                ///处理UI线程的异常
                .protectUIThread()
                ///处理 activity启动时的异常
                .protectActivityStart()
                ///处理子线程异常
                .protectChildThread()
                .init(this);
    }
}
