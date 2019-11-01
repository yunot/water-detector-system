package com.isoftstone.warehouse.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.isoftstone.warehouse.entity.IncomeBean;
import com.isoftstone.warehouse.repository.IncomeDao;
import com.isoftstone.warehouse.service.IncomeService;

@Service("incomeService")
public class IncomeServiceImpl implements IncomeService
{
    @Resource
    private IncomeDao incomeDao;
    
    @Override
    public List<IncomeBean> queryIncomeByYear()
    {
        // TODO Auto-generated method stub
        return incomeDao.getChartData();
    }
    
}
