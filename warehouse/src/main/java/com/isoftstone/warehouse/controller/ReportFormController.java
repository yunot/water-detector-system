package com.isoftstone.warehouse.controller;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.isoftstone.platform.common.uitl.PlatformUtil;
import com.isoftstone.platform.common.uitl.RandomUtil;
import com.isoftstone.platform.controller.BaseController;
import com.isoftstone.warehouse.entity.IncomeBean;
import com.isoftstone.warehouse.service.IncomeService;

@Controller
@RequestMapping("/report")
public class ReportFormController extends BaseController
{
    @Resource
    private IncomeService incomeService;
    
    @RequestMapping("/reportForm")
    //@RequiresPermissions("BASE_MENU_108")
    public String initPage()
    {
        return "report/ReportForm";
    }
    
    @RequestMapping("/draw")
    public String Bar()
    {
        return "report/bar3D";
    }
    
    @RequestMapping("/drawIncome")
    @ResponseBody
    public String getData()
    {
        List<IncomeBean> list = incomeService.queryIncomeByYear();
        return JSON.toJSONString(list);
    }
    
    @RequestMapping(value = "/getSpeed", produces = "application/json")
    @ResponseBody
    public String getgetSpeed(String cardId)
    {
        int speed = RandomUtil.generateIntRandom(5, 220);
        
        Map<String, Object> message = new LinkedHashMap<>();
        message.put("success", true);
        message.put("speed", speed);
        String rst = PlatformUtil.toJSON(message);
        return rst;
        //        return "{\"success\":true,\"speed\":"
        //            + speed + "}";
    }
    
    @RequestMapping("/bar3D")
    //@RequiresPermissions("BASE_MENU_109")
    public String initBar3DPage()
    {
        return "report/bar3D";
    }
    
    @RequestMapping(value = "/getChartData", produces = "application/json")
    @ResponseBody
    public String getChartData(String cardId)
    {
        List<IncomeBean> IncomeBeanList = incomeService.queryIncomeByYear();
        Map<String, Object> message = new LinkedHashMap<>();
        message.put("success", true);
        message.put("chartData", IncomeBeanList);
        String rst = PlatformUtil.toJSON(message);
        return rst;
        //        return "{\"success\":true,\"speed\":"
        //            + speed + "}";
    }
    
    @RequestMapping("/line")
    //@RequiresPermissions("BASE_MENU_107")
    public String line()
    {
        return "report/line";
    }
    
    @RequestMapping("/pie")
    public String pie()
    {
        return "report/pie";
    }
}
