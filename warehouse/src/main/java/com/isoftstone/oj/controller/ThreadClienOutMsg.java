package com.isoftstone.oj.controller;

import java.io.IOException;
import java.io.InputStream;
import java.net.Socket;

import com.alibaba.fastjson.JSONObject;
import com.isoftstone.oj.entity.SubjectRst;

public class ThreadClienOutMsg extends Thread
{
    Socket socket = null;
    
    SubjectRst subjectRst = null;
    
    public ThreadClienOutMsg(Socket socket)
    {
        this.socket = socket;
    }
    
    @Override
    public void run()
    {
        if (socket != null)
        {
            InputStream is = null;
            try
            {
                is = socket.getInputStream();
            }
            catch (IOException e1)
            {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }
            String rst = null;
            byte[] block = new byte[10240];
            int length = 0;
            try
            {
                while ((length = is.read(block)) > 0)
                {
                    if (new String(block, 0, length).equals("connection success."))
                    {
                        continue;
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
                //System.out.println("¶Ï¿ªÁ¬½Ó");
            }
            subjectRst = JSONObject.parseObject(rst, SubjectRst.class);
        }
    }
}
