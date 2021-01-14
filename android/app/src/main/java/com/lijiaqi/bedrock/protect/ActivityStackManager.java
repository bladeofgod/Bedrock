package com.lijiaqi.bedrock.protect;

import android.app.Activity;
import android.app.Application;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.LinkedList;

/**
 * @author LiJiaqi
 * @date 2020/12/13
 * Description:
 */
public class ActivityStackManager{

    private static volatile ActivityStackManager singleton;
    public static ActivityStackManager getInstance(){
        if(singleton == null){
            synchronized (ActivityStackManager.class){
                if (singleton == null){
                    singleton = new ActivityStackManager();
                }
            }
        }
        return singleton;
    }

    final private LinkedList<Activity> activities = new LinkedList<>();

    public void init(Application app){
        app.registerActivityLifecycleCallbacks(new Application.ActivityLifecycleCallbacks() {
            @Override
            public void onActivityCreated(@NonNull Activity activity, @Nullable Bundle bundle) {
                activities.add(activity);
            }

            @Override
            public void onActivityStarted(@NonNull Activity activity) {

            }

            @Override
            public void onActivityResumed(@NonNull Activity activity) {

            }

            @Override
            public void onActivityPaused(@NonNull Activity activity) {

            }

            @Override
            public void onActivityStopped(@NonNull Activity activity) {

            }

            @Override
            public void onActivitySaveInstanceState(@NonNull Activity activity, @NonNull Bundle bundle) {

            }

            @Override
            public void onActivityDestroyed(@NonNull Activity activity) {
                activities.remove(activity);

            }
        });
    }

    public Activity exceptionBirthplaceActivity(Exception e){
        if(activities.isEmpty()) return null;
        String className = activities.getLast().getClass().getName();
        if(e.getStackTrace()[0].getClassName().contains(className)){
            return activities.getLast();
        }
        return null;
    }

}
