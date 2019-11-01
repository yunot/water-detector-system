package com.isoftstone.platform.common;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.MessageSource;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

public class MessageHolder
{
    private MessageSource messageSource;
    
    public String getMessage(
        String code)
    {
        return this.messageSource.getMessage(code,
            null,
            getCurrentRequestLocal());
    }
    
    public String getMessage(
        String code, Object[] args)
    {
        return this.messageSource.getMessage(code,
            args,
            getCurrentRequestLocal());
    }
    
    private Locale getCurrentRequestLocal()
    {
        
        HttpServletRequest httpServletRequest =
            ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
        
        return RequestContextUtils.getLocale(httpServletRequest);
    }
    
    public String getMessage(
        String code,
        Object[] args,
        String defaultMessage)
    {
        return this.messageSource.getMessage(code,
            args,
            defaultMessage,
            getCurrentRequestLocal());
    }
    
    public MessageSource getMessageSource()
    {
        return this.messageSource;
    }
    
    public void setMessageSource(
        MessageSource messageSource)
    {
        this.messageSource =
            messageSource;
    }
}