package com.isoftstone.platform.entity;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

public class PadingRstType<T>
{
    private final static Logger log =
        Logger.getLogger(PadingRstType.class);
    
    private Integer total;
    
    private Integer page;
    
    private List<PageRowsType> rows =
        new ArrayList<PageRowsType>();
    
    private List<Object> columns =
        new ArrayList<>();
    
    private List<T> rawRecords;
    
    public Integer getTotal()
    {
        return total;
    }
    
    public void setTotal(
        Integer total)
    {
        this.total = total;
    }
    
    public Integer getPage()
    {
        return page;
    }
    
    public void setPage(
        Integer page)
    {
        this.page = page;
    }
    
    public List<PageRowsType> getRows()
    {
        return rows;
    }
    
    public void setRows(
        List<PageRowsType> rows)
    {
        this.rows = rows;
    }
    
    public List<Object> getColumns()
    {
        return columns;
    }
    
    public void setColumns(
        List<Object> columns)
    {
        this.columns = columns;
    }
    
    public List<T> getRawRecords()
    {
        return rawRecords;
    }
    
    public void setRawRecords(
        List<T> rawRecords)
    {
        this.rawRecords =
            rawRecords;
    }
    
    public void putItems(
        Class<T> classes,
        List<T> list)
    {
        rawRecords = list;
        Field[] fields =
            classes.getDeclaredFields();
        for (Field field : fields)
        {
            if (field.isAnnotationPresent(Columns.class))
            {
                columns.add(field.getName());
            }
        }
        PageRowsType pageRowsType;
        int index = 0;
        for (T item : list)
        {
            pageRowsType =
                new PageRowsType();
            pageRowsType.setId(index);
            index++;
            rows.add(pageRowsType);
            for (Field field : fields)
            {
                if (field.isAnnotationPresent(Columns.class))
                {
                    field.setAccessible(true);
                    try
                    {
                        pageRowsType.addCell(field.get(item));
                    }
                    catch (IllegalArgumentException e)
                    {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                    catch (IllegalAccessException e)
                    {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                }
            }
        }
        
    }
}
