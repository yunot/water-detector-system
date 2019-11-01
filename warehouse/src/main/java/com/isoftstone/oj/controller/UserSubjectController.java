package com.isoftstone.oj.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.isoftstone.oj.entity.UserSubjectBean;
import com.isoftstone.oj.entity.UserSubjectSearch;
import com.isoftstone.oj.service.UserSubjectService;
import com.isoftstone.platform.controller.BaseController;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.rookie.monitor.operlog.entity.OperLog;

@Controller
@RequestMapping("/subjectController")
public class UserSubjectController extends BaseController
{
    private final static Logger logger = Logger.getLogger(SubjectController.class);
    
    @Resource
    private UserSubjectService userSubjectService;
    
    @RequestMapping("/userSubject")
    public String initPage()
    {
        return "oj/userSubject";
    }
    
    @RequestMapping(value = "/getUserSubjectlist", produces = "application/json")
    @ResponseBody
    public String getUserSubjectlist(UserSubjectSearch userSubjectSearch, PagingBean pagingBean)
    {
        logger.info(pagingBean);
        PadingRstType<UserSubjectBean> rst = userSubjectService.querySubjectList(userSubjectSearch, pagingBean);
        
        return JSON.toJSONString(rst);
    }
    
    @RequestMapping(value = "/deleteUserSubject", produces = "application/json")
    @ResponseBody
    public String deleteUserSubject(@RequestParam("userSubjectIds")
    String userSubjectIds)
    {
        logger.info(userSubjectIds);
        userSubjectService.deleteUserSubject(userSubjectIds);
        return buildSuccessJsonMsg("subject.delete.success");
    }
    
    @RequestMapping(value = "/addUserSubject", produces = "application/json")
    @ResponseBody
    public String addSubject(HttpServletRequest request, UserSubjectBean userSubjectBean)
    {
        String code = request.getParameter("code");
        
        // *========数据库日志=========*//
        OperLog operLog = new OperLog();
        
        userSubjectBean.setUserJava(code);
        logger.info(userSubjectBean);
        userSubjectService.addUserSubject(userSubjectBean);
        return buildSuccessJsonMsg("userSubject.add.sucess");
    }
}
