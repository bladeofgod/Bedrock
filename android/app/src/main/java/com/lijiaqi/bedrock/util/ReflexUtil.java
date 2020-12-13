package com.lijiaqi.bedrock.util;

import java.lang.reflect.Field;
import java.lang.reflect.Method;

/**
 * @author LiJiaqi
 * @date 2020/12/13
 * Description:
 */

public class ReflexUtil {

    public static Field getField(Class<?> clazz, String fieldName){
        try {
            Field targetField = clazz.getDeclaredField(fieldName);
            targetField.setAccessible(true);
            return targetField;

        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        }
        return null;
    }



    public static Method getMethod(Class<?> clazz, String methodName, String ... params){
        try{
            Method targetMethod = clazz.getMethod(methodName);
            targetMethod.setAccessible(true);
            return targetMethod;
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        }
        return null;
    }

    private static Field[] getFields(Class<?> clazz){
        try {

            Field[] targetFields = clazz.getDeclaredFields();
            for(Field field : targetFields){
                field.setAccessible(true);
            }
            return targetFields;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }



    public static <T> void copyTo(T fromObj,T toObj)throws Exception{
        if(fromObj == null || toObj == null)throw new NullPointerException();
        Field[] fields = getFields(fromObj.getClass());
        for(Field field : fields){
            field.setAccessible(true);
            field.set(toObj, field.get(fromObj));
        }
    }
}
