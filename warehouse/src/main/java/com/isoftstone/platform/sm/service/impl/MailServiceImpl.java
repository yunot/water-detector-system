package com.isoftstone.platform.sm.service.impl;

import java.util.Properties;

import javax.activation.CommandMap;
import javax.activation.MailcapCommandMap;
import javax.annotation.Resource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.isoftstone.platform.common.mail.MailException;
import com.isoftstone.platform.sm.repository.UserInfoDao;
import com.isoftstone.platform.sm.service.MailService;

@Service
public class MailServiceImpl
    implements MailService
{
    @Value("${mail.host}")
    private String host;
    
    @Value("${mail.user}")
    private String user;
    
    @Value("#{T(com.isoftstone.platform.common.uitl.AES128Util).Decrypt(propertiesConfig['mail.pwd'],propertiesConfig['jdbc.encrypt.key'],propertiesConfig['jdbc.encrypt.encoding'])}")
    private String pwd;
    
    @Value("${mail.user}")
    private String from;
    
    private String to;
    
    private String subject;
    
    @Resource
    private UserInfoDao userInfoDao;
    
    @Override
    public void setAddress(
        String to, String subject)
    {
        this.to = to;
        this.subject = subject;
    }
    
    @Override
    public void send(String txt)
        throws MailException
    {
        Integer count =
            userInfoDao.selectByEmail(to);
        if (count <= 0)
        {
            throw new MailException(
                "没有该邮箱");
        }
        else if (count > 1)
        {
            throw new MailException(
                "出现重复邮箱");
        }
        else
        {
            Properties props =
                new Properties();
            props.put("mail.smtp.host",
                host);
            props.put("mail.smtp.auth",
                "true");
            Session session =
                Session.getDefaultInstance(props);
            session.setDebug(true);
            MimeMessage message =
                new MimeMessage(
                    session);
            try
            {
                message.setFrom(new InternetAddress(
                    from));
                message.addRecipient(Message.RecipientType.TO,
                    new InternetAddress(
                        to));
                message.setSubject(subject);
                Multipart multipart =
                    new MimeMultipart();
                BodyPart contentPart =
                    new MimeBodyPart();
                contentPart.setText(txt);
                multipart.addBodyPart(contentPart);
                message.setContent(multipart);
                message.saveChanges();
                Transport transport =
                    session.getTransport("smtp");
                transport.connect(host,
                    user,
                    pwd);
                MailcapCommandMap mc =
                    (MailcapCommandMap)CommandMap.getDefaultCommandMap();
                mc.addMailcap("text/html;; x-java-content-handler=com.sun.mail.handlers.text_html");
                mc.addMailcap("text/xml;; x-java-content-handler=com.sun.mail.handlers.text_xml");
                mc.addMailcap("text/plain;; x-java-content-handler=com.sun.mail.handlers.text_plain");
                mc.addMailcap("multipart/*;; x-java-content-handler=com.sun.mail.handlers.multipart_mixed");
                mc.addMailcap("message/rfc822;;x-java-content-handler=com.sun.mail.handlers.message_rfc822");
                CommandMap.setDefaultCommandMap(mc);
                transport.sendMessage(message,
                    message.getAllRecipients());
                transport.close();
            }
            catch (Exception e)
            {
                e.printStackTrace();
                throw new MailException(
                    "鉴权失败");
            }
        }
    }
}
