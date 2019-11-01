package com.isoftstone.oj.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;

public class SocketUtil
{
    public static void sendSocket(Socket socket, String msg)
    {
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
    
    public static String receiveSocket(Socket socket)
    {
        StringBuffer sBuffer = new StringBuffer();
        byte[] block = new byte[1024];
        int length = 0;
        try
        {
            InputStream is = socket.getInputStream();
            while ((length = is.read(block)) > 0)
            {
                sBuffer.append(new String(block, 0, length));
                System.out.println(new String(block, 0, length));
            }
        }
        catch (IOException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return sBuffer.toString();
        
    }
}
