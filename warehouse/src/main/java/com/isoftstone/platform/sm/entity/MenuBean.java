package com.isoftstone.platform.sm.entity;

import java.io.Serializable;

public class MenuBean implements Serializable
{
    
    /**
     * ×¢ÊÍÄÚÈÝ
     */
    private static final long serialVersionUID = 357608070866685320L;
    
    private Integer menuID;
    
    private Integer parentID;
    
    private char menuType;
    
    private String menuName;
    
    private String menuUrl;
    
    private String iconClass;
    
    private String sort;
    
    public Integer getMenuID()
    {
        return menuID;
    }
    
    public void setMenuID(Integer menuID)
    {
        this.menuID = menuID;
    }
    
    public Integer getParentID()
    {
        return parentID;
    }
    
    public void setParentID(Integer parentID)
    {
        this.parentID = parentID;
    }
    
    public String getMenuName()
    {
        return menuName;
    }
    
    public void setMenuName(String menuName)
    {
        this.menuName = menuName;
    }
    
    public String getMenuUrl()
    {
        return menuUrl;
    }
    
    public void setMenuUrl(String menuUrl)
    {
        this.menuUrl = menuUrl;
    }
    
    public String getIconClass()
    {
        return iconClass;
    }
    
    public void setIconClass(String iconClass)
    {
        this.iconClass = iconClass;
    }
    
    public char getMenuType()
    {
        return menuType;
    }
    
    public void setMenuType(char menuType)
    {
        this.menuType = menuType;
    }
    
    @Override
    public int hashCode()
    {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((iconClass == null) ? 0 : iconClass.hashCode());
        result = prime * result + ((menuID == null) ? 0 : menuID.hashCode());
        result = prime * result + ((menuName == null) ? 0 : menuName.hashCode());
        result = prime * result + menuType;
        result = prime * result + ((menuUrl == null) ? 0 : menuUrl.hashCode());
        result = prime * result + ((parentID == null) ? 0 : parentID.hashCode());
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
        MenuBean other = (MenuBean)obj;
        if (iconClass == null)
        {
            if (other.iconClass != null)
                return false;
        }
        else if (!iconClass.equals(other.iconClass))
            return false;
        if (menuID == null)
        {
            if (other.menuID != null)
                return false;
        }
        else if (!menuID.equals(other.menuID))
            return false;
        if (menuName == null)
        {
            if (other.menuName != null)
                return false;
        }
        else if (!menuName.equals(other.menuName))
            return false;
        if (menuType != other.menuType)
            return false;
        if (menuUrl == null)
        {
            if (other.menuUrl != null)
                return false;
        }
        else if (!menuUrl.equals(other.menuUrl))
            return false;
        if (parentID == null)
        {
            if (other.parentID != null)
                return false;
        }
        else if (!parentID.equals(other.parentID))
            return false;
        return true;
    }

    public String getSort()
    {
        return sort;
    }

    public void setSort(String sort)
    {
        this.sort = sort;
    }
    
}
