package com.isoftstone.platform.sm.service;

import java.util.List;

import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.platform.entity.ZTreeInfoBean;
import com.isoftstone.platform.sm.entity.ApplyBean;
import com.isoftstone.platform.sm.entity.DepartmentBean;
import com.isoftstone.platform.sm.entity.UserInfoBean;

public interface DepartService
{
    
    List<DepartmentBean> queryDepartList();
    
    List<ZTreeInfoBean> getZTreeData(List<DepartmentBean> departList);
    
    DepartmentBean queryDeptOrPostInfo(String id, String deptName);
    
    PadingRstType<UserInfoBean> queryStaffByDept(String deptName, String deptId, PagingBean pagingBean);
    
    void addDept(String orgName, String deptParName, String deptName, String deptEngName, String deptDesc);
    
    void updateDept(String id, String deptName, String deptEngName, String deptDesc);
    
    boolean deleteDept(String id);
    
    boolean lockDept(String pardeptLock, String curdeptLock);
    
    void unlockDept(String curdeptLock);
    
    void allocateStaffToDept(String staffIDs, String dept);
    
    String queryDeptByStaff(String userID);
    
    void apply(String userID, String applyDept);
    
    PadingRstType<ApplyBean> queryApplyInfoByStaff(String userID, PagingBean pagingBean);
    
    PadingRstType<ApplyBean> queryApplyStaffList(String userID, PagingBean pagingBean);
    
    void updateStaffDeptWithPass(String staffID);
    
    void updateStaffDeptWithRefuse(String staffID);
    
    List<String> queryStaffAndDept(PadingRstType<UserInfoBean> rst);
    
    PadingRstType<ApplyBean> queryStaffByDeptManager(String userID, PagingBean pagingBean);
    
    PadingRstType<ApplyBean> queryStaffByManager(PagingBean pagingBean);
    
    void manageDept(String userID, String applyDept);
}
