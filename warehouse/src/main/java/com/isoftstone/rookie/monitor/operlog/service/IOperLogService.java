package com.isoftstone.rookie.monitor.operlog.service;

import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.rookie.monitor.operlog.entity.OperLog;
import com.isoftstone.rookie.monitor.operlog.entity.OperLogDto;

public interface IOperLogService
{
    public void insertOperlog(OperLog operLog);
    
    public PadingRstType<OperLog> selectOperLogList(OperLogDto operLog, PagingBean pagingBean);
    
    public int deleteOperLogByIds(String ids);
    
    public OperLog selectOperLogById(Long operId);
    
    public void cleanOperLog();
}
