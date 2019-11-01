package com.isoftstone.warehouse.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.warehouse.entity.FileInfoBean;
import com.isoftstone.warehouse.entity.FileSearchBean;

@Repository("uploadFileDao")
public interface UploadFileDao
{
    
    void saveFileInfo(@Param("fileInfo")
    FileInfoBean fileInfoBean);
    
    List<FileInfoBean> queryFileInfoById(@Param("fileId")
    String fileId);
    
    List<FileInfoBean> queryFileByPageList(@Param("search")
    FileSearchBean fileSearchBean, @Param("paging")
    PagingBean PagingBean);
    
    Integer queryFileTotal(@Param("search")
    FileSearchBean fileSearchBean);
    
    void deleteFileById(@Param("fileId")
    String fileId);
}
