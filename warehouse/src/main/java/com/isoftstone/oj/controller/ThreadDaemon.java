package com.isoftstone.oj.controller;

public class ThreadDaemon extends Thread
{
    public void run()
    {
        try
        {
            Thread.sleep(3000);
        }
        catch (InterruptedException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}
