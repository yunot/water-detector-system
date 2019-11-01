package com.isoftstone.buyer.entity;

import com.isoftstone.platform.entity.Columns;

public class BuyerBean
{
    /**
     * �ɹ���id
     */
    @Columns("buyerid")
    private long buyerid;
    
    /**
      * �ɹ�������
      */
    @Columns("name")
    private String name;
    
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
