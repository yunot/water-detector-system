package com.isoftstone.buyer.entity;

import com.isoftstone.platform.entity.Columns;

public class BuyerBean
{
    /**
     * 采购商id
     */
    @Columns("buyerid")
    private long buyerid;
    
    /**
      * 采购商名称
      */
    @Columns("name")
    private String name;
    
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
    
    public void setBuyerid(long buyerid)
    {
        this.buyerid = buyerid;
    }
    
    public String getName()
    {
        return name;
    }
    
    public void setName(String name)
    {
        this.name = name;
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
        return "BuyerBean [name=" + name + ", linkman=" + linkman + ", linktel=" + linktel + ", address=" + address
            + "]";
    }
    
}
