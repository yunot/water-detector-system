package com.isoftstone.platform.sm.service;

import com.isoftstone.platform.common.mail.MailException;

public interface MailService
{
    
    void send(String txt)
        throws MailException;
    
    void setAddress(String to,
        String subject);
}
