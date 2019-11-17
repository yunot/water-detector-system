package com.isoftstone.platform.entity;

import java.lang.reflect.Field;

/**
 * 
 * <一句话功能简述>
 * <功能详细描述>
 * 
 * @author  fhxin
 * @version  [CBEMS V100R002C01, 2018-10-19]
 * @see  [相关类/方法]
 * @since  [产品/模块版本]
 */
public class PagingBean
{
    /**
     * 当前页面
     */
    private Integer page = null;
    
    /**
     * 容量
     */
    private Integer rp = null;
    
    /**
     * 数据的开始 
     */
    private Integer start = null;
    
    /**
     * 排序  asc
     */
    private String sortorder =
        null;
    
    private String sortname = null;
    
    public String getSortname()
    {
        return sortname;
    }
    
    public void setSortname(
        String sortname)
    {
        this.sortname = sortname;
    }
    
    public Integer getPage()
    {
        
        return page;
    }
    
    public void setPage(
        Integer page)
    {
        
        this.page = page;
        
        dealStartRow();
    }
    
    private void dealStartRow()
    {
        if ((this.page != null)
            && (this.rp != null))
        {
            this.start =
                (Integer.valueOf(page) - 1)
                    * Integer.valueOf(rp);
        }
    }
    
    public Integer getRp()
    {
        return rp;
    }
    
    public void setRp(Integer rp)
    {
        this.rp = rp;
        dealStartRow();
        
    }
    
    public String getSortorder()
    {
        return sortorder;
    }
    
    public void setSortorder(
        String sortorder)
    {
        this.sortorder = sortorder;
    }
    
    public Integer getStart()
    {
        return start;
    }
    
    public void setStart(
        Integer start)
    {
        this.start = start;
    }
    
    @Override
    public String toString()
    {
        return "PagingBean [page="
            + page + ", rp=" + rp
            + ", start=" + start
            + ", sortorder="
            + sortorder
            + ", sortname="
            + sortname + "]";
    }
    
    public <T> void deal(
        Class<T> class1)
    {
        if (sortname != null
            || "undefined".equals(sortname))
        {
            Field[] fields =
                class1.getDeclaredFields();
            for (Field field : fields)
            {
                if (field.getName()
                    .equals(sortname))
                {
                    if (field.isAnnotationPresent(Columns.class))
                    {
                        Columns columns =
                            field.getAnnotation(Columns.class);
                        sortname =
                            columns.value();
                    }
                    break;
                }
            }
        }
    }
}
