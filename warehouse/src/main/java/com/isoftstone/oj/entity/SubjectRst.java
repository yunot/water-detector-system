package com.isoftstone.oj.entity;

import java.io.Serializable;

public class SubjectRst implements Serializable
{
    /**
     * ×¢ÊÍÄÚÈÝ
     */
    private static final long serialVersionUID = -7899797750435165273L;
    
    private int state;
    
    private String errorLog;
    
    private String outLog;
    
    public int getState()
    {
        return state;
    }
    
    public void setState(int state)
    {
        this.state = state;
    }
    
    public String getErrorLog()
    {
        return errorLog;
    }
    
    public void setErrorLog(String errorLog)
    {
        this.errorLog = errorLog;
    }
    
    public String getOutLog()
    {
        return outLog;
    }
    
    public void setOutLog(String outLog)
    {
        this.outLog = outLog;
    }
    
    @Override
    public String toString()
    {
        return "SubjectRst [state=" + state + ", errorLog=" + errorLog + ", outLog=" + outLog + "]";
    }
    
}
