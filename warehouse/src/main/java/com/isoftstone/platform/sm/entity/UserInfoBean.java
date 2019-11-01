package com.isoftstone.platform.sm.entity;

import java.io.Serializable;

import com.isoftstone.platform.entity.Columns;

public class UserInfoBean implements Serializable
{
    @Override
    public String toString()
    {
        return "UserInfoBean [account=" + account + ", password=" + password + "]";
    }
    
    /**
     * ×¢ÊÍÄÚÈÝ
     */
    private static final long serialVersionUID = -2421517337899538211L;
    
    @Columns("user_id")
    private Long userId;
    
    @Columns("account")
    private String account;
    
    @Columns("password")
    private String password;
    
    @Columns("name")
    private String name;
    
    @Columns("gender")
    private String gender;
    
    @Columns("telephone")
    private String telephone;
    
    @Columns("email")
    private String email;
    
    @Columns("resetpwd")
    private String resetpwd;
    
    @Columns("description")
    private String description;
    
    @Columns("creator")
    private String creator;
    
    @Columns("create_time")
    private String createTime;
    
    @Columns("employee_id")
    private String employeeid;
    
    public String getPassword()
    {
        return password;
    }
    
    public void setPassword(String password)
    {
        this.password = password;
    }
    
    public void setUserid(Long userid)
    {
        this.userId = userid;
    }
    
    public String getEmployeeid()
    {
        return employeeid;
    }
    
    public void setEmployeeid(String employeeid)
    {
        this.employeeid = employeeid;
    }
    
    public Long getUserId()
    {
        return userId;
    }
    
    public void setUserId(Long userId)
    {
        this.userId = userId;
    }
    
    public String getAccount()
    {
        return account;
    }
    
    public void setAccount(String account)
    {
        this.account = account;
    }
    
    public String getName()
    {
        return name;
    }
    
    public void setName(String name)
    {
        this.name = name;
    }
    
    public String getGender()
    {
        return gender;
    }
    
    public void setGender(String gender)
    {
        this.gender = gender;
    }
    
    public String getTelephone()
    {
        return telephone;
    }
    
    public void setTelephone(String telephone)
    {
        this.telephone = telephone;
    }
    
    public String getEmail()
    {
        return email;
    }
    
    public void setEmail(String email)
    {
        this.email = email;
    }
    
    public String getResetpwd()
    {
        return resetpwd;
    }
    
    public void setResetpwd(String resetpwd)
    {
        this.resetpwd = resetpwd;
    }
    
    public String getDescription()
    {
        return description;
    }
    
    public void setDescription(String description)
    {
        this.description = description;
    }
    
    public String getCreator()
    {
        return creator;
    }
    
    public void setCreator(String creator)
    {
        this.creator = creator;
    }
    
    public String getCreateTime()
    {
        return createTime;
    }
    
    public void setCreateTime(String createTime)
    {
        this.createTime = createTime;
    }
    
}
