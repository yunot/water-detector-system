package com.isoftstone.platform.sm.entity;

public class DepartmentBean
{
    
    private String depID;
    
    private String depName;
    
    private String depDesc;
    
    private String orgID;
    
    private String depParID;
    
    private String sort;
    
    public String getOrgID()
    {
        return orgID;
    }
    
    public void setOrgID(String orgID)
    {
        this.orgID = orgID;
    }
    
    public String getDepParID()
    {
        return depParID;
    }
    
    public void setDepParID(String depParID)
    {
        this.depParID = depParID;
    }
    
    public String getSort()
    {
        return sort;
    }
    
    public void setSort(String sort)
    {
        this.sort = sort;
    }
    
    public String getDepID()
    {
        return depID;
    }
    
    public void setDepID(String depID)
    {
        this.depID = depID;
    }
    
    public String getDepName()
    {
        return depName;
    }
    
    public void setDepName(String depName)
    {
        this.depName = depName;
    }
    
    public String getDepDesc()
    {
        return depDesc;
    }
    
    public void setDepDesc(String depDesc)
    {
        this.depDesc = depDesc;
    }
    
    @Override
    public String toString()
    {
        return "DepartmentBean [depID=" + depID + ", depName=" + depName + ", depDesc=" + depDesc + ", orgID=" + orgID
            + ", depParID=" + depParID + ", sort=" + sort + "]";
    }
}
