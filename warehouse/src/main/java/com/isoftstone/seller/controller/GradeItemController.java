package com.isoftstone.seller.controller;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.isoftstone.platform.controller.BaseController;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.seller.entity.GradeItemBean;
import com.isoftstone.seller.entity.GradeItemSearch;
import com.isoftstone.seller.service.GradeItemService;

@Controller
@RequestMapping("/gradeitem")
public class GradeItemController extends BaseController
{
    
    private final static Logger logger = Logger.getLogger(GradeItemController.class);
    
    @Resource
    private GradeItemService gradeItemService;
    
    @RequiresPermissions(value = {"system:grade:item"})
    @RequestMapping("/gradeitem")
    public String initGradeItemList(Model model)
    {
        return "seller/gradeitem";
    }
    
    @RequestMapping("/main")
    public String initPage()
    {
        return "seller/main";
    }
    
    @RequestMapping(value = "/getGradeItemlist", produces = "application/json")
    @ResponseBody
    public String getGradeItemlist(GradeItemSearch gradeItemSearch, PagingBean pagingBean)
    {
        logger.info(pagingBean);
        PadingRstType<GradeItemBean> rst = gradeItemService.queryGradeItemByPageList(gradeItemSearch, pagingBean);
        
        return JSON.toJSONString(rst);
    }
    
    @RequestMapping(value = "/deleteGradeItemInfo", produces = "application/json")
    @ResponseBody
    public String deleteGradeItemInfo(@RequestParam("itemIds")
    String ids)
    {
        logger.info(ids);
        gradeItemService.deleteGradeItemInfo(ids);
        return buildSuccessJsonMsg("gradeItem.delete.sucess");
    }
    
    @RequestMapping(value = "/updateGradeItemDail", produces = "application/json")
    @ResponseBody
    public String updateGradeItemDail(GradeItemBean gradeItemBean)
    {
        logger.info(gradeItemBean);
        gradeItemService.updateGradeItemDail(gradeItemBean);
        return buildSuccessJsonMsg("gradeItem.update.sucess");
    }
    
    @RequestMapping(value = "/addGradeItemDail", produces = "application/json")
    @ResponseBody
    public String addGradeItemDail(GradeItemBean gradeItemBean)
    {
        logger.info(gradeItemBean);
        gradeItemService.addGradeItemDail(gradeItemBean);
        return buildSuccessJsonMsg("gradeItem.add.sucess");
    }
    
}
