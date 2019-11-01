package com.isoftstone.platform.sm.controller;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.isoftstone.platform.common.uitl.PlatformUtil;
import com.isoftstone.platform.controller.BaseController;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.platform.entity.ZTreeInfoBean;
import com.isoftstone.platform.sm.entity.ApplyBean;
import com.isoftstone.platform.sm.entity.DepartmentBean;
import com.isoftstone.platform.sm.entity.UserInfoBean;
import com.isoftstone.platform.sm.service.DepartService;

@Controller
@RequestMapping("/depart")
public class DepartController extends BaseController
{
    @Resource
    private DepartService departService;
    
    @RequestMapping("/depList")
    public String initPage(Model model)
    {
        List<DepartmentBean> departList = departService.queryDepartList();
        List<ZTreeInfoBean> list = departService.getZTreeData(departList);
        model.addAttribute("deparZTree", PlatformUtil.toJSON(list));
        return "depart/departList";
    }
    
    //������֯������
    @RequestMapping("/queryDepartList")
    @ResponseBody
    public String queryDepartList()
    {
        List<DepartmentBean> departList = departService.queryDepartList();
        List<ZTreeInfoBean> list = departService.getZTreeData(departList);
        Map<String, Object> message = new LinkedHashMap<>();
        message.put("success", true);
        message.put("list", list);
        String rst = PlatformUtil.toJSON(message);
        return rst;
    }
    
    //��ѯ������Ա
    @RequestMapping(value = "/queryUserList", produces = "application/json")
    @ResponseBody
    public String queryStaff(@RequestParam("id") String id, @RequestParam("deptId") String deptId,
        PagingBean pagingBean)
    {
        //id:��λID��deptId:����ID
        PadingRstType<UserInfoBean> rst = departService.queryStaffByDept(id, deptId, pagingBean);
        return JSON.toJSONString(rst);
    }
    
    //��ѯָ�����Ż���֯��Ϣ
    @RequestMapping("/queryDeptOrPostInfo")
    @ResponseBody
    public String queryDeptOrPostInfo(HttpServletRequest request)
    {
        String id = request.getParameter("id");
        String deptName = request.getParameter("deptName");
        DepartmentBean deptInfo = departService.queryDeptOrPostInfo(id, deptName);
        return JSON.toJSONString(deptInfo);
    }
    
    //���Ӳ���
    @RequestMapping("/addDept")
    @ResponseBody
    public String addDept(HttpServletRequest request)
    {
        String orgName = request.getParameter("orgName");
        String deptParName = request.getParameter("deptParName");
        String deptName = request.getParameter("deptName");
        String deptEngName = request.getParameter("deptEngName");
        String deptDesc = request.getParameter("deptDesc");
        departService.addDept(orgName, deptParName, deptName, deptEngName, deptDesc);
        return buildSuccessJsonMsg("dept.add.success");
    }
    
    //�޸Ĳ���
    @RequestMapping("/updateDept")
    @ResponseBody
    public String updateDept(HttpServletRequest request)
    {
        String deptName = request.getParameter("deptName");
        String deptEngName = request.getParameter("deptEngName");
        String deptDesc = request.getParameter("deptDesc");
        String id = request.getParameter("id");
        departService.updateDept(id, deptName, deptEngName, deptDesc);
        return buildSuccessJsonMsg("dept.update.success");
    }
    
    //ɾ������
    @RequestMapping("/deleteDept")
    @ResponseBody
    public boolean deleteDept(HttpServletRequest request)
    {
        String id = request.getParameter("id");
        boolean flag = departService.deleteDept(id);
        return flag;
    }
    
    //�󶨲���
    @RequestMapping("/lockDept")
    @ResponseBody
    public boolean lockDept(HttpServletRequest request)
    {
        String pardeptLock = request.getParameter("pardeptLock");
        String curdeptLock = request.getParameter("curdeptLock");
        boolean flag = departService.lockDept(pardeptLock, curdeptLock);
        return flag;
    }
    
