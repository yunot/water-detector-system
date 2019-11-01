package com.isoftstone.platform.sm.entity;

import com.isoftstone.platform.entity.Columns;

public class ApplyBean
{
    @Columns("user_id")
    private Integer userId;
    
    @Columns("dep_id")
    private String depId;
    
    @Columns("dep_apply_id")
    private String depApplyId;
    
    @Columns("status")
    private String status;
    
    public Integer getUserId()
    {
        return userId;
    }
    
    public void setUserId(Integer userId)
    {
        this.userId = userId;
    }
    
    public String getDepId()
    {
        return depId;
    }
    
    public void setDepId(String depId)
    {
        this.depId = depId;
    }
    
    public String getDepApplyId()
    {
        return depApplyId;
    }
    
    public void setDepApplyId(String depApplyId)
    {
        this.depApplyId = depApplyId;
    }
    
    public String getStatus()
    {
        return status;
    }
    
    public void setStatus(String status)
    {
        this.status = status;
    }
    
}
