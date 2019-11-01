package com.isoftstone.platform.entity;

import java.util.HashMap;
import java.util.Map;

public class ZTreeInfoBean
{
    
    private int searchType;
    
    private int id;
    
    private int pId;
    
    private String name;
    
    private int isCheck;
    
    private int unit;
    
    private int type;
    
    private int archLevel;
    
    private Map<String, String> attrMap = new HashMap<String, String>();
    
    private int level;
    
    private boolean open = true;
    
    private boolean checked;
    
    private boolean chkDisabled;
    
    public boolean isOpen()
    {
        return open;
    }
    
    public void setOpen(boolean open)
    {
        this.open = open;
    }
    
    public boolean isChecked()
    {
        return checked;
    }
    
    public void setChecked(boolean checked)
    {
        this.checked = checked;
    }
    
    public boolean isChkDisabled()
    {
        return chkDisabled;
    }
    
    public void setChkDisabled(boolean chkDisabled)
    {
        this.chkDisabled = chkDisabled;
    }
    
    public int getSearchType()
    {
        return searchType;
    }
    
    public void setSearchType(int searchType)
    {
        this.searchType = searchType;
    }
    
    public int getId()
    {
        return id;
    }
    
    public void setId(int id)
    {
        this.id = id;
    }
    
    public int getpId()
    {
        return pId;
    }
    
    public void setpId(int pId)
    {
        this.pId = pId;
    }
    
    public String getName()
    {
        return name;
    }
    
    public void setName(String name)
    {
        this.name = name;
    }
    
    public int getIsCheck()
    {
        return isCheck;
    }
    
    public void setIsCheck(int isCheck)
    {
        this.isCheck = isCheck;
    }
    
    public int getUnit()
    {
        return unit;
    }
    
    public void setUnit(int unit)
    {
        this.unit = unit;
    }
    
    public int getType()
    {
        return type;
    }
    
    public void setType(int type)
    {
        this.type = type;
    }
    
    public int getArchLevel()
    {
        return archLevel;
    }
    
    public void setArchLevel(int archLevel)
    {
        this.archLevel = archLevel;
    }
    
    public Map<String, String> getAttrMap()
    {
        return attrMap;
    }
    
    public void setAttrMap(Map<String, String> attrMap)
    {
        this.attrMap = attrMap;
    }
    
    public int getLevel()
    {
        return level;
    }
    
    public void setLevel(int level)
    {
        this.level = level;
    }
}
