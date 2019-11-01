package com.isoftstone.seller.entity;

import com.isoftstone.platform.entity.Columns;

public class SellerInfoBean
{
    /**
     * 供应商ID
     */
    @Columns("supplierid")
    private String supplierid;
    
    /**
     * 供应商名称
     */
    @Columns("seller_name")
    private String sellerName;
    
    /**
     * 联系人
     */
    @Columns("linkman")
    private String linkman;
    
    /**
     * 联系电话
     */
    @Columns("linktel")
    private String linktel;
    
    /**
     * 联系地址
     */
    @Columns("address")
    private String address;
    
    public String getSupplierid()
    {
        return supplierid;
    }
    
    public void setSupplierid(String supplierid)
    {
        this.supplierid = supplierid;
    }
    
    public String getSellerName()
    {
        return sellerName;
    }
    
    public void setSellerName(String sellerName)
    {
        this.sellerName = sellerName;
    }
    
    public String getLinkman()
    {
        return linkman;
    }
    
    public void setLinkman(String linkman)
    {
        this.linkman = linkman;
    }
    
    public String getLinktel()
    {
        return linktel;
    }
    
    public void setLinktel(String linktel)
    {
        this.linktel = linktel;
    }
    
    public String getAddress()
    {
        return address;
    }
    
    public void setAddress(String address)
    {
        this.address = address;
    }
    
    @Override
    public String toString()
    {
        return "SellerInfoBean [supplierid=" + supplierid + ", sellerName=" + sellerName + ", linkman=" + linkman
            + ", linktel=" + linktel + ", address=" + address + "]";
    }
    
}