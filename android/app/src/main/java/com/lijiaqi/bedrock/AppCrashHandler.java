package com.lijiaqi.bedrock;

import android.content.Context;
import android.util.Log;

/**
 * @author LiJiaqi
 * @date 2020/12/12
 * Description:
 * handle the thread exception,and avoid app crash.
 * in fact,this Singleton doesn't make much sense...but,easy to use.
 */
class AppCrashHandler implements Thread.UncaughtExceptionHandler {

    static final String TAG = "Bedrock_Crash_Handler:";
    final String slash = "------------------";

    static private volatile AppCrashHandler singleton;

    public static AppCrashHandler getInstance(Context context){
        if(singleton == null){
            synchronized (AppCrashHandler.class){
                if(singleton == null){
                    singleton = new AppCrashHandler(context);
                }
            }
        }
        return singleton;
    }
    private Context context;
    AppCrashHandler(Context context){
        this.context = context;
    }

    ///处理子线程异常
    public void initChildThreadProtect(){
        Thread.setDefaultUncaughtExceptionHandler(this);
    }
    ///处理子线程异常
    @Override
    public void uncaughtException(Thread t, Throwable e) {
        Log.d(TAG, slash+TAG+slash);
        Log.d(TAG,t.getName());
        e.printStackTrace();
        Log.d(TAG, slash+TAG+slash);

    }
}
