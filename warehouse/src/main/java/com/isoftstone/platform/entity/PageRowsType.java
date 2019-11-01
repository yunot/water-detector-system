package com.isoftstone.platform.entity;

import java.util.ArrayList;
import java.util.List;

public class PageRowsType
{
    private Integer id;
    
    private List<Object> cell =
        new ArrayList<Object>();
    
    public Integer getId()
    {
        return id;
    }
    
    public void setId(Integer id)
    {
        this.id = id;
    }
    
    public List<Object> getCell()
    {
        return cell;
    }
    
    public void setCell(
        List<Object> cell)
    {
        this.cell = cell;
    }
    
    public void addCell(Object obj)
    {
        this.cell.add(obj);
    }
}
