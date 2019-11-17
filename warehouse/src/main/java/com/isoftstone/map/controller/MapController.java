package com.isoftstone.map.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.isoftstone.map.entity.MapInfoBean;
import com.isoftstone.map.entity.MapInfoSearch;
import com.isoftstone.map.service.MapInfoService;
import com.isoftstone.map.service.MapLogService;
import com.isoftstone.oj.service.OjService;
import com.isoftstone.platform.controller.BaseController;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;

import cmcc.iot.onenet.javasdk.api.datastreams.GetDatastreamApi;
import cmcc.iot.onenet.javasdk.api.device.GetLatesDeviceData;
import cmcc.iot.onenet.javasdk.response.BasicResponse;
import cmcc.iot.onenet.javasdk.response.datastreams.DatastreamsResponse;
import cmcc.iot.onenet.javasdk.response.device.DeciceLatestDataPoint;

@Controller
@RequestMapping("/map")
public class MapController extends BaseController
{
    private final static Logger logger = Logger.getLogger(MapController.class);
    
    @Resource
    private MapInfoService mapInfoService;
    
    @Resource
    private MapLogService mapLogService;
    
    @RequestMapping("/mapIndex")
    public String initPage()
    {
        return "map/mapIndex";
    }
    
    
    @RequestMapping("/mapView")
    public String mapView(HttpServletRequest request,MapInfoSearch mapInfoSearch, PagingBean pagingBean)
    {
        HttpSession session = request.getSession();

        String key = "i4f61Ym1937Tei6G8W4cZAzcU5s=";
        String devIds="564785374,564844586";
        /**
    	 * 批量查询设备最新数据
    	 * 参数顺序与构造函数顺序一致
    	 * @param devIds :设备id用逗号隔开, 限制1000个设备,String
    	 * @param key:masterkey
    	 */
        GetLatesDeviceData api = new GetLatesDeviceData(devIds,key);
        BasicResponse<DeciceLatestDataPoint> response = api.executeApi();
        
        StringBuffer sBuffer = new StringBuffer("");
        JSONObject jsonData = (JSONObject) JSON.parse(response.getJson());
        JSONObject jsonDevices = (JSONObject) jsonData.get("data");
        JSONArray jsonArray = (JSONArray) jsonDevices.get("devices");
        if (!jsonArray.isEmpty()) {
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject jsonObject = jsonArray.getJSONObject(i);
				JSONArray jsonArr = (JSONArray) jsonObject.get("datastreams");
				JSONObject jsonOb = jsonArr.getJSONObject(0);
				JSONObject jsonValue = (JSONObject) jsonOb.get("value");
				
				mapInfoSearch.setSearchName(jsonValue.get("name").toString());
				PadingRstType<MapInfoBean> rst = mapInfoService.queryMapInfoList(mapInfoSearch, pagingBean);
				MapInfoBean mapInfoBean = new MapInfoBean();
				mapInfoBean.setName(jsonValue.get("name").toString());
				mapInfoBean.setCity(jsonValue.get("city").toString());
				mapInfoBean.setLon(jsonValue.get("lon").toString());
				mapInfoBean.setLat(jsonValue.get("lat").toString());
				mapInfoBean.setAddress(jsonValue.get("address").toString());
				mapInfoBean.setSoak(jsonValue.get("soak").toString());
				if (rst == null) {
					mapInfoService.addMapInfoDail(mapInfoBean);
				}else {
					if (!rst.getRawRecords().get(0).getSoak().equals(jsonValue.get("soak"))) {
						System.out.println(rst.getRawRecords().get(0).getSoak().equals(jsonValue.get("soak")));
						mapInfoService.updateMapInfoDail(mapInfoBean);
					}
				}
				
				sBuffer.append(jsonValue+",");
			}
		}
        sBuffer.deleteCharAt(sBuffer.length()-1);
        JSONArray jsonLoc = JSON.parseArray("["+sBuffer+"]");
		session.setAttribute("loc", jsonLoc);
        return "map/mapView";
    }
    
    @RequestMapping("/mapLocationInfo")
    public String mapLocationInfo(HttpServletRequest request)
    {
        
        return "map/mapLocationInfo";
    }
    
    @RequestMapping("/mapLocationLog")
    public String mapLocationLog(HttpServletRequest request)
    {
        
        return "map/mapLocationLog";
    }

//    @RequestMapping("/mapLocationCharts")
//    public String mapLocationCharts(HttpServletRequest request)
//    {
//
//        return "map/mapLocationCharts";
//    }

    @RequestMapping("/mapMain")
    public String mapMain(HttpServletRequest request)
    {
        
        return "map/mapMain";
    }
    
    @RequestMapping("/welcome")
    public String welcome(HttpServletRequest request)
    {
        
        return "map/welcome";
    }
    
}
