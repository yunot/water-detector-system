package com.isoftstone.warehouse.service;

import java.io.IOException;
import java.io.InputStream;

import org.springframework.http.ResponseEntity;

import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.warehouse.entity.FileInfoBean;
import com.isoftstone.warehouse.entity.FileSearchBean;

public interface UploadFileService
{
    
    void addFile(String string, InputStream inputStream)
        throws IOException;
    
    ResponseEntity<byte[]> download(String fileId, String userAgent)
        throws IOException;
    
    PadingRstType<FileInfoBean> queryFileByPageList(FileSearchBean fileSearchBean, PagingBean pagingBean);
    
    FileInfoBean queryDetail(String fileInfoId);
    
    void deleteFileById(String fileId)
        throws IOException;
    
}
