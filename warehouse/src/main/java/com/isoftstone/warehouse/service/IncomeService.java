package com.isoftstone.warehouse.service;

import java.util.List;

import com.isoftstone.warehouse.entity.IncomeBean;

public interface IncomeService
{
    
    List<IncomeBean> queryIncomeByYear();
    
}
