package com.isoftstone.platform.entity;

import java.lang.reflect.Field;

/**
 * 
 * <һ�仰���ܼ���>
 * <������ϸ����>
 * 
 * @author  fhxin
 * @version  [CBEMS V100R002C01, 2018-10-19]
 * @see  [�����/����]
 * @since  [��Ʒ/ģ��汾]
 */
public class PagingBean
{
    /**
     * ��ǰҳ��
     */
    private Integer page = null;
    
    /**
     * ����
     */
    private Integer rp = null;
    
    /**
     * ���ݵĿ�ʼ 
     */
    private Integer start = null;
    
    /**
     * ����  asc
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
