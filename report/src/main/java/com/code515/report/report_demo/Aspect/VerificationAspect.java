package com.code515.report.report_demo.Aspect;

import com.code515.report.report_demo.Enums.ResultEnum;
import com.code515.report.report_demo.Exception.ReportException;
import com.code515.report.report_demo.Holder.UserOrgHolder;
import com.code515.report.report_demo.Holder.UserStatusHolder;
import com.code515.report.report_demo.Service.CheckLoginService;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class VerificationAspect {

    @Autowired
    private CheckLoginService checkLoginService;

    @Pointcut("execution(* com.code515.report.report_demo.Controller.*.*ADMIN(..))")
    public void checkAdmin(){

    }

    @Pointcut("execution(* com.code515.report.report_demo.Controller.*.*ROOT(..))")
    public void checkRoot(){

    }

    /**
     * 1.检验管理员及以上级别身份
     * @param joinPoint
     * @return
     * @throws Throwable
     */
    @Around("checkAdmin()")
    public Object verification_ADMIN(ProceedingJoinPoint joinPoint) throws Throwable {
        //如果没有登录 这里要抛出异常
        if(!checkLoginService.verification_ADMIN()){
            throw new ReportException(ResultEnum.LOGIN_ERROR);
        }
        Object obj = joinPoint.proceed();
        UserStatusHolder.remove();
        UserOrgHolder.remove();
        return obj;
    }

    /**
     * 2.检验超级管理员身份
     * @param joinPoint
     * @return
     * @throws Throwable
     */
    @Around("checkRoot()")
    public Object verification_ROOT(ProceedingJoinPoint joinPoint) throws Throwable {
        //如果没有登录 这里要抛出异常
        if(!checkLoginService.verification_ROOT()){
            throw new ReportException(ResultEnum.LOGIN_ERROR);
        }
        Object obj = joinPoint.proceed();
        UserStatusHolder.remove();
        UserOrgHolder.remove();
        return obj;
    }

}
