package com.lijiaqi.bedrock.protect.zone;

import android.app.Activity;
import android.app.Application;
import android.app.Instrumentation;
import android.os.Bundle;
import android.os.PersistableBundle;

import com.lijiaqi.bedrock.protect.IProtect;
import com.lijiaqi.bedrock.util.ReflexUtil;

import java.lang.reflect.Field;
import java.lang.reflect.Method;

/**
 * @author LiJiaqi
 * @date 2020/12/13
 * Description:
 * activity启动时触发的异常（onCreate,onResume 等生命周期）
 */

public class ActivityStartProtect implements IProtect {
    @Override
    public void protect(Application application) {
        new ActivityThreadHook().hookInstrumentation();
    }
}

class ActivityThreadHook{
    public void hookInstrumentation(){
        try {
            Class clazz = Class.forName("android.app.ActivityThread");
            Method currentActivityT = ReflexUtil.getMethod(clazz, "currentActivityThread");
            if(currentActivityT == null) throw  new NullPointerException();

            Object activity = currentActivityT.invoke(null);

            Field mInstrumentationField = ReflexUtil.getField(clazz, "mInstrumentation");
            if(mInstrumentationField == null) throw new NullPointerException();
            mInstrumentationField.setAccessible(true);
            Instrumentation instrumentation = (Instrumentation) mInstrumentationField.get(activity);

            InstrumentationProxy proxy = new InstrumentationProxy(instrumentation);

            mInstrumentationField.set(activity, proxy);

        } catch (Exception e){
            e.printStackTrace();
        }
    }
}

class InstrumentationProxy extends Instrumentation{
    private final Instrumentation base;

    InstrumentationProxy(Instrumentation base)throws Exception {
        super();
        this.base = base;
        ReflexUtil.copyTo(base, this);
    }

    private void onException(Exception e, Activity activity){
        e.printStackTrace();
        if(activity != null) activity.finish();
    }

    @Override
    public void callActivityOnCreate(Activity activity, Bundle icicle) {
        try {
            super.callActivityOnCreate(activity, icicle);
        }catch (Exception e){
            onException(e,activity);
        }
    }

    @Override
    public void callActivityOnCreate(Activity activity, Bundle icicle, PersistableBundle persistentState) {
        try {
            super.callActivityOnCreate(activity, icicle, persistentState);
        }catch (Exception e){
            onException(e,activity);
        }
    }

    @Override
    public void callActivityOnResume(Activity activity) {
        try {
            super.callActivityOnResume(activity);
        }catch (Exception e){
            onException(e,activity);
        }
    }

    @Override
    public void callActivityOnPause(Activity activity) {
        try {
            super.callActivityOnPause(activity);
        }catch (Exception e){
            onException(e,activity);
        }
    }

    @Override
    public void callActivityOnDestroy(Activity activity) {
        try {
            super.callActivityOnDestroy(activity);
        }catch (Exception e){
            onException(e,activity);
        }
    }

    @Override
    public void callActivityOnStop(Activity activity) {
        try {
            super.callActivityOnStop(activity);
        }catch (Exception e){
            onException(e,activity);
        }
    }

    @Override
    public void callActivityOnStart(Activity activity) {
        try {
            super.callActivityOnStart(activity);
        }catch (Exception e){
            onException(e,activity);
        }
    }
}
