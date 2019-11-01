package com.isoftstone.platform.common.uitl;

import java.util.Calendar;
import java.util.Date;

public class DateUtil
{
    /**
     * ��λ����
     * <һ�仰���ܼ���>
     * <������ϸ����>
     * @param dateTime
     * @return
     * @see [�ࡢ��#��������#��Ա]
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
