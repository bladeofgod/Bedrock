package com.lijiaqi.bedrock.protect.handler;


/*
 * Author : LiJiqqi
 * Date : 2020/12/16
 */

import android.app.Activity;
import android.util.Log;

public class DefaultActivityExceptionHandler extends ActivityExceptionHandler {
    private final String TAG = "ExceptionHandler";
    ///[protectUIThread]和[protectActivityStart]异常将会调用这个方法
    @Override
    public void onException(Activity activity, Exception e) {
        Log.d(TAG,"==========Activity(UI thread) 发生了一个异常=========");
        if(e != null)Log.d(TAG,e.getMessage());
        if(activity != null) activity.finish();
    }
}
