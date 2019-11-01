package com.isoftstone.buyer.controller;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.isoftstone.buyer.entity.BuyerBean;
import com.isoftstone.buyer.entity.BuyerSearch;
import com.isoftstone.buyer.service.BuyerService;
import com.isoftstone.platform.controller.BaseController;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;

@Controller
@RequestMapping("/buyer")
public class BuyerController extends BaseController
{
    
    private final static Logger logger = Logger.getLogger(BuyerController.class);
    
    @Resource
    private BuyerService buyerService;
    
    @RequestMapping("/main")
    public String initPage()
    {
        return "buyer/main";
    }
    
    @RequiresPermissions(value = {"system:buyer:buyerInfo"})
    @RequestMapping("/buyerList")
    public String initBuyerList(Model model)
    {
        return "buyer/buyerList";
    }
    
    @RequestMapping(value = "/getBuyerlist", produces = "application/json")
    @ResponseBody
    public String getBuyerlist(BuyerSearch buyerSearch, PagingBean pagingBean)
    {
        logger.info(pagingBean);
        PadingRstType<BuyerBean> rst = buyerService.queryBuyerByPageList(buyerSearch, pagingBean);
        
        return JSON.toJSONString(rst);
    }
    
    @RequestMapping(value = "/deleteBuyerInfo", produces = "application/json")
    @ResponseBody
    public String deleteBuyerInfo(@RequestParam("buyerids")
    String ids)
    {
        logger.info(ids);
        buyerService.deleteBuyerInfo(ids);
        return buildSuccessJsonMsg("buyer.delete.sucess");
    }
    
    @RequestMapping(value = "/updateBuyerDail", produces = "application/json")
    @ResponseBody
    public String updateBuyerDail(BuyerBean buyerBean)
    {
        logger.info(buyerBean);
        buyerService.updateBuyerDail(buyerBean);
        return buildSuccessJsonMsg("buyer.update.sucess");
    }
    
    @RequestMapping(value = "/addBuyerDail", produces = "application/json")
    @ResponseBody
    public String addBuyerDail(BuyerBean buyerBean)
    {
        logger.info(buyerBean);
        buyerService.addBuyerDail(buyerBean);
        return buildSuccessJsonMsg("buyer.add.sucess");
    }
    
}
