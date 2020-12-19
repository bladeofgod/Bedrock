package com.lijiaqi.bedrock.protect.zone;

import android.app.Application;
import android.content.Context;
import android.util.Log;

import com.lijiaqi.bedrock.protect.AndroidPlatformProtect;
import com.lijiaqi.bedrock.protect.IProtect;
import com.lijiaqi.bedrock.protect.handler.ActivityExceptionHandler;


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
    private final ActivityExceptionHandler exceptionHandler;
    private final Context context;
    ChildThreadHandler(Context context){
        this.context = context;
        this.exceptionHandler = AndroidPlatformProtect.getInstance().getExceptionHandler();
        if(exceptionHandler == null) throw new RuntimeException("ActivityExceptionHandler is null," +
                " you must set a exceptionHandler, that subclass of the ActivityExceptionHandler.");
    }

    ///处理子线程异常
    public void initChildThreadProtect(){
        Thread.setDefaultUncaughtExceptionHandler(this);
    }
    ///处理子线程异常
    @Override
    public void uncaughtException(Thread t, Throwable e) {
        exceptionHandler.onChildThreadException(t, e);
    }
}