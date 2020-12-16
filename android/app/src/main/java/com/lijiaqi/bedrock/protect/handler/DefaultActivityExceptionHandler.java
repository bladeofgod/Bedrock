package com.lijiaqi.bedrock.protect.handler;


/*
 * Author : LiJiqqi
 * Date : 2020/12/16
 */

import android.app.Activity;

public class DefaultActivityExceptionHandler extends ActivityExceptionHandler {
    ///[protectUIThread]和[protectActivityStart]异常将会回调这个方法
    @Override
    public void onException(Activity activity, Exception e) {
        if(activity != null) activity.finish();
    }
}
