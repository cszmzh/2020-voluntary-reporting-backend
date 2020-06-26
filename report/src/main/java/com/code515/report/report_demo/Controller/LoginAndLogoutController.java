package com.code515.report.report_demo.Controller;

import com.code515.report.report_demo.Entity.User;
import com.code515.report.report_demo.Service.LoginAndLogoutService;
import com.code515.report.report_demo.VO.ResultVO;
import com.code515.report.report_demo.VO.userInfoVO.LoginResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user")
public class LoginAndLogoutController {

    @Autowired
    private LoginAndLogoutService loginAndLogoutService;

    /**
     * 1.登录接口
     * @param username  用户名
     * @param password  密码
     * @return ResultVO
     */
    @PostMapping("/login")
    public ResultVO login(@RequestParam("username")String username, @RequestParam("password")String password){
        User user = loginAndLogoutService.login(username,password);
        if(user!=null){

            LoginResult loginResult = new LoginResult();
            loginResult.setUsername(username);
            loginResult.setStatus(user.getUserStatus());

            ResultVO resultVO = new ResultVO(0,"登录成功");
            resultVO.setData(loginResult);

            return resultVO;
        }
        return new ResultVO(1,"登录失败");
    }

    /**
     * 2.注销接口
     * @param username  用户名
     * @return
     */
    @PostMapping("/logout")
    public ResultVO logout(@RequestParam("username")String username){
        if(loginAndLogoutService.logout(username)){
            return new ResultVO(0,"注销成功");
        }
        return new ResultVO(1,"注销失败");
    }
}
