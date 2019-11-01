package com.isoftstone.seller.entity;

import com.isoftstone.platform.entity.Columns;

public class SellerInfoBean
{
    /**
     * ��Ӧ��ID
     */
    @Columns("supplierid")
    private String supplierid;
    
    /**
     * ��Ӧ������
     */
    @Columns("seller_name")
    private String sellerName;
    
    /**
     * ��ϵ��
     */
    @Columns("linkman")
    private String linkman;
    
    /**
     * ��ϵ�绰
     */
    @Columns("linktel")
    private String linktel;
    
    /**
     * ��ϵ��ַ
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