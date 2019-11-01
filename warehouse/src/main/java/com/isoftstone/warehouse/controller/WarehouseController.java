package com.isoftstone.warehouse.controller;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.isoftstone.platform.controller.BaseController;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.warehouse.entity.WarehouseBean;
import com.isoftstone.warehouse.entity.WarehouseSearch;
import com.isoftstone.warehouse.service.WarehouseService;

@Controller
@RequestMapping("/warehouse")
public class WarehouseController extends BaseController
{
    
    private final static Logger logger = Logger.getLogger(WarehouseController.class);
    
    @Resource
    private WarehouseService warehouseService;
    
    @RequestMapping("/main")
    public String initPage()
    {
        return "warehouse/main";
    }
    
    @RequiresPermissions(value = {"system:goods:respository"})
    @RequestMapping("/houseList")
    public String initWarehouseList(Model model)
    {
        return "warehouse/houseList";
    }
    
    @RequestMapping(value = "/getCommoditylist", produces = "application/json")
    @ResponseBody
    public String getCommoditylist(WarehouseSearch warehouseSearch, PagingBean pagingBean)
    {
        logger.info(pagingBean);
        PadingRstType<WarehouseBean> rst = warehouseService.queryWarehouseByPageList(warehouseSearch, pagingBean);
        
        return JSON.toJSONString(rst);
    }
    
    @RequestMapping(value = "/deleteWarehouseInfo", produces = "application/json")
    @ResponseBody
    public String deleteWarehouseInfo(@RequestParam("goodIds")
    String ids)
    {
        logger.info(ids);
        warehouseService.deleteWarehouseInfo(ids);
        return buildSuccessJsonMsg("warehouse.delete.sucess");
    }
    
    @RequestMapping(value = "/updateWarehouseDail", produces = "application/json")
    @ResponseBody
    public String updateWarehouseDail(WarehouseBean warehouseBean)
    {
        logger.info(warehouseBean);
        warehouseService.updateWarehouseDail(warehouseBean);
        return buildSuccessJsonMsg("warehouse.update.sucess");
    }
    
    @RequestMapping(value = "/addWarehouseDail", produces = "application/json")
    @ResponseBody
    public String addWarehouseDail(WarehouseBean warehouseBean)
    {
        logger.info(warehouseBean);
        warehouseService.addWarehouseDail(warehouseBean);
        return buildSuccessJsonMsg("warehouse.add.sucess");
    }
    
}
