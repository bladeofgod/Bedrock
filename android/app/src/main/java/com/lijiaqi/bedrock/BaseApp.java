package com.lijiaqi.bedrock;

import com.lijiaqi.bedrock.protect.AndroidPlatformProtect;
import com.lijiaqi.bedrock.protect.handler.DefaultActivityExceptionHandler;

import io.flutter.app.FlutterApplication;

/**
 * @author LiJiaqi
 * @date 2020/12/12
 * Description:
 *
 * Tip 1:
 *      如果你有闪屏页优化需求，可以参考这篇文章，也许对你有所帮助。
 *      https://juejin.cn/post/6913360134429376525
 */
public class BaseApp extends FlutterApplication {
    @Override
    public void onCreate() {
        super.onCreate();

        // 如果是纯flutter项目，
        // 可以考虑注释掉这两个保护[protectUIThread]和[protectActivityStart]
        //  混合项目的话，可以考虑开启
        AndroidPlatformProtect.initProtect(new DefaultActivityExceptionHandler())
                ///处理UI线程的异常
                //.protectUIThread()
                ///处理 activity生命周期的异常
                //注释原因： <activity启动保护> 功能，使用了反射。
                //          在混淆下可能会无效或者出现无法预知的问题，建议开启后反复测试
                //.protectActivityStart()
                ///处理子线程异常
                .protectChildThread()
                .init(this);
    }
}
