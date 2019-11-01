package com.isoftstone.platform.sm.entity;

public class UserRoleBean
{
    @Override
    public int hashCode()
    {
        final int prime = 31;
        int result = 1;
        result = prime * result + roleId;
        result = prime * result + userId;
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
        UserRoleBean other = (UserRoleBean)obj;
        if (roleId != other.roleId)
            return false;
        if (userId != other.userId)
            return false;
        return true;
    }
    
    private int roleId;
    
    private int userId;
    
    public int getRoleId()
    {
        return roleId;
    }
    
    public void setRoleId(int roleId)
    {
        this.roleId = roleId;
    }
    
    public int getUserId()
    {
        return userId;
    }
    
    public void setUserId(int userId)
    {
        this.userId = userId;
    }
}
