package com.isoftstone.contract.controller;

import java.io.File;
import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.alibaba.fastjson.JSON;
import com.isoftstone.contract.entity.ContractInfoBean;
import com.isoftstone.contract.entity.ContractSearch;
import com.isoftstone.contract.service.ContractService;
import com.isoftstone.contract.service.ContractUploadService;
import com.isoftstone.platform.controller.BaseController;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;

@Controller
@RequestMapping(value = "/contractUpload")
public class ContractUploadController extends BaseController
{
    private final static Logger logger = Logger.getLogger(ContractUploadController.class);
    
    @Value("#{propertiesConfig['local.path']}")
    private String localPath = "d:\\img\\";
    
    @Resource
    private ContractUploadService contractUploadService;
    
    @Resource
    private ContractService contractService;
    
    @RequestMapping("/contractManager")
    public String initContractList(Model model)
    {
        model.addAttribute("localPath", localPath);
        return "contract/contractUpload";
    }
    
    @RequestMapping(value = "/addContract", produces = "application/json")
    @ResponseBody
    public String addContract(HttpServletRequest request)
        throws Exception
    {
        
        request.setCharacterEncoding("UTF-8"); // 设置处理请求参数的编码格式
        MultipartHttpServletRequest mRequest = (MultipartHttpServletRequest)request;
        
        CommonsMultipartFile cFile = (CommonsMultipartFile)mRequest.getFile("srcFile");
        FileItem fileItem = cFile.getFileItem();
        if (fileItem.getName() == null || "".equals(fileItem.getName()))
        {
            return buildFailJsonMsg("up.load.fail", "no select fail.");
        }
        //uploadFileService.addFile(cFile.getFileItem());
        contractUploadService.addContract(fileItem.getName(), fileItem.getInputStream());
        //TODO
        return buildSuccessJsonMsg("up.load.success");
    }
    
    @RequestMapping(value = "/downloadContract/{contractId}")
    @ResponseBody
    public ResponseEntity<byte[]> download(@PathVariable("contractId")
    String contractId)
        throws IOException
    {
        
        ResponseEntity<byte[]> rsp = contractUploadService.download(contractId);
        return rsp;
    }
    
    @RequestMapping(value = "/downloadPic/{uuid}/{fileName:.+}")
    //传递图片名时带后缀名
    @ResponseBody
    public ResponseEntity<byte[]> downloadPic(@PathVariable("uuid")
    String uuid, @PathVariable("fileName")
    String fileName)
        throws IOException
    {
        String picPath = localPath + File.separator + uuid + File.separator + fileName;
        HttpHeaders headers = new HttpHeaders();
        headers.setContentDispositionFormData("attachment", fileName);//告知浏览器以下载方式打开
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);//设置MIME类型
        File file = new File(picPath);
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);
    }
    
    @RequestMapping(value = "/getContractlist", produces = "application/json")
    @ResponseBody
    public String getContractlist(ContractSearch contractSearch, PagingBean pagingBean)
    {
        logger.info(pagingBean);
        PadingRstType<ContractInfoBean> rst = contractService.queryContractByPageList(contractSearch, pagingBean);
        
        return JSON.toJSONString(rst);
    }
    
    @RequestMapping("/queryDetail")
    public String queryDetail(Model model, HttpServletRequest request)
    {
        return "/contract/contractDetail";
    }
}
