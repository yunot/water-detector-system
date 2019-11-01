package com.isoftstone.platform.shiro;

import org.apache.shiro.authc.UsernamePasswordToken;

public class CaptchaUsernamePasswordToken
    extends UsernamePasswordToken
{
    /**
     * ×¢ÊÍÄÚÈÝ
     */
    private static final long serialVersionUID =
        2873488723127579539L;
    
    public CaptchaUsernamePasswordToken()
    {
        
        super();
        
    }
    
    public CaptchaUsernamePasswordToken(
        String username,
        String password,
        boolean rememberMe,
        String host, String captcha)
    {
        super(username, password,
            rememberMe, host);
        
        this.captcha = captcha;
        
    }
    
    /**
     * ÑéÖ¤Âë
     **/
    private String captcha;
    
    public String getCaptcha()
    {
        return captcha;
    }
    
    public void setCaptcha(
        String captcha)
    {
        this.captcha = captcha;
    }
    
}
