package com.isoftstone.contract.entity;

import com.isoftstone.platform.entity.Columns;

public class ContractInfoBean
{
    @Columns("docutment_info_id")
    private String docutmentInfoId;
    
    @Columns("docutment_info_name")
    private String docutmentInfoName;
    
    @Columns("docutment_head_data_id")
    private String docutmentHeadDataId;
    
    @Columns("docutment_body_data_id")
    private String docutmentBodyDataId;
    
    @Columns("docutment_pict_data_id")
    private String docutmentPictDataId;
    
    @Columns("create_time")
    private String createTime;
    
    @Columns("modify_time")
    private String modifyTime;
    
    public String getDocutmentInfoId()
    {
        return docutmentInfoId;
    }
    
    public void setDocutmentInfoId(String docutmentInfoId)
    {
        this.docutmentInfoId = docutmentInfoId;
    }
    
    public String getDocutmentInfoName()
    {
        return docutmentInfoName;
    }
    
    public void setDocutmentInfoName(String docutmentInfoName)
    {
        this.docutmentInfoName = docutmentInfoName;
    }
    
    public String getDocutmentHeadDataId()
    {
        return docutmentHeadDataId;
    }
    
    public void setDocutmentHeadDataId(String docutmentHeadDataId)
    {
        this.docutmentHeadDataId = docutmentHeadDataId;
    }
    
    public String getDocutmentBodyDataId()
    {
        return docutmentBodyDataId;
    }
    
    public void setDocutmentBodyDataId(String docutmentBodyDataId)
    {
        this.docutmentBodyDataId = docutmentBodyDataId;
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
    
    public String getDocutmentPictDataId()
    {
        return docutmentPictDataId;
    }
    
    public void setDocutmentPictDataId(String docutmentPictDataId)
    {
        this.docutmentPictDataId = docutmentPictDataId;
    }
    
}
