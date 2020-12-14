package com.lijiaqi.bedrock.test;

import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.os.Bundle;

import com.lijiaqi.flutter_bedrock.R;

public class TestPage2 extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_test_page2);
    }

    @Override
    protected void onResume() {
        super.onResume();
        throw new RuntimeException("TestPage2 : onResume 发生了一个异常");
    }
}
