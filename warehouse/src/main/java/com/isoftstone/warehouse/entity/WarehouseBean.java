package com.isoftstone.warehouse.entity;

import com.isoftstone.platform.entity.Columns;

/**
 * �̿�����
 * <һ�仰���ܼ���>
 * <������ϸ����>
 * 
 * @author  fhxin
 * @version  [CBEMS V100R002C01, 2018-10-19]
 * @see  [�����/����]
 * @since  [��Ʒ/ģ��汾]
 */
public class WarehouseBean
{
    /**
     * ��Ʒ���
     */
    @Columns("good_id")
    private Long goodId;
    
    /**
     * ��Ʒ����
     */
    @Columns("good_name")
    private String goodName;
    
    /**
     * ��Ʒ����
     */
    @Columns("good_count")
    private String goodCount;
    
    /**
     * ��������
     */
    @Columns("producer")
    private String producer;
    
    /**
     * ��Ʒ�۸�
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
