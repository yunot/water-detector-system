package com.isoftstone.contract.controller;

import java.io.IOException;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.isoftstone.contract.service.ContractDownloadService;
import com.isoftstone.platform.controller.BaseController;

@Controller
@RequestMapping(value = "/contractDownload")
public class ContractDownloadController extends BaseController
{
    private static final Logger log = Logger.getLogger(ContractDownloadController.class);
    
    @Resource
    private ContractDownloadController contractDownloadController;
    
    @Resource
    private ContractDownloadService contractDownloadService;
    
    @RequestMapping(value = "/downloadContract/{infoID}")
    @ResponseBody
    public ResponseEntity<byte[]> downloadContract(@PathVariable("infoID")
    String infoID)
        throws IOException
    {
        log.info(infoID);
        ResponseEntity<byte[]> rsp = contractDownloadService.getWordContents(infoID);
        return rsp;
    }
}
