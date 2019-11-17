package com.isoftstone.map.controller;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.apache.shiro.authz.annotation.RequiresPermissions;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.isoftstone.map.entity.MapLogBean;
import com.isoftstone.map.entity.MapLogSearch;
import com.isoftstone.map.service.MapLogService;
import com.isoftstone.platform.controller.BaseController;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.warehouse.entity.WarehouseBean;

@Controller
@RequestMapping("/mapLog")
public class MapLogController extends BaseController{

    private static final Logger logger = Logger.getLogger(MapLogController.class);
    
    @Resource
    private MapLogService mapLogService;
    
    @RequiresPermissions(value = {"system:map:mapLog"})
    @RequestMapping("/mapLog")
    public String initMapLogList(Model model)
    {
        return "map/mapLog";
    }
    
    @RequestMapping(value = "/getMapLogList", produces = "application/json")
    @ResponseBody
    public String getMapLogList(MapLogSearch mapLogSearch, PagingBean pagingBean)
    {
        logger.info(pagingBean);
        PadingRstType<MapLogBean> rst = mapLogService.queryMapLogList(mapLogSearch, pagingBean);
        return JSON.toJSONString(rst);
    }
    
    @RequestMapping(value = "/deleteMapLog", produces = "application/json")
    @ResponseBody
    public String deleteMapLog(@RequestParam("mapIds")
    String ids)
    {
        logger.info(ids);
        mapLogService.deleteMapLog(ids);
        return buildSuccessJsonMsg("warehouse.delete.sucess");
    }
    
    @RequestMapping(value = "/addMapLogDail", produces = "application/json")
    @ResponseBody
    public String addMapLogDail(@RequestParam("deviceInfo")
    String deviceInfo)
    {
    	JSONObject infoJson = (JSONObject) JSON.parse(deviceInfo);
    	MapLogBean mapLogBean = new MapLogBean();
    	mapLogBean.setCity(infoJson.getString("city"));
    	mapLogBean.setLon(infoJson.getString("lon"));
    	mapLogBean.setLat(infoJson.getString("lat"));
    	mapLogBean.setName(infoJson.getString("name"));
        mapLogService.addMapLogDail(mapLogBean);
        return buildSuccessJsonMsg("warehouse.add.sucess");
    }
}
