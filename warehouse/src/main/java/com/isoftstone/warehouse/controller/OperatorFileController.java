package com.isoftstone.warehouse.controller;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.alibaba.fastjson.JSON;
import com.isoftstone.platform.controller.BaseController;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.warehouse.entity.FileInfoBean;
import com.isoftstone.warehouse.entity.FileSearchBean;
import com.isoftstone.warehouse.service.UploadFileService;

@Controller
@RequestMapping(value = "/file")
public class OperatorFileController extends BaseController
{
    private final static Logger logger = Logger.getLogger(OperatorFileController.class);
    
    @Value("#{propertiesConfig['local.path']}")
    private String localPath = "d:/img";
    
    @Resource
    private UploadFileService uploadFileService;
    
    @RequestMapping(value = "/uploadPage")
    public String uploadPage(HttpServletRequest request)
    {
        request.setAttribute("localPath", localPath);
        return "upload/page";
    }
    
    @RequestMapping(value = "/addFile", produces = "application/json")
    @ResponseBody
    public String addFile(HttpServletRequest request)
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
        uploadFileService.addFile(fileItem.getName(), fileItem.getInputStream());
        //TODO
        return buildSuccessJsonMsg("up.load.success");
    }
    
    @RequestMapping(value = "/download/{fileId}")
    @ResponseBody
    public ResponseEntity<byte[]> download(@PathVariable("fileId")
    String fileId, HttpServletRequest request)
        throws IOException
    {
        String userAgent = request.getHeader("USER-AGENT");
        logger.info(fileId);
        ResponseEntity<byte[]> rsp = uploadFileService.download(fileId, userAgent);
        return rsp;
    }
    
    @RequestMapping(value = "/getFilelist", produces = "application/json")
    @ResponseBody
    public String getFilelist(FileSearchBean fileSearchBean, PagingBean pagingBean)
    {
        logger.info(pagingBean);
        PadingRstType<FileInfoBean> rst = uploadFileService.queryFileByPageList(fileSearchBean, pagingBean);
        
        return JSON.toJSONString(rst);
    }
    
    @RequestMapping(value = "/deleteFile", produces = "application/json")
    @ResponseBody
    public String deleteFile(@RequestParam("fileId")
    String fileId)
        throws Exception
    {
        logger.info(fileId);
        uploadFileService.deleteFileById(fileId);
        //删除日志
        return buildSuccessJsonMsg("file.op.success");
        
    }
    
}
