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
import com.isoftstone.map.entity.MapInfoBean;
import com.isoftstone.map.entity.MapInfoSearch;
import com.isoftstone.map.service.MapInfoService;
import com.isoftstone.platform.controller.BaseController;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;

@Controller
@RequestMapping("/mapInfo")
public class MapInfoController extends BaseController{

    private static final Logger logger = Logger.getLogger(MapInfoController.class);
    
    @Resource
    private MapInfoService mapInfoService;
    
    @RequiresPermissions(value = {"system:map:mapInfo"})
    @RequestMapping("/mapInfo")
    public String initMapInfoList(Model model)
    {
        return "map/mapInfo";
    }
    
    @RequestMapping(value = "/getMapInfoList", produces = "application/json")
    @ResponseBody
    public String getMapInfoList(MapInfoSearch mapInfoSearch, PagingBean pagingBean)
    {
        logger.info(pagingBean);
        PadingRstType<MapInfoBean> rst = mapInfoService.queryMapInfoList(mapInfoSearch, pagingBean);
        
        return JSON.toJSONString(rst);
    }
    
    @RequestMapping(value = "/deleteMapInfo", produces = "application/json")
    @ResponseBody
    public String deleteMapInfo(@RequestParam("mapIds") String ids)
    {
        logger.info(ids);
        mapInfoService.deleteMapInfo(ids);
        return buildSuccessJsonMsg("warehouse.delete.sucess");
    }
}
