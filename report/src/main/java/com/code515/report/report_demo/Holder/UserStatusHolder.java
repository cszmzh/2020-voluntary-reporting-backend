package com.code515.report.report_demo.Holder;

/**
 * 临时存储用户身份代码
 */
public class UserStatusHolder {

    private static final ThreadLocal<String> holder = new ThreadLocal<>();

    public static String get(){
        return holder.get()==null?"null":holder.get();
    }

    public static void set(String status){
        holder.set(status);
    }

    public static void remove(){
        holder.remove();
    }

}
