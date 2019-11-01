package com.isoftstone.platform.sm.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.platform.sm.entity.ApplyBean;
import com.isoftstone.platform.sm.entity.DepartmentBean;
import com.isoftstone.platform.sm.entity.PostBean;
import com.isoftstone.platform.sm.entity.UserInfoBean;

@Repository("departDao")
public interface DepartDao
{
    
    List<DepartmentBean> queryDepartList();
    
    String queryOrgNameByID(String orgID);
    
    List<UserInfoBean> queryStaffByDept(@Param("depID") String deptName, @Param("paging") PagingBean PagingBean);
    
    DepartmentBean queryDeptOrPostInfo(String id);
    
    Integer queryStaffTotal(@Param("depID") String deptName);
    
    Integer queryParDeptId(String deptParName);
    
    void insertDept(@Param("deptName") String deptName, @Param("deptDesc") String deptDesc, @Param("id") Integer id,
        @Param("orgID") Integer orgID);
    
    void insertDict(@Param("deptName") String deptName, @Param("deptEngName") String deptEngName);
    
    void insertCH(@Param("id") Integer newId, @Param("deptName") String deptName);
    
    void insertEH(@Param("id") Integer newId, @Param("deptEngName") String deptEngName);
    
    String queryInter(String depID);
    
    Integer queryOrgID(String orgName);
    
    Integer queryDictID(String deptName);
    
    void updateDept(@Param("id") String id, @Param("deptName") String deptName, @Param("deptDesc") String deptDesc);
    
    void updateDict(@Param("id") Integer id, @Param("deptName") String deptName,
        @Param("deptEngName") String deptEngName);
    
    void updateCH(@Param("id") Integer id, @Param("deptName") String deptName);
    
    void updateEH(@Param("id") Integer id, @Param("deptEngName") String deptEngName);
    
    Integer queryDictIDByDeptID(String id);
    
    List<DepartmentBean> querySonDept(String id);
    
    List<UserInfoBean> queryStaffBelongToDept(String id);
    
    void deleteDept(String id);
    
    void deleteDictDept(Integer id);
    
    void deleteInter(Integer id);
    
    Integer queryCurDeptLock(String curdeptLock);
    
    void updateCurDeptLock(@Param("pardeptLock") String pardeptLock, @Param("curdeptLock") String curdeptLock);
    
    void updateCurDeptUnlock(String curdeptLock);
    
    List<DepartmentBean> queryDeptAndSonDept(String deptName);
    
    List<UserInfoBean> queryStaffWithoutDept();
    
    Integer queryStaffExist(String userId);
    
    void insertStaff(@Param("userId") String userId, @Param("deptId") Integer deptId);
    
    void updateStaff(@Param("userId") String userId, @Param("deptId") Integer deptId);
    
    String queryDeptByStaff(String userID);
    
    void apply(@Param("userID") String userID, @Param("applyDept") String applyDept);
    
    List<ApplyBean> queryApplyInfoByStaff(String userID);
    
    String queryDeptNameById(Integer depId);
    
    List<ApplyBean> queryApplyStaffList(String userId);
    
    String queryStaffNameByID(String userId);
    
    void updateStaffDeptWithPass(String staffID);
    
    void updateStaffDeptWithRefuse(String staffID);
    
    List<ApplyBean> queryApplyStaffListWithoutStatus(String userID);
    
    List<ApplyBean> queryStaffList();
    
    void manageDept(@Param("userID") String userID, @Param("applyDept") String applyDept);
    
    List<PostBean> queryPostListByDept(String depID);
    
    String findByPost(@Param("userId") String userId, @Param("postId") String postId);
}
