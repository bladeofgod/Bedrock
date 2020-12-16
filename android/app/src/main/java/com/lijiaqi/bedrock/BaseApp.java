package com.lijiaqi.bedrock;

import com.lijiaqi.bedrock.protect.AndroidPlatformProtect;
import com.lijiaqi.bedrock.protect.handler.DefaultActivityExceptionHandler;

import io.flutter.app.FlutterApplication;

/**
 * @author LiJiaqi
 * @date 2020/12/12
 * Description:
 */
public class BaseApp extends FlutterApplication {
    @Override
    public void onCreate() {
        super.onCreate();

        // 如果是纯flutter项目，
        // 可以考虑注释掉这两个保护[protectUIThread]和[protectActivityStart]
        //  混合项目的话，可以考虑开启
        AndroidPlatformProtect.getInstance(new DefaultActivityExceptionHandler())
                ///处理UI线程的异常
                //.protectUIThread()
                ///处理 activity启动时的异常
                //注释原因： <activity启动保护> 功能，使用了反射。
                //          在混淆下可能会无效或者出现无法预知的问题，建议开启后反复测试
                //.protectActivityStart()
                ///处理子线程异常
                .protectChildThread()
                .init(this);
    }
}
