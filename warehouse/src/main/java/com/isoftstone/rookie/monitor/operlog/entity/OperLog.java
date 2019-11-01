package com.isoftstone.rookie.monitor.operlog.entity;

import com.isoftstone.platform.entity.Columns;

public class OperLog
{
    
    @Columns("oper_id")
    private Long operId;
    
    @Columns("title")
    private String title;
    
    @Columns("business_type")
    private Integer businessType;
    
    @Columns("method")
    private String method;
    
    @Columns("oper_name")
    private String operName;
    
    @Columns("oper_url")
    private String operUrl;
    
    @Columns("oper_ip")
    private String operIp;
    
    @Columns("oper_param")
    private String operParam;
    
    @Columns("status")
    private Integer status;
    
    @Columns("error_msg")
    private String errorMsg;
    
    @Columns("oper_time")
    private String operTime;
    
    public Long getOperId()
    {
        return operId;
    }
    
    public void setOperId(Long operId)
    {
        this.operId = operId;
    }
    
    public String getTitle()
    {
        return title;
    }
    
    public void setTitle(String title)
    {
        this.title = title;
    }
    
    public Integer getBusinessType()
    {
        return businessType;
    }
    
    public void setBusinessType(Integer businessType)
    {
        this.businessType = businessType;
    }
    
    public String getMethod()
    {
        return method;
    }
    
    public void setMethod(String method)
    {
        this.method = method;
    }
    
    public String getOperName()
    {
        return operName;
    }
    
    public void setOperName(String operName)
    {
        this.operName = operName;
    }
    
    public String getOperUrl()
    {
        return operUrl;
    }
    
    public void setOperUrl(String operUrl)
    {
        this.operUrl = operUrl;
    }
    
    public String getOperIp()
    {
        return operIp;
    }
    
    public void setOperIp(String operIp)
    {
        this.operIp = operIp;
    }
    
    public String getOperParam()
    {
        return operParam;
    }
    
    public void setOperParam(String operParam)
    {
        this.operParam = operParam;
    }
    
    public Integer getStatus()
    {
        return status;
    }
    
    public void setStatus(Integer status)
    {
        this.status = status;
    }
    
    public String getErrorMsg()
    {
        return errorMsg;
    }
    
    public void setErrorMsg(String errorMsg)
    {
        this.errorMsg = errorMsg;
    }
    
    public String getOperTime()
    {
        return operTime;
    }
    
    public void setOperTime(String operTime)
    {
        this.operTime = operTime;
    }
}
