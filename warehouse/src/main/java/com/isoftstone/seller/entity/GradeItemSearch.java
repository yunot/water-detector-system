package com.isoftstone.seller.entity;

public class GradeItemSearch
{
    /**
     * 商品名称
     */
    private String searchName;
    
    /**
     * 商品数量
     */
    private String searchCode;
    
    public String getSearchName()
    {
        return searchName;
    }
    
    public void setSearchName(String searchName)
    {
        this.searchName = searchName;
    }
    
    public String getSearchCode()
    {
        return searchCode;
    }
    
    public void setSearchCode(String searchCode)
    {
        this.searchCode = searchCode;
    }
    
}
