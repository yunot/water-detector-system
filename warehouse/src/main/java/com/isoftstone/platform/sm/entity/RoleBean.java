package com.isoftstone.platform.sm.entity;

import com.isoftstone.platform.entity.Columns;

public class RoleBean
{
    @Columns("role_id")
    private int roleId;
    
    @Columns("role_name")
    private String roleName;
    
    @Columns("role_describe")
    private String roleDescribe;
    
    @Columns("creat_time")
    private String creatTime;
    
    @Columns("modify_time")
    private String modifyTime;
    
    @Columns("english_name")
    private String englishName;
    
    public String getEnglishName()
    {
        return englishName;
    }
    
    public void setEnglishName(String englishName)
    {
        this.englishName = englishName;
    }
    
    public int getRoleId()
    {
        return roleId;
    }
    
    public void setRoleId(int roleId)
    {
        this.roleId = roleId;
    }
    
    public String getRoleName()
    {
        return roleName;
    }
    
    public void setRoleName(String roleName)
    {
        this.roleName = roleName;
    }
    
    public String getRoleDescribe()
    {
        return roleDescribe;
    }
    
    public void setRoleDescribe(String roleDescribe)
    {
        this.roleDescribe = roleDescribe;
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
    
    @Override
    public int hashCode()
    {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((creatTime == null) ? 0 : creatTime.hashCode());
        result = prime * result + ((englishName == null) ? 0 : englishName.hashCode());
        result = prime * result + ((modifyTime == null) ? 0 : modifyTime.hashCode());
        result = prime * result + ((roleDescribe == null) ? 0 : roleDescribe.hashCode());
        result = prime * result + roleId;
        result = prime * result + ((roleName == null) ? 0 : roleName.hashCode());
        return result;
    }
    
    @Override
    public boolean equals(Object obj)
    {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        RoleBean other = (RoleBean)obj;
        if (creatTime == null)
        {
            if (other.creatTime != null)
                return false;
        }
        else if (!creatTime.equals(other.creatTime))
            return false;
        if (englishName == null)
        {
            if (other.englishName != null)
                return false;
        }
        else if (!englishName.equals(other.englishName))
            return false;
        if (modifyTime == null)
        {
            if (other.modifyTime != null)
                return false;
        }
        else if (!modifyTime.equals(other.modifyTime))
            return false;
        if (roleDescribe == null)
        {
            if (other.roleDescribe != null)
                return false;
        }
        else if (!roleDescribe.equals(other.roleDescribe))
            return false;
        if (roleId != other.roleId)
            return false;
        if (roleName == null)
        {
            if (other.roleName != null)
                return false;
        }
        else if (!roleName.equals(other.roleName))
            return false;
        return true;
    }
    
}
