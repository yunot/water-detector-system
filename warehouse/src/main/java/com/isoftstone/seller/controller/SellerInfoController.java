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
import com.isoftstone.seller.entity.SellerInfoBean;
import com.isoftstone.seller.entity.SellerInfoSearch;
import com.isoftstone.seller.service.SellerInfoService;

@Controller
@RequestMapping("/seller")
public class SellerInfoController extends BaseController
{
    
    private final static Logger logger = Logger.getLogger(SellerInfoController.class);
    
    @Resource
    private SellerInfoService sellerInfoService;
    
    @RequiresPermissions(value = {"system:seller:sellerInfo"})
    @RequestMapping("/sellerInfo")
    public String initSellerInfoList(Model model)
    {
        return "seller/sellerInfo";
    }
    
    @RequestMapping(value = "/getSellerlist", produces = "application/json")
    @ResponseBody
    public String getSellerlist(SellerInfoSearch sellerInfoSearch, PagingBean pagingBean)
    {
        logger.info(pagingBean);
        PadingRstType<SellerInfoBean> rst = sellerInfoService.querySellerInfoList(sellerInfoSearch, pagingBean);
        
        return JSON.toJSONString(rst);
    }
    
    @RequestMapping(value = "/deleteSellerInfo", produces = "application/json")
    @ResponseBody
    public String deleteSellerInfo(@RequestParam("sellerIds")
    String ids)
    {
        logger.info(ids);
        sellerInfoService.deleteSellerInfo(ids);
        return buildSuccessJsonMsg("sellerInfo.delete.sucess");
    }
    
    @RequestMapping(value = "/updateSellerInfoDail", produces = "application/json")
    @ResponseBody
    public String updateSellerInfoDail(SellerInfoBean sellerInfoBean)
    {
        logger.info(sellerInfoBean);
        sellerInfoService.updateSellerInfoDail(sellerInfoBean);
        return buildSuccessJsonMsg("sellerInfo.update.sucess");
    }
    
    @RequestMapping(value = "/addSellerInfoDail", produces = "application/json")
    @ResponseBody
    public String addSellerInfoDail(SellerInfoBean sellerInfoBean)
    {
        logger.info(sellerInfoBean);
        sellerInfoService.addSellerInfoDail(sellerInfoBean);
        return buildSuccessJsonMsg("sellerInfo.add.sucess");
    }
}
