package com.lijiaqi.bedrock;

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
        
        ///处理子线程异常
        AppCrashHandler.getInstance(this).initChildThreadProtect();
    }
}
