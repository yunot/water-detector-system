package com.isoftstone.oj.entity;

import com.isoftstone.platform.entity.Columns;

public class UserSubjectBean
{
    @Columns("id")
    private int id;
    
    @Columns("user_java")
    private String userJava;
    
    @Columns("state")
    private int state;
    
    @Columns("e_log")
    private String eLog;
    
    @Columns("user_id")
    private Long userId;
    
    public int getId()
    {
        return id;
    }
    
    public void setId(int id)
    {
        this.id = id;
    }
    
    public String getUserJava()
    {
        return userJava;
    }
    
    public void setUserJava(String userJava)
    {
        this.userJava = userJava;
    }
    
    public int getState()
    {
        return state;
    }
    
    public void setState(int state)
    {
        this.state = state;
    }
    
    public String geteLog()
    {
        return eLog;
    }
    
    public void seteLog(String eLog)
    {
        this.eLog = eLog;
    }
    
    public Long getUserId()
    {
        return userId;
    }
    
    public void setUserId(Long userId)
    {
        this.userId = userId;
    }
    
}
