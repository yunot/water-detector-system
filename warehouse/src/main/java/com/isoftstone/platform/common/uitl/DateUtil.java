package com.isoftstone.platform.common.uitl;

import java.util.Calendar;
import java.util.Date;

public class DateUtil
{
    /**
     * 单位分钟
     * <一句话功能简述>
     * <功能详细描述>
     * @param dateTime
     * @return
     * @see [类、类#方法、类#成员]
     */
    public static Integer getPassMinuteTime(
        Date dateTime)
    {
        if (dateTime == null)
        {
            return null;
        }
        
        Long milliseconds =
            Calendar.getInstance()
                .getTime()
                .getTime()
                - dateTime.getTime();
        
        return (int)(milliseconds / 1000 / 60);
    }
}
