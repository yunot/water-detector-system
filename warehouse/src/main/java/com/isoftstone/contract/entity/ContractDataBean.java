package com.isoftstone.contract.entity;

import com.isoftstone.platform.entity.Columns;

public class ContractDataBean
{
    @Columns("docutment_data_id")
    private String docutmentDataId;
    
    @Columns("docutment_data_name")
    private String docutmentDataName;
    
    @Columns("docutment_data")
    private String docutmentData;
    
    @Columns("create_time")
    private String createTime;
    
    @Columns("modify_time")
    private String modifyTime;
    
    public String getDocutmentDataId()
    {
        return docutmentDataId;
    }
    
    public void setDocutmentDataId(String docutmentDataId)
    {
        this.docutmentDataId = docutmentDataId;
    }
    
    public String getDocutmentDataName()
    {
        return docutmentDataName;
    }
    
    public void setDocutmentDataName(String docutmentDataName)
    {
        this.docutmentDataName = docutmentDataName;
    }
    
    public String getDocutmentData()
    {
        return docutmentData;
    }
    
    public void setDocutmentData(String docutmentData)
    {
        this.docutmentData = docutmentData;
    }
    
    public String getCreateTime()
    {
        return createTime;
    }
    
    public void setCreateTime(String createTime)
    {
        this.createTime = createTime;
    }
    
    public String getModifyTime()
    {
        return modifyTime;
    }
    
    public void setModifyTime(String modifyTime)
    {
        this.modifyTime = modifyTime;
    }
    
}
