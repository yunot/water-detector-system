package com.isoftstone.warehouse.entity;

public class IncomeBean
{
    /**
     * 收入Id
     */
    private int incomeId;
    
    /**
     * 年份
     */
    private String year;
    
    /**
     * 收入
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
