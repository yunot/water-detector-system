package com.isoftstone.platform.sm.entity;

import com.isoftstone.platform.entity.Columns;

public class PostBean
{
    @Columns("post_id")
    private int postID;
    
    @Columns("role_id")
    private int roleId;
    
    @Columns("dep_id")
    private int depID;
    
    @Columns("org_id")
    private int orgID;
    
    @Columns("post_name")
    private String postName;
    
    @Columns("post_describe")
    private String postDescribe;
    
    @Columns("creat_time")
    private String creatTime;
    
    @Columns("modify_time")
    private String modifyTime;
    
    @Columns("role_name")
    private String roleName;
    
    public String getRoleName()
    {
        return roleName;
    }
    
    public void setRoleName(String roleName)
    {
        this.roleName = roleName;
    }
    
    public int getPostID()
    {
        return postID;
    }
    
    public void setPostID(int postID)
    {
        this.postID = postID;
    }
    
    public int getRoleId()
    {
        return roleId;
    }
    
    public void setRoleId(int roleId)
    {
        this.roleId = roleId;
    }
    
    public int getDepID()
    {
        return depID;
    }
    
    public void setDepID(int depID)
    {
        this.depID = depID;
    }
    
    public int getOrgID()
    {
        return orgID;
    }
    
    public void setOrgID(int orgID)
    {
        this.orgID = orgID;
    }
    
    public String getPostName()
    {
        return postName;
    }
    
    public void setPostName(String postName)
    {
        this.postName = postName;
    }
    
    public String getPostDescribe()
    {
        return postDescribe;
    }
    
    public void setPostDescribe(String postDescribe)
    {
        this.postDescribe = postDescribe;
    }
    
    public String getCreatTime()
    {
        return creatTime;
    }
    
    public void setCreatTime(String creatTime)
    {
        this.creatTime = creatTime;
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
