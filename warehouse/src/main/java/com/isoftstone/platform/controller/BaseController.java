package com.isoftstone.platform.controller;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.annotation.Resource;

import com.isoftstone.platform.common.MessageHolder;
import com.isoftstone.platform.common.uitl.PlatformUtil;

public class BaseController
{
    @Resource
    private MessageHolder messageHolder;
    
    protected String buildSuccessJsonMsg(String msg, Object... args)
    {
        Map<String, Object> message = new LinkedHashMap<>();
        String msgStr = this.messageHolder.getMessage(msg, args, msg);
        message.put("success", true);
        message.put("msg", msgStr);
        message.put("description", msgStr);
        String rst = PlatformUtil.toJSON(message);
        return rst;
    }
    
    protected String buildFailJsonMsg(String msg, Object... args)
    {
        Map<String, Object> message = new LinkedHashMap<>();
        String msgStr = this.messageHolder.getMessage(msg, args, msg);
        message.put("success", false);
        message.put("msg", msgStr);
        message.put("description", msgStr);
        String rst = PlatformUtil.toJSON(message);
        return rst;
    }
    
    public MessageHolder getMessageHolder()
    {
        return messageHolder;
    }
    
}
