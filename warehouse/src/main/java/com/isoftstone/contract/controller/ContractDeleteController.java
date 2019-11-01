package com.isoftstone.contract.controller;

import java.io.IOException;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.isoftstone.contract.service.ContractDeleteService;
import com.isoftstone.platform.controller.BaseController;

@Controller
@RequestMapping(value = "/contractDelete")
public class ContractDeleteController extends BaseController
{
    private static final Logger log = Logger.getLogger(ContractDeleteController.class);
    
    @Resource
    private ContractDeleteService contractDeleteService;
    
    @RequestMapping(value = "/delContractInfo", produces = "application/json")
    @ResponseBody
    public String delContractInfo(@RequestParam("infoID")
    String infoID)
        throws IOException
    {
        log.info(infoID);
        contractDeleteService.delContractInfo(infoID);
        return buildSuccessJsonMsg("É¾³ý³É¹¦");
    }
    
}