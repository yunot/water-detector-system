package com.isoftstone.warehouse.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.isoftstone.warehouse.entity.IncomeBean;

@Repository("incomeDao")
public interface IncomeDao
{
    
    List<IncomeBean> getChartData();
    
}
