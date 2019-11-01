package com.isoftstone.platform.entity;

import java.io.Serializable;

public class BaseSelectBean implements Serializable
{
    /**
     * ×¢ÊÍÄÚÈÝ
     */
    private static final long serialVersionUID = 1429753788008541882L;
    
    public String getLabel()
    {
        return label;
    }
    
    public void setLabel(String label)
    {
        this.label = label;
    }
    
    public String getValue()
    {
        return value;
    }
    
    public void setValue(String value)
    {
        this.value = value;
    }
    
    private String label;
    
    private String value;
}
