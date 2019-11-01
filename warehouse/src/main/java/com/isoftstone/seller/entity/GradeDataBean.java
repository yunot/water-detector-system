package com.isoftstone.seller.entity;

import com.isoftstone.platform.entity.Columns;

public class GradeDataBean
{
    @Columns("ID")
    private String id;
    
    @Columns("SYS_RES_CODE")
    private String sysResCode;
    
    @Columns("BUYERCODE")
    private String buyrCode;
    
    @Columns("ITEM_VALUE_FACT")
    private int itemValueFact;
    
    @Columns("ITEM_VALUE_REPORT")
    private int itemValueReport;
    
    @Columns("ITEM_VALUE_APPROVE")
    private int itemValueApprove;
    
    @Columns("STATE_ID")
    private int stateId;
    
    @Columns("REMARKS")
    private String remarks;
    
    public String getId()
    {
        return id;
    }
    
    public void setId(String id)
    {
        this.id = id;
    }
    
    public String getSysResCode()
    {
        return sysResCode;
    }
    
    public void setSysResCode(String sysResCode)
    {
        this.sysResCode = sysResCode;
    }
    
    public String getBuyrCode()
    {
        return buyrCode;
    }
    
    public void setBuyrCode(String buyrCode)
    {
        this.buyrCode = buyrCode;
    }
    
    public int getItemValueFact()
    {
        return itemValueFact;
    }
    
    public void setItemValueFact(int itemValueFact)
    {
        this.itemValueFact = itemValueFact;
    }
    
    public int getItemValueReport()
    {
        return itemValueReport;
    }
    
    public void setItemValueReport(int itemValueReport)
    {
        this.itemValueReport = itemValueReport;
    }
    
    public int getItemValueApprove()
    {
        return itemValueApprove;
    }
    
    public void setItemValueApprove(int itemValueApprove)
    {
        this.itemValueApprove = itemValueApprove;
    }
    
    public int getStateId()
    {
        return stateId;
    }
    
    public void setStateId(int stateId)
    {
        this.stateId = stateId;
    }
    
    public String getRemarks()
    {
        return remarks;
    }
    
    public void setRemarks(String remarks)
    {
        this.remarks = remarks;
    }
    
}
