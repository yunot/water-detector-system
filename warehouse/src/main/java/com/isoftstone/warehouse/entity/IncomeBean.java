package com.isoftstone.warehouse.entity;

public class IncomeBean
{
    /**
     * ����Id
     */
    private int incomeId;
    
    /**
     * ���
     */
    private String year;
    
    /**
     * ����
     */
    private float income;
    
    public int getIncomeId()
    {
        return incomeId;
    }
    
    public void setIncomeId(
        int incomeId)
    {
        this.incomeId = incomeId;
    }
    
    public String getYear()
    {
        return year;
    }
    
    public void setYear(String year)
    {
        this.year = year;
    }
    
    public float getIncome()
    {
        return income;
    }
    
    public void setIncome(
        float income)
    {
        this.income = income;
    }
    
}
