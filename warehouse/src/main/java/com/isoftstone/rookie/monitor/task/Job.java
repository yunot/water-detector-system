package com.isoftstone.rookie.monitor.task;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.isoftstone.rookie.monitor.operlog.service.IOperLogService;

@Component
public class Job
{
    
    @Resource
    private IOperLogService operLogService;
    
    //定期清理日志
    @Scheduled(cron = "0 0 12 1/5 * ?")
    public void cleanOperLog()
    {
        operLogService.cleanOperLog();
    }
}
