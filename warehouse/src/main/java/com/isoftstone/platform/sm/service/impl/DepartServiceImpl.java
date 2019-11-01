package com.isoftstone.platform.sm.service.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.platform.entity.ZTreeInfoBean;
import com.isoftstone.platform.sm.entity.ApplyBean;
import com.isoftstone.platform.sm.entity.DepartmentBean;
import com.isoftstone.platform.sm.entity.PostBean;
import com.isoftstone.platform.sm.entity.UserInfoBean;
import com.isoftstone.platform.sm.repository.DepartDao;
import com.isoftstone.platform.sm.repository.PostDao;
import com.isoftstone.platform.sm.service.DepartService;

@Service("departService")
public class DepartServiceImpl implements DepartService
{
    @Resource
    private DepartDao departDao;
    
    @Resource
    private PostDao postDao;
    
    @Override
    public List<DepartmentBean> queryDepartList()
    {
        List<DepartmentBean> list = departDao.queryDepartList();
        
        //存放岗位
        List<DepartmentBean> pos = new ArrayList<>();
        //查询各个部门下的岗位
        for (DepartmentBean departmentBean : list)
        {
            String depID = departmentBean.getDepID();
            List<PostBean> postList = departDao.queryPostListByDept(depID);
            for (PostBean postBean : postList)
            {
                DepartmentBean depart = new DepartmentBean();
                depart.setDepID(postBean.getPostID() + "");
                depart.setDepName(postBean.getPostName());
                depart.setDepParID(depID);
                depart.setDepDesc(postBean.getPostDescribe());
                pos.add(depart);
            }
        }
        list.addAll(pos);
        
        //存放组织
        LinkedHashSet<String> linkedHashSet = new LinkedHashSet<String>();
        for (DepartmentBean departmentBean : list)
        {
            String orgName = departDao.queryOrgNameByID(departmentBean.getOrgID());
            departmentBean.setOrgID(orgName);
            linkedHashSet.add(orgName);
        }
        
        //补充组织
        Iterator<String> it = linkedHashSet.iterator();
        List<String> lis = new ArrayList<String>();
        while (it.hasNext())
        {
            lis.add(it.next());
        }
        for (int i = 0; i < lis.size(); i++)
        {
            DepartmentBean department = new DepartmentBean();
            department.setDepID("1000" + i);
            department.setDepName(lis.get(i));
            if (!"贸易电商".equals(lis.get(i)))
            {
                department.setDepParID("10002");
            }
            else
            {
                department.setDepParID("-1");
            }
            department.setOrgID("random");
            list.add(department);
        }
        
        //重新生成树
        for (DepartmentBean departmentBean : list)
        {
            String orgName = departmentBean.getOrgID();
            String parID = departmentBean.getDepParID();
            for (int i = 0; i < lis.size(); i++)
            {
                if ("-1".equals(parID) && orgName.equals(lis.get(i)))
                {
                    departmentBean.setDepParID("1000" + i);
                }
            }
        }
        return list;
    }
    
    @Override
    public List<ZTreeInfoBean> getZTreeData(List<DepartmentBean> departList)
    {
        Iterator<DepartmentBean> it = departList.iterator();
        while (it.hasNext())
        {
            DepartmentBean departmentBean = (DepartmentBean)it.next();
            if (departmentBean.getDepName() == null)
            {
                it.remove();
            }
        }
        
        List<ZTreeInfoBean> ztreeInfoList = new ArrayList<ZTreeInfoBean>();
        
        DepartmentBean departBean = new DepartmentBean();
        for (int i = 0; i < departList.size(); i++)
        {
            ZTreeInfoBean ztreeInfoBean = new ZTreeInfoBean();
            departBean.setDepID(ztreeInfoBean.getId() + "");
            ztreeInfoBean.setId(Integer.parseInt(departList.get(i).getDepID()));
            ztreeInfoBean.setName(departList.get(i).getDepName());
            ztreeInfoBean.setpId(Integer.parseInt(departList.get(i).getDepParID()));
            ztreeInfoList.add(ztreeInfoBean);
        }
        return ztreeInfoList;
    }
    
    @Override
    public DepartmentBean queryDeptOrPostInfo(String id, String deptName)
    {
        DepartmentBean depart = new DepartmentBean();
        if (Integer.parseInt(id) < 100)
        {
            PostBean postBean = postDao.queryDetail(id);
            depart.setDepID(postBean.getPostID() + "");
            depart.setDepName(postBean.getPostName());
            depart.setDepDesc(postBean.getPostDescribe());
            depart.setOrgID("post");
        }
        else
        {
            depart = departDao.queryDeptOrPostInfo(id);
            if (depart != null)
            {
                depart.setOrgID("dept");
            }
            else
            {
                depart = null;
            }
        }
        
        if (depart != null)
        {
            //获取字典表中部门ID
            Integer newId = departDao.queryDictID(deptName);
            String departEngName = departDao.queryInter(newId + "");
            depart.setSort(departEngName);
        }
        return depart;
    }
    
