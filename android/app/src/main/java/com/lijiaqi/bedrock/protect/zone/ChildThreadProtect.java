package com.lijiaqi.bedrock.protect.zone;

import android.app.Application;
import android.content.Context;
import android.util.Log;

import com.lijiaqi.bedrock.protect.IProtect;


/**
 * @author LiJiaqi
 * @date 2020/12/13
 * Description:
 * 处理子线程触发的异常
 */

public class ChildThreadProtect implements IProtect {
    @Override
    public void protect(Application application) {
        ChildThreadHandler.getInstance(application).initChildThreadProtect();
    }
}

/// handle the thread exception,and avoid app crash.
/// in fact,this Singleton doesn't make much sense...but,easy to use.

class ChildThreadHandler implements Thread.UncaughtExceptionHandler{
    static final String TAG = "Bedrock_Crash_Handler:";
    final String slash = "------------------";

    static private volatile ChildThreadHandler singleton;

    public static ChildThreadHandler getInstance(Context context){
        if(singleton == null){
            synchronized (ChildThreadHandler.class){
                if(singleton == null){
                    singleton = new ChildThreadHandler(context);
                }
            }
        }
        return singleton;
    }
    private Context context;
    ChildThreadHandler(Context context){
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