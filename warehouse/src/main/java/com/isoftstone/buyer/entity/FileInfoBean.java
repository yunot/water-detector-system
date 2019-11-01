package com.isoftstone.buyer.entity;

import com.isoftstone.platform.entity.Columns;

public class FileInfoBean
{
    
    private int id;
    
    @Columns("file_id")
    private String fileId;
    
    @Columns("file_name")
    private String fileName;
    
    public int getId()
    {
        return id;
    }
    
    public void setId(int id)
    {
        this.id = id;
    }
    
    public String getFileId()
    {
        return fileId;
    }
    
    public void setFileId(
        String fileId)
    {
        this.fileId = fileId;
    }
    
    public String getFileName()
    {
        return fileName;
    }
    
    public void setFileName(
        String fileName)
    {
        this.fileName = fileName;
    }
    
}
