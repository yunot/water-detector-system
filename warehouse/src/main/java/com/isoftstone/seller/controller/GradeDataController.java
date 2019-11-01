package com.isoftstone.seller.controller;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.isoftstone.platform.controller.BaseController;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.seller.entity.GradeDataBean;
import com.isoftstone.seller.entity.GradeDataSearch;
import com.isoftstone.seller.service.GradeDataService;

@Controller
@RequestMapping("/gradeData")
public class GradeDataController extends BaseController
{
    private final static Logger logger = Logger.getLogger(GradeDataController.class);
    
    @Resource
    private GradeDataService gradeDataService;
    
    @RequestMapping("/gradeData")
    public String initPage()
    {
        return "seller/gradeData";
    }
    
    /*@RequestMapping("/gradeData")
    public String initWarehouseList(Model model)
    {
        return "seller/gradeData";
    }*/
    
    @RequestMapping(value = "/getCommoditylist", produces = "application/json")
    @ResponseBody
    public String getCommoditylist(GradeDataSearch gradeDataSearch, PagingBean pagingBean)
    {
        logger.info(pagingBean);
        PadingRstType<GradeDataBean> rst = gradeDataService.queryGradeDataByPageList(gradeDataSearch, pagingBean);
        
        return JSON.toJSONString(rst);
    }
    
    @RequestMapping(value = "/deleteGradeData", produces = "application/json")
    @ResponseBody
    public String deleteGradeData(@RequestParam("goodIds")
    String ids)
    {
        logger.info(ids);
        gradeDataService.deleteGradeData(ids);
        return buildSuccessJsonMsg("gradedata.delete.sucess");
    }
    
    @RequestMapping(value = "/updateGradeData", produces = "application/json")
    @ResponseBody
    public String updateGradeData(GradeDataBean gradeDataBean)
    {
        logger.info(gradeDataBean);
        gradeDataService.updateGradeData(gradeDataBean);
        return buildSuccessJsonMsg("gradedata.update.sucess");
    }
    
    @RequestMapping(value = "/addGradeData", produces = "application/json")
    @ResponseBody
    public String addGradeData(GradeDataBean gradeDataBean)
    {
        logger.info(gradeDataBean);
        gradeDataService.addGradeData(gradeDataBean);
        return buildSuccessJsonMsg("gradedata.add.sucess");
    }
    
}