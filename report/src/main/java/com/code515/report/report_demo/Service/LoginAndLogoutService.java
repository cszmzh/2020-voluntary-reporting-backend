package com.code515.report.report_demo.Service;

import com.code515.report.report_demo.Entity.User;

public interface LoginAndLogoutService {

    /**
     * 1.登录
     * @param username  用户名
     * @param password  密码
     * @return
     */
    public User login(String username, String password);

    /**
     * 2.注销
     * @param username  用户名
     * @return
     */
    public boolean logout(String username);

}
