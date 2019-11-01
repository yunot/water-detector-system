package com.isoftstone.seller.entity;

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
public class GradeItemBean
{
    @Columns("item_id")
    private String itemId;
    
    @Columns("item_name")
    private String itemName;
    
    @Columns("item_code")
    private String itemCode;
    
    @Columns("precision")
    private String precision;
    
    @Columns("sort")
    private String sort;
    
    @Columns("weight")
    private String weight;
    
    @Columns("remark")
    private String remark;
    
    public String getItemId()
    {
        return itemId;
    }
    
    public void setItemId(String itemId)
    {
        this.itemId = itemId;
    }
    
    public String getItemName()
    {
        return itemName;
    }
    
    public void setItemName(String itemName)
    {
        this.itemName = itemName;
    }
    
    public String getPrecision()
    {
        return precision;
    }
    
    public void setPrecision(String precision)
    {
        this.precision = precision;
    }
    
    public String getWeight()
    {
        return weight;
    }
    
    public void setWeight(String weight)
    {
        this.weight = weight;
    }
    
    public String getRemark()
    {
        return remark;
    }
    
    public void setRemark(String remark)
    {
        this.remark = remark;
    }
    
    public String getItemCode()
    {
        return itemCode;
    }
    
    public void setItemCode(String itemCode)
    {
        this.itemCode = itemCode;
    }
    
    @Override
    public String toString()
    {
        return "GradeItemBean [itemId=" + itemId + ", itemName=" + itemName + ", itemCode=" + itemCode + ", precision="
            + precision + ", weight=" + weight + ", remark=" + remark + "]";
    }
    
}
