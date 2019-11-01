package com.isoftstone.contract.service.impl;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;

import org.apache.poi.poifs.filesystem.DirectoryEntry;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.isoftstone.contract.entity.ContractInfoBean;
import com.isoftstone.contract.repository.ContractDownloadDao;
import com.isoftstone.contract.service.ContractDownloadService;

@Service("contractDownloadService")
public class ContractDownloadServiceImpl implements ContractDownloadService
{
    @Value("#{propertiesConfig['local.path']}")
    private String localPath = "";
    
    @Resource
    private ContractDownloadDao contractDownloadDao;
    
    @Override
    public ResponseEntity<byte[]> getWordContents(String infoID)
        throws IOException
    {
        String head = null;
        String body = null;
        List<ContractInfoBean> list = contractDownloadDao.queryContractInfo(infoID);
        if (list.size() == 0)
        {
            return null;
        }
        
        head = contractDownloadDao.queryData(list.get(0).getDocutmentHeadDataId());
        body = contractDownloadDao.queryData(list.get(0).getDocutmentBodyDataId());
        
        String downloadContract = "<html>" + head + body + "</html>";
        downloadContract = downloadContract.replaceAll("##", localPath);
        
        byte[] b = downloadContract.getBytes();
        ByteArrayInputStream bais = new ByteArrayInputStream(b);
        
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        
        POIFSFileSystem poifs = new POIFSFileSystem();
        
        DirectoryEntry directory = poifs.getRoot();
        directory.createDocument("WordDocument", bais);
        poifs.writeFilesystem(baos);
        bais.close();
        byte[] bRst = baos.toByteArray();
        baos.close();
        poifs.close();
        
        HttpHeaders headers = new HttpHeaders();
        String file = list.get(0).getDocutmentInfoName();
        file = URLEncoder.encode(file, "UTF-8");
        headers.setContentDispositionFormData("attachment", file + ".html");//告知浏览器以下载方式打开
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);//设置MIME类型
        
        return new ResponseEntity<byte[]>(b, headers, HttpStatus.CREATED);
        
    }
    
}
