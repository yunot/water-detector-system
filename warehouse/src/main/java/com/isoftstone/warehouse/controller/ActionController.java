package com.isoftstone.warehouse.controller;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.isoftstone.platform.common.uitl.PlatformUtil;

@Controller
@RequestMapping("/action")
public class ActionController
{
    @RequestMapping(value = "/download/{path}/{uuid}/{fileName}")
    @ResponseBody
    public String download(
        @PathVariable("path")
        String path,
        @PathVariable("uuid")
        String uuid,
        @PathVariable("fileName")
        String fileName,
        HttpServletRequest request)
    {
        Map<String, Object> message =
            new LinkedHashMap<>();
        message.put("success",
            true);
        message.put("path", path);
        message.put("uuid", uuid);
        message.put("fileName",
            fileName);
        String rst =
            PlatformUtil.toJSON(message);
        return rst;
    }
}
