package com.isoftstone.rookie.system.dictionary.entity;

public class DictData
{
    
    private Long dictCode;
    
    private String dictLabel;
    
    private String dictValue;
    
    private String dictType;
    
    private String isDefault;
    
    private String status;
    
    public Long getDictCode()
    {
        return dictCode;
    }
    
    public void setDictCode(Long dictCode)
    {
        this.dictCode = dictCode;
    }
    
    public String getDictLabel()
    {
        return dictLabel;
    }
    
    public void setDictLabel(String dictLabel)
    {
        this.dictLabel = dictLabel;
    }
    
    public String getDictValue()
    {
        return dictValue;
    }
    
    public void setDictValue(String dictValue)
    {
        this.dictValue = dictValue;
    }
    
    public String getDictType()
    {
        return dictType;
    }
    
    public void setDictType(String dictType)
    {
        this.dictType = dictType;
    }
    
    public String getIsDefault()
    {
        return isDefault;
    }
    
    public void setIsDefault(String isDefault)
    {
        this.isDefault = isDefault;
    }
    
    public String getStatus()
    {
        return status;
    }
    
    public void setStatus(String status)
    {
        this.status = status;
    }
}
