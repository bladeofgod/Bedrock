package com.lijiaqi.bedrock.protect.handler;


/*
 * Author : LiJiqqi
 * Date : 2020/12/16
 * [protectUIThread]和[protectActivityStart] 异常善后类
 */

import android.app.Activity;

public abstract class ActivityExceptionHandler {

    public abstract void onException(Activity activity,Exception e);
    public abstract void onChildThreadException(Thread t, Throwable e);

}
