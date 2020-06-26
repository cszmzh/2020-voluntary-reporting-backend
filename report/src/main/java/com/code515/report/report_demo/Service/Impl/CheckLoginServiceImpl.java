package com.code515.report.report_demo.Service.Impl;

import com.code515.report.report_demo.Enums.UserStatusEnum;
import com.code515.report.report_demo.Holder.UserOrgHolder;
import com.code515.report.report_demo.Holder.UserStatusHolder;
import com.code515.report.report_demo.Service.CheckLoginService;
import com.code515.report.report_demo.Service.OrganizationService;
import com.code515.report.report_demo.Service.UserService;
import com.code515.report.report_demo.Utils.DesUtil;
import com.code515.report.report_demo.Utils.RequestAndResponseUtil;
import com.code515.report.report_demo.Entity.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.Cookie;

@Service
@Slf4j
public class CheckLoginServiceImpl implements CheckLoginService {

    @Autowired
    private UserService userService;
    @Autowired
    private OrganizationService organizationService;

//    @Autowired
//    private HttpServletRequest request;

    @Override
    public boolean verification_ADMIN() {

        Cookie[] cookies = RequestAndResponseUtil.getRequest().getCookies();

        for(Cookie cookie : cookies){
            if(cookie.getName().equals("username")){
                User user = userService.findByUserName(DesUtil.decrypt(cookie.getValue()));
                String orgName = organizationService.findNameByOrgId(user.getOrgId());

                if(user == null){
                    log.error("【验证用户失败】找不到用户：{}", DesUtil.decrypt(cookie.getValue()));
                    return false;
                }else if(user.getUserStatus().equals(UserStatusEnum.ADMIN.getCode())){
                    log.info("【验证管理员身份成功】用户名:{}", DesUtil.decrypt(cookie.getValue()));
                    UserStatusHolder.set(user.getUserStatus().toString());  //设置权限状态标识
                    UserOrgHolder.set(orgName);   //设置学生所属组织名称
                    return true;
                }else if(user.getUserStatus().equals(UserStatusEnum.ROOT.getCode())){
                    UserStatusHolder.set(user.getUserStatus().toString());
                    log.info("【验证ROOT身份成功】用户名:{}", DesUtil.decrypt(cookie.getValue()));
                    UserOrgHolder.set(orgName);   //设置学生所属组织名称
                    return true;
                }
            }
        }
        log.error("【验证用户失败】cookie不存在");
        return false;
    }

    public boolean verification_ROOT() {

        Cookie[] cookies = RequestAndResponseUtil.getRequest().getCookies();

        for(Cookie cookie : cookies){
            if(cookie.getName().equals("username")){
                User user = userService.findByUserName(DesUtil.decrypt(cookie.getValue()));
                String orgName = organizationService.findNameByOrgId(user.getOrgId());

                if(user == null){
                    log.error("【验证用户失败】找不到用户：{}", DesUtil.decrypt(cookie.getValue()));
                    return false;
                }else if(user.getUserStatus().equals(UserStatusEnum.ROOT.getCode())){
                    UserStatusHolder.set(user.getUserStatus().toString());
                    log.info("【验证ROOT身份成功】用户名:{}", DesUtil.decrypt(cookie.getValue()));
                    UserOrgHolder.set(orgName);   //设置学生所属组织名称
                    return true;
                }
            }
        }
        log.error("【验证用户失败】cookie不存在");
        return false;
    }

}
