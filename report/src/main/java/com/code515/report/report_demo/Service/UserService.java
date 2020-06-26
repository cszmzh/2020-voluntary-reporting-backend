package com.code515.report.report_demo.Service;


import com.code515.report.report_demo.Entity.User;
import com.code515.report.report_demo.VO.ResultVO;

import javax.servlet.http.HttpServletRequest;

public interface UserService {

    /**
     * 1.通过用户名查找用户信息
     * @param username
     * @return
     */
    public User findByUserName(String username);

}
