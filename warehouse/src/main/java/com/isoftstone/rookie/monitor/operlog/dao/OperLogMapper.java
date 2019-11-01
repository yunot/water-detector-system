package com.isoftstone.rookie.monitor.operlog.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.rookie.monitor.operlog.entity.OperLog;
import com.isoftstone.rookie.monitor.operlog.entity.OperLogDto;

@Repository
public interface OperLogMapper
{
    public void insertOperlog(OperLog operLog);
    
    public List<OperLog> selectOperLogList(@Param("operLog") OperLogDto operLog, @Param("paging") PagingBean pagingBean);
    
    public int deleteOperLogByIds(@Param("operIds") String[] ids);
    
    public OperLog selectOperLogById(Long operId);
    
    public void cleanOperLog();
}
