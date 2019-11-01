package com.isoftstone.buyer.entity;

public class BuyerSearch
{
    /**
     * 采购商名称
     */
    private String searchName;
    
    /**
     * 采购商地址
     */
    private String searchAddress;
    
    public String getSearchName()
    {
        return searchName;
    }
    
    public void setSearchName(String searchName)
    {
        this.searchName = searchName;
    }
    
    public String getSearchAddress()
    {
        return searchAddress;
    }
    
    public void setSearchAddress(String searchAddress)
    {
        this.searchAddress = searchAddress;
    }
    
}
