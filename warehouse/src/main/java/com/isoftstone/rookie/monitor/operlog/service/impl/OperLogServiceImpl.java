package com.isoftstone.rookie.monitor.operlog.service.impl;

import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.rookie.monitor.operlog.dao.OperLogMapper;
import com.isoftstone.rookie.monitor.operlog.entity.OperLog;
import com.isoftstone.rookie.monitor.operlog.entity.OperLogDto;
import com.isoftstone.rookie.monitor.operlog.service.IOperLogService;

@Service
public class OperLogServiceImpl implements IOperLogService
{
    @Resource
    private OperLogMapper operLogMapper;
    
    @Override
    public void insertOperlog(OperLog operLog)
    {
        Calendar calendar = Calendar.getInstance();
        operLog.setOperTime(calendar.getTime().toString());
        operLogMapper.insertOperlog(operLog);
    }
    
    @Override
    public PadingRstType<OperLog> selectOperLogList(OperLogDto operLog, PagingBean pagingBean)
    {
        pagingBean.deal(OperLog.class);
        List<OperLog> list = operLogMapper.selectOperLogList(operLog, pagingBean);
        Integer total = list.size();
        PadingRstType<OperLog> operLogBean = new PadingRstType<OperLog>();
        operLogBean.setPage(pagingBean.getPage());
        operLogBean.setTotal(total);
        operLogBean.putItems(OperLog.class, list);
        return operLogBean;
    }
    
    @Override
    public int deleteOperLogByIds(String ids)
    {
        String[] idsArray = ids.split(",");
        return operLogMapper.deleteOperLogByIds(idsArray);
    }
    
    @Override
    public OperLog selectOperLogById(Long operId)
    {
        return operLogMapper.selectOperLogById(operId);
    }
    
    @Override
    public void cleanOperLog()
    {
        operLogMapper.cleanOperLog();
    }
}
