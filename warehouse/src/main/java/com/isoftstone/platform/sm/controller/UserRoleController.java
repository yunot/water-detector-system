package com.isoftstone.platform.sm.controller;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.isoftstone.platform.common.uitl.PlatformUtil;
import com.isoftstone.platform.controller.BaseController;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.platform.entity.ZTreeInfoBean;
import com.isoftstone.platform.sm.entity.DeleteException;
import com.isoftstone.platform.sm.entity.MenuBean;
import com.isoftstone.platform.sm.entity.RoleBean;
import com.isoftstone.platform.sm.service.MenuService;
import com.isoftstone.platform.sm.service.UserRoleService;
import com.isoftstone.rookie.framework.annotation.Log;
import com.isoftstone.rookie.framework.constant.ModConstant;
import com.isoftstone.rookie.framework.constant.SysConstant;
import com.isoftstone.warehouse.entity.WarehouseSearch;

@Controller
@RequestMapping("/role")
public class UserRoleController extends BaseController
{

    private final static Logger logger = Logger.getLogger(UserRoleController.class);

    @Resource
    private UserRoleService roleService;

    @Resource
    private MenuService menuService;

    @RequestMapping("/roleManager")
    public String role()
    {
        return "/role/roleManager";
    }

    @RequestMapping(value = "/getRoleDataList", produces = "application/json")
    @ResponseBody
    public String getRoledata(WarehouseSearch warehouseSearch, PagingBean pagingBean)
    {
        logger.info(pagingBean);
        PadingRstType<RoleBean> rst = roleService.getRoleDataList(warehouseSearch, pagingBean);
        return JSON.toJSONString(rst);
    }

    @RequestMapping(value = "/getRoleDataShowList", produces = "application/json")
    @ResponseBody
    public String getRoleDataShowList(WarehouseSearch warehouseSearch)
    {
        List<RoleBean> rst = roleService.getRoleDataShowList(warehouseSearch);
        return JSON.toJSONString(rst);
    }

    @RequestMapping(value = "/addRole", produces = "application/json")
    @Log(module = SysConstant.MODULE_BRANCH.SM.ROLE_MANAGER, function = ModConstant.FUNCTION_BRANCH.ROLE_BUTTON.ROLE_ADD)
    @ResponseBody
    public String addRole(RoleBean roleBean)
    {
        logger.info(roleBean.getRoleName() + "," + roleBean.getRoleDescribe());
        roleService.addRole(roleBean);
        return buildSuccessJsonMsg("role.add.sucess");
    }

    @RequestMapping(value = "/modifyRole", produces = "application/json")
    @Log(module = SysConstant.MODULE_BRANCH.SM.ROLE_MANAGER, function = ModConstant.FUNCTION_BRANCH.ROLE_BUTTON.ROLE_MODIFY)
    @ResponseBody
    public String modifyRole(RoleBean roleBean)
    {
        logger.info(roleBean.getRoleName() + "," + roleBean.getRoleDescribe());
        roleService.modifyRole(roleBean);
        return buildSuccessJsonMsg("role.modify.sucess");
    }

    @RequestMapping(value = "/deleteRole", produces = "application/json")
    @Log(module = SysConstant.MODULE_BRANCH.SM.ROLE_MANAGER, function = ModConstant.FUNCTION_BRANCH.ROLE_BUTTON.ROLE_DELETE)
    @ResponseBody
    public String deleteRole(@RequestParam("roleId")
    String ids)
            throws Exception
    {
        logger.info(ids);
        try
        {
            roleService.deleteRole(ids);
        }
        catch (DeleteException e)
        {
            return buildFailJsonMsg("role.delete.failed");
        }
        return buildSuccessJsonMsg("role.delete.sucess");
    }

    @RequestMapping(value = "/getZTreeData", produces = "application/json")
    @ResponseBody
    public String getZTreeData(HttpServletRequest request, String roleId)
    {
        HttpSession session = request.getSession();

        List<MenuBean> menuList = (List<MenuBean>)session.getAttribute("menuList");
        List<ZTreeInfoBean> list = roleService.getZTreeData(menuList, roleId);
        
        Map<String, Object> message = new LinkedHashMap<>();
        message.put("success", true);
        message.put("list", list);
        String rst = PlatformUtil.toJSON(message);
        return rst;
    }

    @RequestMapping(value = "/insertMenuRefRole", produces = "application/json")
    @Log(module = SysConstant.MODULE_BRANCH.SM.ROLE_MANAGER, function = ModConstant.FUNCTION_BRANCH.ROLE_BUTTON.ROLE_GRANT)
    @ResponseBody
    public String insertMenuRefRole(@RequestParam("roleIds")
    String roleIds, @RequestParam("roleId")
    String roleId)
    {
        roleService.insertMenuRefRole(roleIds, roleId);
        return buildSuccessJsonMsg("role.delete.sucess");
    }
}
