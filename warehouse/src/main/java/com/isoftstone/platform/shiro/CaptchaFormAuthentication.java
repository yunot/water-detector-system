package com.isoftstone.platform.shiro;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.apache.shiro.web.util.WebUtils;

public class CaptchaFormAuthentication
    extends
    FormAuthenticationFilter
{
    @Override
    protected boolean onLoginFailure(
        AuthenticationToken token,
        AuthenticationException e,
        ServletRequest request,
        ServletResponse response)
    {
        
        return super.onLoginFailure(token,
            e,
            request,
            response);
    }
    
    @Override
    protected boolean onLoginSuccess(
        AuthenticationToken token,
        Subject subject,
        ServletRequest request,
        ServletResponse response)
        throws Exception
    {
        return super.onLoginSuccess(token,
            subject,
            request,
            response);
    }
    
    @Override
    protected AuthenticationToken createToken(
        ServletRequest request,
        ServletResponse response)
    {
        String username =
            getUsername(request);
        String password =
            getPassword(request);
        String captcha =
            getCaptcha(request);
        boolean rememberMe =
            isRememberMe(request);
        String host =
            getHost(request);
        return new CaptchaUsernamePasswordToken(
            username, password,
            rememberMe, host,
            captcha);
        
    }
    
    @Override
    public void setLoginUrl(
        String loginUrl)
    {
        super.setLoginUrl(loginUrl);
    }
    
    protected String getCaptcha(
        ServletRequest request)
    {
        
        return WebUtils.getCleanParam(request,
            "captcha");
        
    }
    
}