    @Override
    public PadingRstType<UserInfoBean> queryStaffByDept(String id, String deptId, PagingBean pagingBean)
    {
        pagingBean.deal(UserInfoBean.class);
        //根据部门查询员工
        List<UserInfoBean> userBeanList = new ArrayList<>();
        //员工数
        Integer total = 0;
        
        //根据部门查询该部门及子部门
        List<DepartmentBean> deptList = departDao.queryDeptAndSonDept(deptId);
        for (DepartmentBean departmentBean : deptList)
        {
            List<UserInfoBean> list = departDao.queryStaffByDept(departmentBean.getDepID(), pagingBean);
            total += departDao.queryStaffTotal(departmentBean.getDepID());
            userBeanList.addAll(list);
        }
        
        //根据岗位筛选员工
        if (id != null && !"".equals(id))
        {
            Iterator<UserInfoBean> it = userBeanList.iterator();
            while (it.hasNext())
            {
                UserInfoBean userInfoBean = (UserInfoBean)it.next();
                String rst = departDao.findByPost(userInfoBean.getUserId().toString(), id);
                if (rst == null)
                {
                    it.remove();
                }
            }
        }
        
        //查询没有部门的员工
        List<UserInfoBean> userList = departDao.queryStaffWithoutDept();
        userBeanList.addAll(userList);
        total += userList.size();
        
        PadingRstType<UserInfoBean> userBean = new PadingRstType<UserInfoBean>();
        userBean.setPage(pagingBean.getPage());
        userBean.setTotal(total);
        userBean.putItems(UserInfoBean.class, userBeanList);
        
        return userBean;
    }
    
    @Override
    public void addDept(String orgName, String deptParName, String deptName, String deptEngName, String deptDesc)
    {
        //查出组织ID
        Integer orgID = departDao.queryOrgID(orgName);
        //查出父部门ID
        Integer id = departDao.queryParDeptId(deptParName);
        //向部门表插入数据
        departDao.insertDept(deptName, deptDesc, id, orgID);
        //向字典表插入数据
        departDao.insertDict(deptName, deptEngName);
        //获取新增字典表数据ID
        Integer newId = departDao.queryDictID(deptName);
        //国际化
        departDao.insertCH(newId, deptName);
        departDao.insertEH(newId, deptEngName);
    }
    
    @Override
    public void updateDept(String id, String deptName, String deptEngName, String deptDesc)
    {
        //获取字典表中部门ID
        Integer newId = departDao.queryDictIDByDeptID(id);
        //修改部门表信息
        departDao.updateDept(id, deptName, deptDesc);
        //修改字典表
        departDao.updateDict(newId, deptName, deptEngName);
        //修改国际化
        departDao.updateCH(newId, deptName);
        departDao.updateEH(newId, deptEngName);
    }
    
    @Override
    public boolean deleteDept(String id)
    {
        boolean flag = false;
        //查询有无子部门
        List<DepartmentBean> deptList = departDao.querySonDept(id);
        //查询有无员工
        List<UserInfoBean> staffList = departDao.queryStaffBelongToDept(id);
        if (deptList.size() == 0 && staffList.size() == 0)
        {
            flag = true;
            Integer oldID = departDao.queryDictIDByDeptID(id);
            //删除部门表记录
            departDao.deleteDept(id);
            //删除字典表记录
            departDao.deleteDictDept(oldID);
            //删除国际化表记录
            departDao.deleteInter(oldID);
        }
        return flag;
    }
    
    @Override
    public boolean lockDept(String pardeptLock, String curdeptLock)
    {
        boolean flag = false;
        //判断当前部门是否有父部门
        Integer pID = departDao.queryCurDeptLock(curdeptLock);
        if (pID == -1)//没有父部门
        {
            flag = true;
            //绑定当前部门
            departDao.updateCurDeptLock(pardeptLock, curdeptLock);
        }
        return flag;
    }
    
    @Override
    public void unlockDept(String curdeptLock)
    {
        departDao.updateCurDeptUnlock(curdeptLock);
    }
    
    @Override
    public void allocateStaffToDept(String staffIDs, String dept)
    {
        String[] userIDArray = staffIDs.split(",");
        Integer deptId = departDao.queryParDeptId(dept);
        for (String userId : userIDArray)
        {
            //查询员工部门表是否有该员工存在
            Integer flag = departDao.queryStaffExist(userId);
            if (flag == null)
            {//不存在则插入记录
                departDao.insertStaff(userId, deptId);
            }
            else
            {//存在则修改记录
                departDao.updateStaff(userId, deptId);
            }
        }
    }
    
    @Override
    public String queryDeptByStaff(String userID)
    {
        return departDao.queryDeptByStaff(userID);
    }
    
    @Override
    public void apply(String userID, String applyDept)
    {
        departDao.apply(userID, applyDept);
    }
    
