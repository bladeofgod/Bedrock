package com.lijiaqi.bedrock.protect.zone;

import android.app.Activity;
import android.app.Application;
import android.os.Handler;
import android.os.Looper;

import com.lijiaqi.bedrock.protect.ActivityStackManager;
import com.lijiaqi.bedrock.protect.AndroidPlatformProtect;
import com.lijiaqi.bedrock.protect.IProtect;
import com.lijiaqi.bedrock.protect.handler.ActivityExceptionHandler;

/**
 * @author LiJiaqi
 * @date 2020/12/13
 * Description:
 * 处理UI线程触发的异常，如点击按钮抛出一个异常等.
 *
 * 注意：混合项目下，简单的finish()可能并不能回到上一页
 */
public class UIThreadProtect implements IProtect {
    private final ActivityExceptionHandler exceptionHandler;

    public UIThreadProtect() {
        this.exceptionHandler = AndroidPlatformProtect.getInstance().getExceptionHandler();
        if(exceptionHandler == null) throw new RuntimeException("ActivityExceptionHandler is null," +
                " you must set a exceptionHandler, that subclass of the ActivityExceptionHandler.");
    }

    @Override
    public void protect(Application application) {
        ActivityStackManager.getInstance().init(application);
        protectActivityStart(null);

    }


    private CrashException lastException;

    private void protectActivityStart(CrashException exception){
        lastException = exception;
        new Handler(Looper.getMainLooper()).post(mainRun);
    }

    private final Runnable mainRun = new Runnable() {
        @Override
        public void run() {
            try {
                Looper.loop();
            }catch (Exception e){
                CrashException crashException = new CrashException(e);
                if(crashException.analysisException(lastException)){
                    ///进行恢复
                    Activity activity = ActivityStackManager.getInstance().exceptionBirthplaceActivity(e);
                    if(activity != null){
                        protectActivityStart(crashException);
                        ///混合项目下，简单的finish可能并不能回到上一页
                        //activity.finish();
                        exceptionHandler.onException(activity,e);
                        return;
                    }
                }
                throw  e;
            }

        }
    };
}

class CrashException extends Exception {

    private final Throwable cause;
    private final long createTime = System.currentTimeMillis();

    CrashException(Throwable cause) {
        super(cause);
        this.cause = cause;
    }

    public boolean analysisException(CrashException e){
        if(isSystemException()){
            ///系统异常 放弃恢复
            return false;
        }
        if(e == null){
            ///进行恢复
            return true;
        }
        if(createTime - e.createTime < 100){
            ///连续异常下， 放弃恢复
            return false;
        }
        return true;
    }


    private boolean isSystemException(){
        if(cause != null){
            if(cause.getStackTrace() != null){
                if(cause.getStackTrace()[0] != null){
                    StackTraceElement element = cause.getStackTrace()[0];
                    ClassLoader classLoader ;
                    try {
                        classLoader = Class.forName(element.getClassName()).getClassLoader();
                        return classLoader == null || classLoader == Exception.class.getClassLoader();
                    } catch (ClassNotFoundException e) {
                        e.printStackTrace();
                        return true;
                    }
                }else{
                    return false;
                }
            }
        }
        return false;
    }
}

