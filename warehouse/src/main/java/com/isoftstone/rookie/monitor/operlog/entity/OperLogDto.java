package com.isoftstone.rookie.monitor.operlog.entity;

public class OperLogDto extends OperLog
{
    
    /**
     * serialVersionUID
     */
    private static final long serialVersionUID = 4207326335579767706L;
    
    private String startTime;
    
    private String endTime;
    
    public String getStartTime()
    {
        return startTime;
    }
    
    public void setStartTime(String startTime)
    {
        this.startTime = startTime;
    }
    
    public String getEndTime()
    {
        return endTime;
    }
    
    public void setEndTime(String endTime)
    {
        this.endTime = endTime;
    }
}
