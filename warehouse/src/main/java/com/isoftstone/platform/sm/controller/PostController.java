package com.isoftstone.platform.sm.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.isoftstone.platform.controller.BaseController;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.platform.sm.entity.PostBean;
import com.isoftstone.platform.sm.entity.PostSearch;
import com.isoftstone.platform.sm.entity.UserInfoBean;
import com.isoftstone.platform.sm.service.PostService;
import com.isoftstone.platform.sm.service.UserInfoService;

@Controller
@RequestMapping("/post")
public class PostController extends BaseController
{
    private final static Logger logger = Logger.getLogger(PostController.class);
    
    @Resource
    private PostService postService;
    
    @Resource
    private UserInfoService userInfoService;
    
    @RequestMapping("/postManager")
    public String post(Model model, HttpServletRequest request)
    {
        return "/post/postManager";
    }
    
    @RequestMapping(value = "/getPostDataList", produces = "application/json")
    @ResponseBody
    public String getPostDataList(PostSearch postSearch, PagingBean pagingBean)
    {
        logger.info(pagingBean);
        PadingRstType<PostBean> rst = postService.getPostDataList(postSearch, pagingBean);
        
        return JSON.toJSONString(rst);
    }
    
    @RequestMapping("/queryDetail")
    public String queryDetail(HttpServletRequest request)
    {
        String postID = request.getParameter("id");
        PostBean postBean = postService.queryDetail(postID);
        Session session = SecurityUtils.getSubject().getSession();
        session.setAttribute("postID", postID);
        session.setAttribute("postList", postBean);
        return "/post/postList";
    }
    
    @RequestMapping(value = "/getCommoditylist", produces = "application/json")
    @ResponseBody
    public String getCommoditylist(@RequestParam("postID")
    String postID, PagingBean pagingBean)
    {
        
        logger.info(pagingBean);
        PadingRstType<UserInfoBean> rst = postService.queryUserByPageList(postID, pagingBean);
        
        return JSON.toJSONString(rst);
    }
    
    @RequestMapping(value = "/addPostDail", produces = "application/json")
    @ResponseBody
    public String addPostDail(PostBean postBean)
    {
        logger.info(postBean);
        postService.addPostDail(postBean);
        return buildSuccessJsonMsg("添加成功");
    }
    
    @RequestMapping(value = "/delPostUser", produces = "application/json")
    @ResponseBody
    public String deleteUserInfo(@RequestParam("postID")
    String postID, @RequestParam("userIDs")
    String userIDs)
    {
        logger.info(postID);
        logger.info(userIDs);
        postService.delPostUser(postID, userIDs);
        return buildSuccessJsonMsg("删除成功");
    }
    
    @RequestMapping(value = "/delPostDail", produces = "application/json")
    @ResponseBody
    public String deleteUserInfo(@RequestParam("postIDs")
    String ids)
    {
        logger.info(ids);
        postService.delPostDail(ids);
        return buildSuccessJsonMsg("删除成功");
    }
}
