package com.isoftstone.warehouse.entity;

import com.isoftstone.platform.entity.Columns;

/**
 * 商口名称
 * <一句话功能简述>
 * <功能详细描述>
 * 
 * @author  fhxin
 * @version  [CBEMS V100R002C01, 2018-10-19]
 * @see  [相关类/方法]
 * @since  [产品/模块版本]
 */
public class WarehouseBean
{
    /**
     * 商品编号
     */
    @Columns("good_id")
    private Long goodId;
    
    /**
     * 商品名称
     */
    @Columns("good_name")
    private String goodName;
    
    /**
     * 商品数量
     */
    @Columns("good_count")
    private String goodCount;
    
    /**
     * 生产厂商
     */
    @Columns("producer")
    private String producer;
    
    /**
     * 商品价格
     */
    @Columns("good_price")
    private String goodPrice;
    
    public Long getGoodId()
    {
        return goodId;
    }
    
    public void setGoodId(
        Long goodId)
    {
        this.goodId = goodId;
    }
    
    public String getGoodName()
    {
        return goodName;
    }
    
    public void setGoodName(
        String goodName)
    {
        this.goodName = goodName;
    }
    
    public String getGoodCount()
    {
        return goodCount;
    }
    
    public void setGoodCount(
        String goodCount)
    {
        this.goodCount = goodCount;
    }
    
    public String getProducer()
    {
        return producer;
    }
    
    public void setProducer(
        String producer)
    {
        this.producer = producer;
    }
    
    public String getGoodPrice()
    {
        return goodPrice;
    }
    
    public void setGoodPrice(
        String goodPrice)
    {
        this.goodPrice = goodPrice;
    }
    
    @Override
    public String toString()
    {
        return "WarehouseBean [goodId="
            + goodId
            + ", goodName="
            + goodName
            + ", goodCount="
            + goodCount
            + ", producer="
            + producer
            + ", goodPrice="
            + goodPrice + "]";
    }
    
}
