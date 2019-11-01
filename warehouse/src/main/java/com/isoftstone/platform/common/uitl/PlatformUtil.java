package com.isoftstone.platform.common.uitl;

import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

public class PlatformUtil
{
    public static String toJSON(Map<String, Object> message)
    {
        ObjectMapper mapper = new ObjectMapper();
        mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
        String rst = null;
        try
        {
            rst = mapper.writeValueAsString(message);
        }
        catch (JsonProcessingException e)
        {
            e.printStackTrace();
        }
        return rst;
    }
    
    public static <T> String toJSON(List<T> message)
    {
        ObjectMapper mapper = new ObjectMapper();
        mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
        String rst = null;
        try
        {
            rst = mapper.writeValueAsString(message);
        }
        catch (JsonProcessingException e)
        {
            e.printStackTrace();
        }
        return rst;
    }
}
