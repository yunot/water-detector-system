package com.isoftstone.platform.shiro.apacheShiro;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;

import com.alibaba.fastjson.JSON;
import com.isoftstone.platform.common.uitl.DateUtil;
import com.isoftstone.platform.shiro.CaptchaUsernamePasswordToken;
import com.isoftstone.platform.sm.controller.LogginController;
import com.isoftstone.platform.sm.entity.UserInfoBean;
import com.isoftstone.platform.sm.service.MenuService;
import com.isoftstone.platform.sm.service.UserInfoService;
import com.isoftstone.platform.sm.service.UserRoleService;

public class UserRealm extends AuthorizingRealm
{
    @Resource
    private UserInfoService userInfoService;
    
    @Resource
    private MenuService menuService;
    
    @Resource
    private UserRoleService roleService;
    
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals)
    {
        UserInfoBean user = (UserInfoBean)principals.getPrimaryPrincipal();
        Set<String> roles = new HashSet<String>();
        Set<String> menus = new HashSet<String>();
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        if (1L == user.getUserId())
        {
            info.addRole("��������Ա");
            info.addStringPermission("*:*:*");
        }
        else
        {
            roles = roleService.selectRoleKeys(user.getUserId());
            menus = menuService.selectPermsByUserId(user.getUserId());
            System.out.println(JSON.toJSONString(menus));
            info.setRoles(roles);
            info.setStringPermissions(menus);
        }
        return info;
    }
    
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken)
        throws AuthenticationException
    {
        CaptchaUsernamePasswordToken token = (CaptchaUsernamePasswordToken)authcToken;
        
        String captcha = token.getCaptcha();
        String userName = token.getUsername();
        String password = new String(token.getPassword());
        
        //        if (!AuthCaptcha(captcha))
        //        {
        //            throw new AuthenticationException("captcha is auth fail.");
        //        }
        UserInfoBean userInfo = userInfoService.autoUserInfo(userName, password);
        Session session = SecurityUtils.getSubject().getSession();
        
        if (userInfo == null)
        {
            throw new AuthenticationException("user is auth fail.");
        }
        session.setAttribute("userInfo", userInfo);
        
        ByteSource salt = ByteSource.Util.bytes(org.apache.shiro.util.ByteSource.Util.bytes(userName));
        
        AuthenticationInfo info = new SimpleAuthenticationInfo(userInfo, password, salt, getName());
        
        return info;
        
    }
    
    private boolean AuthCaptcha(String captcha)
    {
        Session session = SecurityUtils.getSubject().getSession();
        String genCaptcha = (String)session.getAttribute(LogginController.CAPTCHA_CODE_KEY);
        Date genDate = (Date)session.getAttribute(LogginController.CAPTCHA_CODE_GEN_TIME_KEY);
        if (captcha != null && captcha.equalsIgnoreCase(genCaptcha))
        {
            int minute = DateUtil.getPassMinuteTime(genDate);
            if (minute <= LogginController.EFFECTIVE_TIME)
            {
                return true;
            }
        }
        return false;
    }
}