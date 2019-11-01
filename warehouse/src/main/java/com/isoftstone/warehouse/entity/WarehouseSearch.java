package com.isoftstone.warehouse.entity;

public class WarehouseSearch
{
    /**
     * 商品名称
     */
    private String searchName;
    
    /**
     * 商品数量
     */
    private String searchCount;
    
    public String getSearchName()
    {
        return searchName;
    }
    
    public void setSearchName(
        String searchName)
    {
        this.searchName =
            searchName;
    }
    
    public String getSearchCount()
    {
        return searchCount;
    }
    
    public void setSearchCount(
        String searchCount)
    {
        this.searchCount =
            searchCount;
    }
    
}
