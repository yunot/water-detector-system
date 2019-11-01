package com.isoftstone.rookie.system.organization.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Organization implements Serializable
{
    
    private Integer orgId;
    
    private Integer parentId;
    
    private String orgName;
    
    private String orgType;
    
    private String status;
    
    private String modifier;
    
    private String modtime;
    
    private String description;
    
    private List<Organization> children = new ArrayList<Organization>();
    
    private static final long serialVersionUID = 1L;
    
    public List<Organization> getChildren()
    {
        return children;
    }
    
    public void setChildren(List<Organization> children)
    {
        this.children = children;
    }
    
    public Integer getOrgId()
    {
        return orgId;
    }
    
    public void setOrgId(Integer orgId)
    {
        this.orgId = orgId;
    }
    
    public Integer getParentId()
    {
        return parentId;
    }
    
    public void setParentId(Integer parentId)
    {
        this.parentId = parentId;
    }
    
    public String getOrgName()
    {
        return orgName;
    }
    
    public void setOrgName(String orgName)
    {
        this.orgName = orgName == null ? null : orgName.trim();
    }
    
    public String getOrgType()
    {
        return orgType;
    }
    
    public void setOrgType(String orgType)
    {
        this.orgType = orgType == null ? null : orgType.trim();
    }
    
    public String getStatus()
    {
        return status;
    }
    
    public void setStatus(String status)
    {
        this.status = status == null ? null : status.trim();
    }
    
    public String getModifier()
    {
        return modifier;
    }
    
    public void setModifier(String modifier)
    {
        this.modifier = modifier;
    }
    
    public String getModtime()
    {
        return modtime;
    }
    
    public void setModtime(String modtime)
    {
        this.modtime = modtime;
    }
    
    public String getDescription()
    {
        return description;
    }
    
    public void setDescription(String description)
    {
        this.description = description == null ? null : description.trim();
    }
    
}