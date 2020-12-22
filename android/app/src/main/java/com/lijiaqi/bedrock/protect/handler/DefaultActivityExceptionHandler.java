package com.lijiaqi.bedrock.protect.handler;


/*
 * Author : LiJiqqi
 * Date : 2020/12/16
 */

import android.app.Activity;
import android.util.Log;



public class DefaultActivityExceptionHandler extends ActivityExceptionHandler {
    static private final String TAG = "Exception_Handler:";
    private final String slash = "------------------";
    ///

    /**
     *[protectUIThread]和[protectActivityStart]异常将会调用这个方法
     * 
     * {@link com.lijiaqi.bedrock.protect.zone.ActivityStartProtect}
     * {@link com.lijiaqi.bedrock.protect.zone.UIThreadProtect}
     */
    
    @Override
    public void onException(Activity activity, Exception e) {
        Log.i(TAG,"==========Activity(UI thread) 发生了一个异常=========");
        if(e != null)Log.d(TAG,""+e.getMessage());
        if(activity != null) activity.finish();
    }
    

   
    /**
     *子线程异常会调用此方法 ,
     * 注意，此方法内的线程切换
     * {@link com.lijiaqi.bedrock.protect.zone.ChildThreadProtect}
     */
    @Override
    public void onChildThreadException(Thread t, Throwable e) {
        Log.d(TAG, slash+TAG+slash);
        Log.d(TAG,t.getName());
        e.printStackTrace();
        Log.d(TAG, slash+TAG+slash);
    }
}
