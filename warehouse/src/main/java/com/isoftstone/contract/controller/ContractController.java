package com.isoftstone.contract.controller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.isoftstone.contract.entity.ContractInfoBean;
import com.isoftstone.contract.entity.ContractSearch;
import com.isoftstone.contract.service.ContractService;
import com.isoftstone.platform.common.uitl.PlatformUtil;
import com.isoftstone.platform.controller.BaseController;
import com.isoftstone.platform.entity.BaseSelectBean;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;

@Controller
@RequestMapping("/contract")
public class ContractController extends BaseController
{
    private final static Logger logger = Logger.getLogger(ContractController.class);
    
    @Value("#{propertiesConfig['pic.path']}")
    private String uploadPath = "http://127.0.0.1:18080/warehouse/contractUpload/downloadPic";
    
    @Resource
    private ContractService contractService;
    
    @RequestMapping("/contractManager")
    public String initContractList(Model model)
    {
        return "contract/contractManager";
    }
    
    @RequestMapping(value = "/getContractlist", produces = "application/json")
    @ResponseBody
    public String getContractlist(ContractSearch contractSearch, PagingBean pagingBean, HttpServletRequest request)
    {
        HttpSession session = request.getSession();
        logger.info(pagingBean);
        PadingRstType<ContractInfoBean> rst = contractService.queryContractByPageList(contractSearch, pagingBean);
        List<BaseSelectBean> list = contractService.getAll();
        session.setAttribute("contractlist", list);
        return JSON.toJSONString(rst);
    }
    
    @RequestMapping("/queryDetail")
    public String queryDetail(Model model, HttpServletRequest request, HttpServletResponse resp)
        throws IOException
    {
        String docutmentHeadDataId = request.getParameter("docutmentHeadDataId");
        
        String docutmentBodyDataId = request.getParameter("docutmentBodyDataId");
        
        HttpSession session = request.getSession();
        session.setAttribute("docutmentHeadDataId", docutmentHeadDataId);
        session.setAttribute("docutmentBodyDataId", docutmentBodyDataId);
        return "/contract/contractDetail";
    }
    
    @RequestMapping("/editContract")
    public String editContract(Model model, HttpServletRequest request, HttpServletResponse resp)
        throws IOException
    {
        String docutmentHeadDataId = request.getParameter("docutmentHeadDataId");
        String docutmentBodyDataId = request.getParameter("docutmentBodyDataId");
        
        HttpSession session = request.getSession();
        session.setAttribute("docutmentHeadDataId", docutmentHeadDataId);
        session.setAttribute("docutmentBodyDataId", docutmentBodyDataId);
        return "/contract/contractEditor";
    }
    
    @RequestMapping("/newContractInfo")
    public String newContractInfo(HttpServletRequest request, HttpServletResponse resp)
        throws IOException
    {
        HttpSession session = request.getSession();
        String headDataId = request.getParameter("headDataId");
        session.setAttribute("headDataId", headDataId);
        //logger.info(headDataId);
        
        return "/contract/newContract";
    }
    
    @RequestMapping(value = "/newContract", produces = "application/json")
    @ResponseBody
    public String newContract(HttpServletRequest request, HttpServletResponse resp)
        throws IOException
    {
        String headDataId = request.getParameter("headDataId");
        String head = contractService.getHtmlContentHead(headDataId);
        //logger.info(head);
        Map<String, Object> message = new LinkedHashMap<>();
        message.put("success", true);
        message.put("msg", head);
        String rst = PlatformUtil.toJSON(message);
        
        return rst;
    }
    
    @RequestMapping(value = "/newContractContent", produces = "application/json")
    @ResponseBody
    public String newContractContent(HttpServletRequest request, HttpServletResponse resp)
        throws IOException
    {
        String headDataId = request.getParameter("headDataId");
        logger.info(headDataId);
        String contractName = request.getParameter("contractName");
        logger.info(contractName);
        String head = contractService.getHtmlContentHead(headDataId);
        String body = request.getParameter("body").replace("contenteditable=\"true\"", "");
        contractService.newContract(head, body, contractName);
        logger.info(body);
        
        return buildSuccessJsonMsg("增加成功");
    }
    
    @RequestMapping("/queryContractDetail")
    public String queryContractDetail(Model model, HttpServletRequest request, HttpServletResponse resp)
        throws IOException
    {
        String docutmentHeadDataId = request.getParameter("docutmentHeadDataId");
        model.addAttribute("docutmentHeadDataId", docutmentHeadDataId);
        
        String docutmentBodyDataId = request.getParameter("docutmentBodyDataId");
        model.addAttribute("docutmentBodyDataId", docutmentBodyDataId);
        
        String docutmentInfoId = request.getParameter("docutmentInfoId");
        model.addAttribute("docutmentInfoId", docutmentInfoId);
        
        return "/contract/contractDetail";
    }
    
    @RequestMapping(value = "/queryContractHtml", produces = "application/json")
    @ResponseBody
    public String queryContractHtml(String docutmentHeadDataId, String docutmentBodyDataId)
        throws Exception
    {
        //        logger.info(docutmentHeadDataId);
        String rString = contractService.getHtmlContent(docutmentHeadDataId, docutmentBodyDataId);
        //        logger.info(rString);
        Map<String, Object> message = new LinkedHashMap<>();
        message.put("success", true);
        message.put("msg", rString);
        String rst = PlatformUtil.toJSON(message);
        
        return rst;
    }
    
    @RequestMapping(value = "/getHtmlContents", produces = "application/json")
    @ResponseBody
    public String getHtmlContents(String docutmentHeadDataId, String docutmentBodyDataId)
    {
        
        String head = contractService.getHtmlContentHead(docutmentHeadDataId);
        String body = contractService.getHtmlContentBody(docutmentBodyDataId);
        body = body.replace(" contenteditable=\"true\"", "");
        String data = head + body;
        data = data.replaceAll("##", uploadPath);
        Map<String, Object> message = new LinkedHashMap<>();
        message.put("success", true);
        message.put("msg", data);
        
        String rst = PlatformUtil.toJSON(message);
        return rst;
        //return JSON.toJSONString(head + body);
    }
    
    @RequestMapping(value = "/editHtmlContents", produces = "application/json")
    @ResponseBody
    public String editHtmlContents(String docutmentHeadDataId, String docutmentBodyDataId)
    {
        String head = contractService.getHtmlContentHead(docutmentHeadDataId);
        String body = contractService.getHtmlContentBody(docutmentBodyDataId);
        int index = body.indexOf(">");
        StringBuffer sb = new StringBuffer(body);
        sb.insert(index, " contenteditable='true'");
        sb.insert(0, head);
        String data = sb.toString();
        data = data.replaceAll("##", uploadPath);
        Map<String, Object> message = new LinkedHashMap<>();
        message.put("success", true);
        message.put("msg", data);
        
        String rst = PlatformUtil.toJSON(message);
        return rst;
    }
    
    @RequestMapping(value = "/save", produces = "application/json")
    @ResponseBody
    public String save(HttpServletRequest request)
    {
        String body = (String)request.getParameter("body");
        String docutmentBodyDataId = (String)request.getParameter("docutmentBodyDataId");
        contractService.updateHtmlBody(body, docutmentBodyDataId);
        return JSON.toJSONString("");
    }
}
