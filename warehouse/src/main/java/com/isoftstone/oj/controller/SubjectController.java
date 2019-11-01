package com.isoftstone.oj.controller;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.isoftstone.oj.entity.SubjectBean;
import com.isoftstone.oj.entity.SubjectSearch;
import com.isoftstone.oj.service.SubjectService;
import com.isoftstone.platform.controller.BaseController;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;

@Controller
@RequestMapping("/subjectController")
public class SubjectController extends BaseController
{
    private final static Logger logger = Logger.getLogger(SubjectController.class);
    
    @Resource
    private SubjectService subjectService;
    
    @RequestMapping("/subject")
    public String initPage()
    {
        return "oj/subject";
    }
    
    @RequestMapping(value = "/getSubjectlist", produces = "application/json")
    @ResponseBody
    public String getSubjectlist(SubjectSearch subjectSearch, PagingBean pagingBean)
    {
        logger.info(pagingBean);
        PadingRstType<SubjectBean> rst = subjectService.querySubjectList(subjectSearch, pagingBean);
        
        return JSON.toJSONString(rst);
    }
    
    @RequestMapping(value = "/deleteSubject", produces = "application/json")
    @ResponseBody
    public String deleteSubject(@RequestParam("subjectIds")
    String subjectIds)
    {
        logger.info(subjectIds);
        subjectService.deleteSubject(subjectIds);
        return buildSuccessJsonMsg("subject.delete.success");
    }
    
    @RequestMapping(value = "/updateSubject", produces = "application/json")
    @ResponseBody
    public String updateSubject(SubjectBean subjectBean)
    {
        logger.info(subjectBean);
        subjectService.updateSubject(subjectBean);
        return buildSuccessJsonMsg("subject.update.success");
    }
    
    @RequestMapping(value = "/addSubject", produces = "application/json")
    @ResponseBody
    public String addSubject(SubjectBean subjectBean)
    {
        logger.info(subjectBean);
        subjectService.addSubject(subjectBean);
        return buildSuccessJsonMsg("subject.add.success");
    }
}