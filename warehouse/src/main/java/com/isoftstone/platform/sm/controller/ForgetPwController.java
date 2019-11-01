package com.isoftstone.platform.sm.controller;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.isoftstone.platform.common.mail.MailException;
import com.isoftstone.platform.common.uitl.RandomUtil;
import com.isoftstone.platform.controller.BaseController;
import com.isoftstone.platform.sm.service.MailService;
import com.isoftstone.platform.sm.service.UserInfoService;

@Controller
@RequestMapping("/check")
public class ForgetPwController extends BaseController
{
    
    @Autowired
    private UserInfoService userinfoService;
    
    @Autowired
    private MailService mailService;
    
    @RequestMapping("/sendMail")
    @ResponseBody
    private String sendMail(@RequestParam("email")
    String email, ServletRequest request)
    {
        String code = RandomUtil.generateIntRandom(100000, 999999) + "";
        
        mailService.setAddress(email, getMessageHolder().getMessage("mailbox.verification.code"));
        try
        {
            // "your.verification.code.is" + " " + code + " " + ";the.effective.time.is.10.minutes"
            String array[] = {code};
            //getMessageHolder().getMessage("send.emild", array, "send.emild");
            mailService.send(getMessageHolder().getMessage("send.emild", array));
            HttpServletRequest hrequest = (HttpServletRequest)request;
            HttpSession session = hrequest.getSession();
            session.setAttribute("code", code);
            session.setMaxInactiveInterval(10 * 60);
        }
        catch (MailException e)
        {
            e.printStackTrace();
            return buildFailJsonMsg("user.sendmail.fail", e.getMessage());
        }
        return buildSuccessJsonMsg("user.sendmail.success");
    }
    
    @RequestMapping("/checkuser")
    @ResponseBody
    public String checkuser(@RequestParam("inputCode")
    String inputCode, ServletRequest request)
    {
        HttpServletRequest hrequest = (HttpServletRequest)request;
        HttpSession session = hrequest.getSession();
        String code = (String)session.getAttribute("code");
        if (inputCode.equals(code))
        {
            return buildSuccessJsonMsg("verification.sucess");
        }
        else
        {
            return buildSuccessJsonMsg("verification.failure");
        }
    }
    
    @RequestMapping("/resetPassword")
    @ResponseBody
    public String resetPassword(@RequestParam("resetemail")
    String resetemail, @RequestParam("resetPassword")
    String password)
    {
        userinfoService.updatePasswordByEmail(resetemail, password);
        return buildSuccessJsonMsg("user.reset.success");
    }
}
