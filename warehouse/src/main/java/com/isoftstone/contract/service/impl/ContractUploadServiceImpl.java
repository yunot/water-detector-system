package com.isoftstone.contract.service.impl;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.isoftstone.contract.entity.ContractDataBean;
import com.isoftstone.contract.entity.ContractInfoBean;
import com.isoftstone.contract.repository.ContractUploadDao;
import com.isoftstone.contract.service.ContractUploadService;
import com.isoftstone.platform.common.uitl.FileUtilTool;
import com.isoftstone.warehouse.entity.FileInfoBean;
import com.isoftstone.warehouse.repository.UploadFileDao;

@Service("contractUploadService")
public class ContractUploadServiceImpl implements ContractUploadService
{
    @Value("#{propertiesConfig['local.path']}")
    private String localPath = "d:\\img\\";
    
    @Resource
    private UploadFileDao uploadFileDao;
    
    @Resource
    private ContractUploadDao contractUploadDao;
    
    @Override
    public void addContract(String fileName, InputStream inputStream)
        throws IOException
    {
        ContractDataBean contractDataHeadBean = new ContractDataBean();
        ContractDataBean contractDataBodyBean = new ContractDataBean();
        ContractInfoBean contractInfoBean = new ContractInfoBean();
        
        String uuidStr = UUID.randomUUID().toString();
        String uuidSubStr = UUID.randomUUID().toString();
        String uuidHead = UUID.randomUUID().toString();
        String uuidBody = UUID.randomUUID().toString();
        String fileNamePath = localPath + uuidStr + "/" + fileName;
        FileUtilTool.downFile(inputStream, fileNamePath);
        try
        {
            FileUtilTool.convert2Html(fileNamePath, uuidSubStr, contractDataHeadBean, contractDataBodyBean);
        }
        catch (TransformerException | ParserConfigurationException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        FileInfoBean fileInfoBean = new FileInfoBean();
        fileInfoBean.setFileId(uuidStr);
        fileInfoBean.setFileName(fileName);
        
        contractInfoBean.setDocutmentInfoName(fileName.substring(0, fileName.lastIndexOf('.')));
        contractInfoBean.setDocutmentHeadDataId(uuidHead);
        contractInfoBean.setDocutmentBodyDataId(uuidBody);
        contractInfoBean.setDocutmentPictDataId(uuidSubStr);
        
        contractDataHeadBean.setDocutmentDataId(uuidHead);
        contractDataHeadBean.setDocutmentDataName(fileName);
        
        contractDataBodyBean.setDocutmentDataId(uuidBody);
        contractDataBodyBean.setDocutmentDataName(fileName);
        uploadFileDao.saveFileInfo(fileInfoBean);
        contractUploadDao.saveContractInfo(contractInfoBean);
        contractUploadDao.saveContractData(contractDataHeadBean);
        contractUploadDao.saveContractData(contractDataBodyBean);
        
    }
    
    @Override
    public ResponseEntity<byte[]> download(String fileId)
        throws IOException
    {
        
        List<FileInfoBean> fileInfoList = uploadFileDao.queryFileInfoById(fileId);
        if (fileInfoList.size() == 0)
        {
            return null;
        }
        HttpHeaders headers = new HttpHeaders();
        headers.setContentDispositionFormData("attachment", fileInfoList.get(0).getFileName());//告知浏览器以下载方式打开
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);//设置MIME类型
        File file =
            new File(localPath + File.separator + fileInfoList.get(0).getFileId() + File.separator
                + fileInfoList.get(0).getFileName());
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);
        
    }
    
}
