package com.isoftstone.platform.common.uitl;

import java.util.Random;

public class RandomUtil
{
    private static final Random RANDOM =
        new Random();
    
    public static int generateIntRandom(
        int startNum, int endNum)
    {
        int rst = 0;
        do
        {
            rst =
                RANDOM.nextInt(endNum + 1);
        } while (rst < startNum);
        
        return rst;
    }
}
