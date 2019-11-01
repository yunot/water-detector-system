package com.isoftstone.rookie.system.organization.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.alibaba.fastjson.JSON;
import com.isoftstone.platform.controller.BaseController;
import com.isoftstone.rookie.framework.TableDataInfo;
import com.isoftstone.rookie.system.organization.entity.Organization;
import com.isoftstone.rookie.system.organization.service.OrganizationService;

@Controller
@RequestMapping("/organization/orglist")
public class organizationController extends BaseController
{
    @Resource
    private OrganizationService organizationService;
    
    @RequestMapping
    public String init()
    {
        return "organization/organizationlist";
    }
    
    /** 加载所有菜单列表树 */
    @GetMapping("/orgTreeData")
    @ResponseBody
    public List<Map<String, Object>> menuTreeData(Organization organization)
    {
        List<Map<String, Object>> tree = organizationService.selectOrgTree();
        return tree;
    }
    
    /**
     * 加载组织、部门、职位列表树
     */
    @RequestMapping("/showorg")
    @ResponseBody
    public String showorganization()
    {
        List<Map<String, Object>> orglist = organizationService.selectOrgAll();
        TableDataInfo tableDataInfo = new TableDataInfo();
        tableDataInfo.setCode(0);
        tableDataInfo.setMsg("");
        tableDataInfo.setCount(orglist.size());
        tableDataInfo.setData(orglist);
        return JSON.toJSONString(tableDataInfo);
    }
    
    /** 加载组织列表树 */
    @GetMapping("/showorgTree")
    @ResponseBody
    public List<Map<String, Object>> roleMenuTreeData(@RequestParam("orgId") Long orgId)
    {
        List<Map<String, Object>> tree = organizationService.selectOrgTreeByOrgId(orgId);
        return tree;
    }
    
    @RequestMapping("/add")
    public String addOrganization()
    {
        return "organization/addorganization";
    }
    
    @PostMapping("/addOrganization")
    @ResponseBody
    public String addOrganization(Organization organization)
    {
        organizationService.insertOrg(organization);
        return buildSuccessJsonMsg("organization.add.success");
    }
    
    @PostMapping("/delOrganization")
    @ResponseBody
    public String delOrganization(@RequestParam("orgId") Long orgId)
    {
        organizationService.deleteOrgByIds(orgId);
        return buildSuccessJsonMsg("organization.del.success");
    }
    
    @RequestMapping("/edit/{orgId}")
    public String detailOrganization(Model model, @PathVariable("orgId") Long orgId)
    {
        model.addAttribute("organization", organizationService.selectOrgByOrgId(orgId));
        return "/organization/editorganization";
    }
    
    @RequestMapping("/editOrg")
    @ResponseBody
    public String detailOrganization(Organization organization)
    {
        organizationService.updateOrg(organization);
        return buildSuccessJsonMsg("organization.edit.success");
    }
    
    @RequestMapping("/bind")
    @ResponseBody
    public String bindOrg(Organization organization)
    {
        organizationService.bindOrg(organization);
        return buildSuccessJsonMsg("organization.bind.success");
    }
    
    @RequestMapping("bindOrganization/{orgId}")
    public String bindOrganization(Model model, @PathVariable("orgId") Long orgId)
    {
        model.addAttribute("organization", organizationService.selectOrgByOrgId(orgId));
        return "/organization/bindorganization";
    }
    
    @RequestMapping("/untied/{orgId}")
    @ResponseBody
    public String untiedOrg(@PathVariable("orgId") Long orgId)
    {
        organizationService.untiedOrg(orgId);
        return buildSuccessJsonMsg("organization.untied.success");
    }
}