    @Override
    public PadingRstType<ApplyBean> queryApplyInfoByStaff(String userID, PagingBean pagingBean)
    {
        pagingBean.deal(ApplyBean.class);
        List<ApplyBean> applyList = departDao.queryApplyInfoByStaff(userID);
        for (ApplyBean applyBean : applyList)
        {
            applyBean.setUserId(Integer.parseInt(userID));
            applyBean.setDepId(departDao.queryDeptNameById(Integer.parseInt(applyBean.getDepId())));
            applyBean.setDepApplyId(departDao.queryDeptNameById(Integer.parseInt(applyBean.getDepApplyId())));
            String status = applyBean.getStatus();
            if ("0".equals(status))
            {
                applyBean.setStatus("待处理");
            }
            else if ("1".equals(status))
            {
                applyBean.setStatus("同意");
            }
            else
            {
                applyBean.setStatus("拒绝");
            }
        }
        PadingRstType<ApplyBean> applyBean = new PadingRstType<ApplyBean>();
        applyBean.setPage(pagingBean.getPage());
        applyBean.setTotal(1);
        applyBean.putItems(ApplyBean.class, applyList);
        return applyBean;
    }
    
    @Override
    public PadingRstType<ApplyBean> queryApplyStaffList(String userID, PagingBean pagingBean)
    {
        pagingBean.deal(ApplyBean.class);
        List<ApplyBean> userList = departDao.queryApplyStaffList(userID);
        for (ApplyBean ab : userList)
        {
            ab.setUserId(Integer.parseInt(ab.getUserId() + ""));
            ab.setDepId(departDao.queryDeptNameById(Integer.parseInt(ab.getDepId())));
            ab.setDepApplyId(departDao.queryDeptNameById(Integer.parseInt(ab.getDepApplyId())));
            ab.setStatus(departDao.queryStaffNameByID(ab.getUserId() + ""));
        }
        PadingRstType<ApplyBean> applyBean = new PadingRstType<ApplyBean>();
        applyBean.setPage(pagingBean.getPage());
        applyBean.setTotal(userList.size());
        applyBean.putItems(ApplyBean.class, userList);
        return applyBean;
    }
    
    @Override
    public void updateStaffDeptWithPass(String staffID)
    {
        departDao.updateStaffDeptWithPass(staffID);
    }
    
    @Override
    public void updateStaffDeptWithRefuse(String staffID)
    {
        departDao.updateStaffDeptWithRefuse(staffID);
    }
    
    @Override
    public List<String> queryStaffAndDept(PadingRstType<UserInfoBean> rst)
    {
        List<UserInfoBean> list = rst.getRawRecords();
        List<String> staffList = new ArrayList<>();
        for (UserInfoBean userInfoBean : list)
        {
            String deptName = departDao.queryDeptByStaff(userInfoBean.getUserId() + "");
            staffList.add(userInfoBean.getName() + "," + deptName);
        }
        return staffList;
    }
    
    @Override
    public PadingRstType<ApplyBean> queryStaffByDeptManager(String userID, PagingBean pagingBean)
    {
        pagingBean.deal(ApplyBean.class);
        List<ApplyBean> userList = departDao.queryApplyStaffListWithoutStatus(userID);
        for (ApplyBean ab : userList)
        {
            ab.setUserId(Integer.parseInt(ab.getUserId() + ""));
            ab.setDepId(departDao.queryDeptNameById(Integer.parseInt(ab.getDepId())));
            ab.setDepApplyId(departDao.queryDeptNameById(Integer.parseInt(ab.getDepApplyId())));
            ab.setStatus(departDao.queryStaffNameByID(ab.getUserId() + ""));
        }
        PadingRstType<ApplyBean> applyBean = new PadingRstType<ApplyBean>();
        applyBean.setPage(pagingBean.getPage());
        applyBean.setTotal(userList.size());
        applyBean.putItems(ApplyBean.class, userList);
        return applyBean;
    }
    
    @Override
    public PadingRstType<ApplyBean> queryStaffByManager(PagingBean pagingBean)
    {
        pagingBean.deal(ApplyBean.class);
        List<ApplyBean> userList = departDao.queryStaffList();
        for (ApplyBean ab : userList)
        {
            ab.setUserId(Integer.parseInt(ab.getUserId() + ""));
            ab.setDepId(departDao.queryDeptNameById(Integer.parseInt(ab.getDepId())));
            if (ab.getDepApplyId() != null)
            {
                ab.setDepApplyId(departDao.queryDeptNameById(Integer.parseInt(ab.getDepApplyId())));
            }
            else
            {
                ab.setDepApplyId("");
            }
            if (ab.getUserId() != null)
            {
                ab.setStatus(departDao.queryStaffNameByID(ab.getUserId() + ""));
            }
            else
            {
                ab.setStatus("");
            }
        }
        PadingRstType<ApplyBean> applyBean = new PadingRstType<ApplyBean>();
        applyBean.setPage(pagingBean.getPage());
        applyBean.setTotal(userList.size());
        applyBean.putItems(ApplyBean.class, userList);
        return applyBean;
    }
    
    @Override
    public void manageDept(String userID, String applyDept)
    {
        departDao.manageDept(userID, applyDept);
    }
    
}
