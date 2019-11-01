package com.isoftstone.platform.sm.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.isoftstone.platform.common.uitl.ValidateVodeUtil;
import com.isoftstone.platform.controller.BaseController;
import com.isoftstone.platform.entity.BaseSelectBean;
import com.isoftstone.platform.sm.entity.MenuBean;
import com.isoftstone.platform.sm.entity.UserInfoBean;
import com.isoftstone.platform.sm.service.MenuService;
import com.isoftstone.platform.sm.service.UserInfoService;
import com.isoftstone.platform.sm.service.UserRoleService;

@Controller
public class LogginController extends BaseController
{
    
    /** ��֤�� �ŵ�session�е�key **/
    public final static String CAPTCHA_CODE_KEY = "CAPTCHA_CODE_KEY";
    
    /** ��֤�� �ŵ�session�е�ʱ�� key **/
    public final static String CAPTCHA_CODE_GEN_TIME_KEY = "CAPTCHAE_CODE_GEN_TIME";
    
    /**
     * ��֤�����Чʱ��
     */
    public final static Integer EFFECTIVE_TIME = 10;
    
    @Resource
    private UserInfoService userInfoService;
    
    @Resource
    private UserRoleService roleService;
    
    @Resource
    private MenuService menuService;
    
    @Value(value = "#{propertiesConfig['default.language']}")
    private String defaultLanguage = "zh";
    
    @RequestMapping("/sm/main")
    public String initPage(HttpServletRequest request)
    {
        HttpSession session = request.getSession();
        String language = "zh";
        UserInfoBean userbean = (UserInfoBean)session.getAttribute("userInfo");
        String userID = userbean.getUserId().toString();
        List<MenuBean> menuList = menuService.queryMenuInfo(userID, language);
        session.setAttribute("menuList", menuList);
        List<BaseSelectBean> list = roleService.getAll();
        session.setAttribute("rolelist", list);
        return "map/mapMain";
    }
    
    @RequestMapping("/sm/login")
    public String initPage(ServletRequest request)
    {
        HttpServletRequest hrequest = (HttpServletRequest)request;
        HttpSession session = hrequest.getSession();
        String language = "zh";
        if (language == null || "".equals(language))
        {
            language = defaultLanguage;
        }
        session.setAttribute("language", language);
        return "sm/login";
    }
    
    @RequestMapping("/sm/logout")
    public String initLogoutPage(ServletRequest request)
    {
        
        return "redirect:/sm/login";
    }
    
    @RequestMapping(value = "/sm/vldtlogon", method = RequestMethod.POST)
    public String vldtlogon(ServletRequest request, HttpServletResponse response)
    {
        
        if (SecurityUtils.getSubject().isAuthenticated())
        {
            //return "redirect:/sm/main";
        	return "redirect:/map/mapMain";
        }
        request.setAttribute("tip", "verification.failure");
        return "sm/login";
    }
    
    @RequestMapping(value = "/sm/vldtlogon", method = RequestMethod.GET)
    public String vldtlogonGet()
    {
        return "redirect:/sm/login";
        
    }
    
    @RequestMapping(value = "/captchaCode")
    public void genValidateVode(HttpServletRequest request, HttpServletResponse response)
        throws IOException
    {
        
        HttpSession session = request.getSession();
        String randomString = ValidateVodeUtil.genValidateVode(response.getOutputStream());
        session.removeAttribute(CAPTCHA_CODE_KEY);
        session.removeAttribute(CAPTCHA_CODE_GEN_TIME_KEY);
        
        session.setAttribute(CAPTCHA_CODE_KEY, randomString);
        session.setAttribute(CAPTCHA_CODE_GEN_TIME_KEY, new Date());
        
    }
    
    @RequestMapping(value = "/validcodeCheck", produces = "application/json")
    @ResponseBody
    public String validcodeCheck(@RequestParam("validcode")String validcode,HttpServletRequest request)
    {
    	HttpSession session = request.getSession();
    	String codeString = (String) session.getAttribute(CAPTCHA_CODE_KEY);
    	System.out.println(codeString);
    	if (validcode.equalsIgnoreCase(codeString)) {
    		return buildSuccessJsonMsg("validcode.check.success");
		}
        return buildFailJsonMsg("validcode.check.fail");
    }
    
    @RequestMapping("/sm/regUser")
    @ResponseBody
    public String register(@RequestParam("account")
    String account, @RequestParam("name")
    String name, @RequestParam("telephone")
    String telephone, @RequestParam("email")
    String email, @RequestParam("gender")
    String gender, @RequestParam("password")
    String password)
    {
        userInfoService.register(account, name, telephone, email, gender, password);
        return buildSuccessJsonMsg("sm.register.success");
    }
}
