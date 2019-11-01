package com.isoftstone.platform.sm.controller;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.isoftstone.platform.common.uitl.PlatformUtil;
import com.isoftstone.platform.controller.BaseController;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.platform.entity.ZTreeInfoBean;
import com.isoftstone.platform.sm.entity.UserInfoBean;
import com.isoftstone.platform.sm.entity.UserSearch;
import com.isoftstone.platform.sm.service.UserInfoService;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController
{
    
    private final static Logger logger = Logger.getLogger(UserController.class);
    
    @Resource
    private UserInfoService userInfoService;
    
    @RequestMapping("/main")
    public String initPage()
    {
        return "user/main";
    }
    
    @RequestMapping("/userList")
    public String initUserList(Model model)
    {
        return "sm/userList";
    }
    
    @RequestMapping(value = "/getCommoditylist", produces = "application/json")
    @ResponseBody
    public String getCommoditylist(UserSearch userSearch, PagingBean pagingBean)
    {
        logger.info(pagingBean);
        PadingRstType<UserInfoBean> rst = userInfoService.queryUserByPageList(userSearch, pagingBean);
        return JSON.toJSONString(rst);
    }
    
    @RequestMapping(value = "/deleteUserInfo", produces = "application/json")
    //@Log(title = "ɾ���û�", businessType = BusinessType.OTHER)
    @ResponseBody
    public String deleteUserInfo(@RequestParam("goodIds")
    String ids)
    {
        logger.info(ids);
        userInfoService.deleteUserInfo(ids);
        return buildSuccessJsonMsg("user.delete.sucess");
    }
    
    @RequestMapping(value = "/updateUserinfo", produces = "application/json")
    //@Log(title = "�޸��û�", businessType = BusinessType.OTHER)
    @ResponseBody
    public String updateUserinfo(UserInfoBean userInfoBean)
    {
        logger.info(userInfoBean);
        userInfoService.updateUserinfo(userInfoBean);
        return buildSuccessJsonMsg("user.update.sucess");
    }
    
    @RequestMapping(value = "/addUserDail", produces = "application/json")
    //@Log(title = "�����û�", businessType = BusinessType.OTHER)
    @ResponseBody
    public String addUserDail(UserInfoBean userInfoBean)
    {
        logger.info(userInfoBean);
        userInfoService.addUserDail(userInfoBean);
        return buildSuccessJsonMsg("user.add.sucess");
    }
    
    @RequestMapping(value = "/getZTreeData", produces = "application/json")
    @ResponseBody
    public String getZTreeData(String userId, HttpServletRequest request)
    {
        String menuLanguage = (String)request.getSession().getAttribute("language");
        List<ZTreeInfoBean> list = userInfoService.getZTreeData(userId, menuLanguage);
        Map<String, Object> message = new LinkedHashMap<>();
        message.put("success", true);
        message.put("list", list);
        String rst = PlatformUtil.toJSON(message);
        return rst;
    }
    
    @RequestMapping(value = "/insertUserRefRole", produces = "application/json")
    @ResponseBody
    public String insertUserRefRole(@RequestParam("roleIds")
    String roleIds, @RequestParam("userId")
    String userId)
    {
        userInfoService.insertUserRefRole(roleIds, userId);
        return buildSuccessJsonMsg("role.delete.sucess");
    }
    
    @RequestMapping(value = "/getPostZTreeData", produces = "application/json")
    @ResponseBody
    public String getPostZTreeData(String userIds, HttpServletRequest request)
    {
        List<ZTreeInfoBean> list = userInfoService.getPostZTreeData(userIds);
        Map<String, Object> message = new LinkedHashMap<>();
        message.put("success", true);
        message.put("list", list);
        String rst = PlatformUtil.toJSON(message);
        return rst;
    }
    
    @RequestMapping(value = "/insertUserRefPost", produces = "application/json")
    @ResponseBody
    public String insertUserRefPost(@RequestParam("postId")
    String postId, @RequestParam("userIds")
    String userIds)
    {
        userInfoService.insertUserRefPost(postId, userIds);
        return buildSuccessJsonMsg("sucess");
    }
    
    @RequestMapping("/updatePwd")
    //@Log(title = "�޸�����", businessType = BusinessType.OTHER)
    @ResponseBody
    public String updatePwd(UserInfoBean userinfo)
    {
        userInfoService.updateByAccount(userinfo);
        System.out.println(userinfo.toString());
        return buildSuccessJsonMsg("user.updatepwd.success");
    }
    
}
