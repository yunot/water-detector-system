package com.isoftstone.rookie.monitor.operlog.controller;

import java.util.List;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.isoftstone.platform.controller.BaseController;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.rookie.framework.constant.SysConstant;
import com.isoftstone.rookie.monitor.operlog.entity.OperLog;
import com.isoftstone.rookie.monitor.operlog.entity.OperLogDto;
import com.isoftstone.rookie.monitor.operlog.service.IOperLogService;
import com.isoftstone.rookie.system.dictionary.entity.DictData;
import com.isoftstone.rookie.system.dictionary.service.DictDatService;

@RequestMapping("/monitor/log")
@Controller
public class OperlogController extends BaseController
{
    
    @Resource
    private IOperLogService operLogService;
    
    @Resource
    private DictDatService dictDatService;
    
    @RequestMapping()
    public String init()
    {
        return "/log/log";
    }
    
    @RequestMapping(value = "/queryModuleBySystem", produces = "application/json")
    @ResponseBody
    public String queryModuleBySystem(Model model, @RequestParam("title")
    String title)
    {
        List<DictData> dictData = null;
        Session session = SecurityUtils.getSubject().getSession();
        String siteLanguage = (String)session.getAttribute("language");
        //根据不同子系统获取不同的数据字典中的模块
        if (SysConstant.MODULE_BRANCH.SM.USER_MANAGER.equals(title))
        {
            dictData =
                dictDatService.selectDictDataByType(SysConstant.FUNCTION_BRANCH.USER_MANAGER.BUTTON, siteLanguage);
        }
        else if (SysConstant.MODULE_BRANCH.SM.ROLE_MANAGER.equals(title))
        {
            dictData =
                dictDatService.selectDictDataByType(SysConstant.FUNCTION_BRANCH.ROLE_MANAGER.BUTTON, siteLanguage);
        }
        else
        {
            dictData = dictDatService.selectDictDataByType("sys_module", siteLanguage);
        }
        return JSON.toJSONString(dictData);
    }
    
    @RequiresPermissions("monitor:operlog:list")
    @RequestMapping("/list")
    @ResponseBody
    public String list(OperLogDto operLog, PagingBean pagingBean)
    {
        PadingRstType<OperLog> rst = operLogService.selectOperLogList(operLog, pagingBean);
        return JSON.toJSONString(rst);
    }
    
    @RequiresPermissions("monitor:operlog:remove")
    @RequestMapping("/remove")
    @ResponseBody
    public String remove(@RequestParam("operIds")
    String ids)
    {
        operLogService.deleteOperLogByIds(ids);
        return buildSuccessJsonMsg("log.remove.success");
    }
    
    @RequiresPermissions("monitor:operlog:updata")
    @RequestMapping("/clean")
    @ResponseBody
    public String clean()
    {
        operLogService.cleanOperLog();
        return buildSuccessJsonMsg("log.clean.success");
    }
    
}
