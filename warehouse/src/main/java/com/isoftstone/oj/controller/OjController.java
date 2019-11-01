package com.isoftstone.oj.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.isoftstone.oj.entity.SubjectBean;
import com.isoftstone.oj.entity.SubjectRst;
import com.isoftstone.oj.entity.SubjectSearch;
import com.isoftstone.oj.service.OjService;
import com.isoftstone.platform.controller.BaseController;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;

import cmcc.iot.onenet.javasdk.api.datastreams.GetDatastreamApi;
import cmcc.iot.onenet.javasdk.response.BasicResponse;
import cmcc.iot.onenet.javasdk.response.datastreams.DatastreamsResponse;

@Controller
@RequestMapping("/oj")
public class OjController extends BaseController
{
    private final static Logger logger = Logger.getLogger(OjController.class);
    
    @Value("#{propertiesConfig['client.ip']}")
    private static String ip = "192.168.3.100";
    
    @Value("#{propertiesConfig['port']}")
    private static int port = 2245;
    
    @Resource
    private OjService ojService;
    
    @RequestMapping("/ojIndex")
    public String initPage()
    {
        return "oj/ojIndex";
    }
    
    @RequestMapping("/test")
    public String test(SubjectSearch subjectSearch, HttpServletRequest request)
    {
        String id = request.getParameter("id");
        SubjectBean subjectBean = ojService.querySubjectById(subjectSearch, Integer.parseInt(id));
        HttpSession session = request.getSession();
        session.setAttribute("subject", subjectBean);
        return "oj/test";
    }
    
    @RequestMapping(value = "/getSubjectlist", produces = "application/json")
    @ResponseBody
    public String getSubjectlist(SubjectSearch subjectSearch, PagingBean pagingBean)
    {
        //logger.info(pagingBean);
        PadingRstType<SubjectBean> rst = ojService.querySubjectByPageList(subjectSearch, pagingBean);
        return JSON.toJSONString(rst);
    }
    
    @RequestMapping(value = "/getCode", produces = "application/json")
    @ResponseBody
    public String getCode(HttpServletRequest request)
    {
        
        String code = request.getParameter("code");
        HttpSession session = request.getSession();
        SubjectBean subjectBean = (SubjectBean)session.getAttribute("subject");
        subjectBean.setUserInput(code);
        String subject = JSON.toJSONString(subjectBean);
        
        logger.info("clint:" + subjectBean.getUserInput());
        SubjectRst rst = ojService.receiveSocket(subjectBean);
        logger.info("serve:" + rst);
        
        return JSON.toJSONString(rst);
    }
    
    @RequestMapping("/mapView")
    public String mapView(HttpServletRequest request)
    {
        HttpSession session = request.getSession();
        String devId = "504553314";
		String id = "test";
		String key = "nQgGTylm=oZ1P3XxflFq=CYFi7g=";
		/**
		 * 查询单个数据流
		 * 
		 * @param devid:设备ID,String
		 * @param datastreamid:数据流名称 ,String
		 * @param key:masterkey 或者 设备apikey
		 */
		GetDatastreamApi api = new GetDatastreamApi(devId, id, key);
		BasicResponse<DatastreamsResponse> response = api.executeApi();
		//System.out.println("errno:" + response.errno + " error:" + response.error);
		System.out.println(response.getData().getCurrentValue());
		
		String location = response.getData().getCurrentValue().toString();
		String[] loc = location.replaceAll("([^\\d+\\.\\d+]+)", " ").trim().split(" ");

		session.setAttribute("lon", loc[0]);
		session.setAttribute("lat", loc[1]);
        return "map/mapView";
    }
    
    @RequestMapping("/mapMain")
    public String mapMain(HttpServletRequest request)
    {
        
        return "map/mapMain";
    }
    
}