    //��󶨲���
    @RequestMapping("/unlockDept")
    @ResponseBody
    public String unlockDept(HttpServletRequest request)
    {
        String curdeptLock = request.getParameter("curdeptUnlock");
        departService.unlockDept(curdeptLock);
        return buildSuccessJsonMsg("dept.unlock.success");
    }
    
    //����Ա��
    @RequestMapping("/allocateStaff")
    @ResponseBody
    public String allocateStaffToDept(HttpServletRequest request)
    {
        String staffIDs = request.getParameter("ids");
        String dept = request.getParameter("dept");
        departService.allocateStaffToDept(staffIDs, dept);
        return buildSuccessJsonMsg("dept.allocate.success");
    }
    
    //�����л�
    @RequestMapping("/switchDept")
    public String skipPage()
    {
        return "depart/switchDept";
    }
    
    //��ѯԱ����ǰ����
    @RequestMapping("/queryStaffDept")
    @ResponseBody
    public String queryStaffDept(HttpServletRequest request)
    {
        String userID = request.getParameter("userID");
        String curDeptName = departService.queryDeptByStaff(userID);
        return JSON.toJSONString(curDeptName);
    }
    
    //����
    @RequestMapping("/apply")
    @ResponseBody
    public String applyDept(HttpServletRequest request)
    {
        String userID = request.getParameter("userID");
        String applyDept = request.getParameter("applyDept");
        departService.apply(userID, applyDept);
        return buildSuccessJsonMsg("dept.apply.success");
    }
    
    //Ա���������
    @RequestMapping("/applyCondition")
    @ResponseBody
    public String applyCondition(HttpServletRequest request, PagingBean pagingBean)
    {
        String userID = request.getParameter("userID");
        PadingRstType<ApplyBean> list = departService.queryApplyInfoByStaff(userID, pagingBean);
        return JSON.toJSONString(list);
    }
    
    //����
    @RequestMapping("/approveApply")
    @ResponseBody
    public String approveApply(HttpServletRequest request, PagingBean pagingBean)
    {
        String userID = request.getParameter("userID");
        PadingRstType<ApplyBean> list = departService.queryApplyStaffList(userID, pagingBean);
        return JSON.toJSONString(list);
    }
    
    //����ͨ��
    @RequestMapping("/applyPass")
    @ResponseBody
    public String approvePass(HttpServletRequest request)
    {
        String staffID = request.getParameter("staffID");
        departService.updateStaffDeptWithPass(staffID);
        return buildSuccessJsonMsg("dept.approve.success");
    }
    
    //�����ܾ�
    @RequestMapping("/applyRefuse")
    @ResponseBody
    public String applyRefuse(HttpServletRequest request)
    {
        String staffID = request.getParameter("staffID");
        departService.updateStaffDeptWithRefuse(staffID);
        return buildSuccessJsonMsg("dept.approve.refuse");
    }
    
    //������
    @RequestMapping("/replaceStaffList")
    @ResponseBody
    public String replaceStaffList(HttpServletRequest request, PagingBean pagingBean)
    {
        String userID = request.getParameter("userID");
        PadingRstType<ApplyBean> rst = departService.queryStaffByDeptManager(userID, pagingBean);
        return JSON.toJSONString(rst);
    }
    
    //����Աֱ���л�����
    @RequestMapping("/cutStaffList")
    @ResponseBody
    public String cutStaffList(PagingBean pagingBean)
    {
        PadingRstType<ApplyBean> rst = departService.queryStaffByManager(pagingBean);
        return JSON.toJSONString(rst);
    }
    
    //����Ա�л�����
    @RequestMapping("/managerOperation")
    @ResponseBody
    public String manageDept(HttpServletRequest request)
    {
        String userID = request.getParameter("userID");
        String applyDept = request.getParameter("applyDept");
        departService.manageDept(userID, applyDept);
        return buildSuccessJsonMsg("dept.cut.success");
    }
}
