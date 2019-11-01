package com.isoftstone.oj.service.impl;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.isoftstone.oj.entity.SubjectBean;
import com.isoftstone.oj.entity.SubjectRst;
import com.isoftstone.oj.entity.SubjectSearch;
import com.isoftstone.oj.repository.OjDao;
import com.isoftstone.oj.service.OjService;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;

@Service("ojService")
public class OjServiceImpl implements OjService
{
    
    private final static Logger logger = Logger.getLogger(OjServiceImpl.class);
    
    @Value("#{propertiesConfig['client.ip']}")
    private static String ip = "192.168.3.254";
    
    @Value("#{propertiesConfig['port']}")
    private static int port = 2245;
    
    @Resource
    private OjDao ojDao;
    
    @Override
    public PadingRstType<SubjectBean> querySubjectByPageList(SubjectSearch subjectSearch, PagingBean pagingBean)
    {
        pagingBean.deal(SubjectBean.class);
        List<SubjectBean> subjectBeanList = ojDao.querySubjectByPageList(subjectSearch, pagingBean);
        
        Integer total = ojDao.querySubjectTotal(subjectSearch);
        PadingRstType<SubjectBean> subjectBean = new PadingRstType<>();
        subjectBean.setPage(pagingBean.getPage());
        subjectBean.setTotal(total);
        subjectBean.putItems(SubjectBean.class, subjectBeanList);
        return subjectBean;
    }
    
    @Override
    public SubjectBean querySubjectById(SubjectSearch subjectSearch, int id)
    {
        return ojDao.querySubjectById(subjectSearch, id);
    }
    
    public void sendSocket(Socket socket, SubjectBean subjectBean)
    {
        String msg = JSON.toJSONString(subjectBean);
        try
        {
            OutputStream os = socket.getOutputStream();
            os.write(msg.getBytes());
            os.flush();
        }
        catch (IOException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
    }
    
    public SubjectRst receiveSocket(SubjectBean subjectBean)
    {
        
        Socket socket = null;
        try
        {
            socket = new Socket(ip, port);
        }
        catch (IOException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return null;
        }
        sendSocket(socket, subjectBean);
        String rst = null;
        SubjectRst subjectRst = null;
        byte[] block = new byte[10240];
        int length = 0;
        try
        {
            InputStream is = socket.getInputStream();
            while ((length = is.read(block)) > 0)
            {
                if (new String(block, 0, length).equals("connection success."))
                {
                }
                else
                {
                    rst = new String(block, 0, length);
                    socket.close();
                }
            }
        }
        catch (IOException e)
        {
            // TODO Auto-generated catch block
            //e.printStackTrace();
        }
        logger.info(rst);
        subjectRst = JSONObject.parseObject(rst, SubjectRst.class);
        logger.info(subjectBean.toString());
        return subjectRst;
        
    }
}
