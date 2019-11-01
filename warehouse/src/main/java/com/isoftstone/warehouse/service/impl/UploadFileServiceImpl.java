package com.isoftstone.warehouse.service.impl;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.isoftstone.platform.common.uitl.FileUtilTool;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.warehouse.entity.FileInfoBean;
import com.isoftstone.warehouse.entity.FileSearchBean;
import com.isoftstone.warehouse.repository.UploadFileDao;
import com.isoftstone.warehouse.service.UploadFileService;

@Service("uploadFileService")
public class UploadFileServiceImpl implements UploadFileService
{
    private final static Logger logger = Logger.getLogger(UploadFileServiceImpl.class);
    
    @Value("#{propertiesConfig['local.path']}")
    private String localPath = "d:/img/";
    
    @Resource
    private UploadFileDao uploadFileDao;
    
    @Override
    public void addFile(String fileName, InputStream inputStream)
        throws IOException
    {
        
        String uuidStr = UUID.randomUUID().toString();
        
        String fileNamePath = localPath + uuidStr + "/" + fileName;
        FileInfoBean fileInfoBean = new FileInfoBean();
        fileInfoBean.setFileId(uuidStr);
        fileInfoBean.setFileName(fileName);
        
        FileUtilTool.downFile(inputStream, fileNamePath);
        
        uploadFileDao.saveFileInfo(fileInfoBean);
        
    }
    
    @Override
    public ResponseEntity<byte[]> download(String fileId, String userAgent)
        throws IOException
    {
        List<FileInfoBean> fileInfoList = uploadFileDao.queryFileInfoById(fileId);
        if (fileInfoList.size() == 0)
        {
            return null;
        }
        String fileName = fileInfoList.get(0).getFileName();
        if (userAgent.indexOf("MSIE") != -1)
        {//IE浏览器
            fileName = URLEncoder.encode(fileName, "UTF8");
        }
        else if (userAgent.indexOf("Mozilla") != -1)
        {//google,火狐浏览器
            fileName = new String(fileName.getBytes(), "ISO8859-1");
        }
        else
        {
            fileName = URLEncoder.encode(fileName, "UTF8");//其他浏览器
        }
        //response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        logger.info(userAgent);
        //        logger.info(localPath);
        //        logger.info(fileInfoList.get(0).getFileName());
        //        logger.info(fileInfoList.get(0).getFileId());
        HttpHeaders headers = new HttpHeaders();
        headers.setContentDispositionFormData("attachment", fileName);//告知浏览器以下载方式打开
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);//设置MIME类型
        File file =
            new File(localPath + File.separator + fileInfoList.get(0).getFileId() + File.separator
                + fileInfoList.get(0).getFileName());
        
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);
        
    }
    
    @Override
    public PadingRstType<FileInfoBean> queryFileByPageList(FileSearchBean fileSearchBean, PagingBean pagingBean)
    {
        pagingBean.deal(FileInfoBean.class);
        List<FileInfoBean> fileInfoBeanList = uploadFileDao.queryFileByPageList(fileSearchBean, pagingBean);
        //        log.info(JSON.toJSONString(warehouseBeanList));
        Integer total = uploadFileDao.queryFileTotal(fileSearchBean);
        //        log.info(JSON.toJSONString(total));
        
        PadingRstType<FileInfoBean> fileInfoBean = new PadingRstType<FileInfoBean>();
        fileInfoBean.setPage(pagingBean.getPage());
        fileInfoBean.setTotal(total);
        fileInfoBean.putItems(FileInfoBean.class, fileInfoBeanList);
        
        return fileInfoBean;
    }
    
    @Override
    public FileInfoBean queryDetail(String fileInfoId)
    {
        // TODO Auto-generated method stub
        return null;
    }
    
    @Override
    public void deleteFileById(String fileId)
        throws IOException
    {
        logger.info(localPath + fileId);
        FileUtilTool.deleteFile(localPath + fileId);
        uploadFileDao.deleteFileById(fileId);
    }
}
