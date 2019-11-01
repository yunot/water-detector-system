package com.isoftstone.rookie.system.organization.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.isoftstone.platform.sm.entity.DepartmentBean;
import com.isoftstone.platform.sm.entity.PostBean;
import com.isoftstone.rookie.framework.constant.SysConstant;
import com.isoftstone.rookie.system.organization.dao.OrganizationMapper;
import com.isoftstone.rookie.system.organization.entity.Organization;
import com.isoftstone.rookie.system.organization.service.OrganizationService;

@Service
public class OrganizationServiceImpl implements OrganizationService
{
    @Resource
    private OrganizationMapper organizationMapper;
    
    @Override
    public List<Organization> selectOrgList()
    {
        return organizationMapper.selectOrgList();
    }
    
    @Override
    public List<DepartmentBean> selectDeptByOrgId()
    {
        return organizationMapper.selectDeptByOrgId();
    }
    
    @Override
    public List<PostBean> selectPost()
    {
        return organizationMapper.selectPost();
    }
    
    /**
     * 对象转组织树
     *
     * @param  organizationList 组织列表
     * @param isCheck 是否需要选中
     * @return
     */
    public List<Map<String, Object>> getTrees(List<Organization> organizationList, boolean isCheck)
    {
        
        List<Map<String, Object>> trees = new ArrayList<Map<String, Object>>();
        for (Organization organization : organizationList)
        {
            Map<String, Object> organizaitonMap = new HashMap<String, Object>();
            organizaitonMap.put("id", organization.getOrgId());
            organizaitonMap.put("pId", organization.getParentId());
            organizaitonMap.put("name", organization.getOrgName());
            organizaitonMap.put("status", organization.getStatus());
            organizaitonMap.put("type", SysConstant.ORGANIZATION_BRANCH.ORGANIZATION);
            trees.add(organizaitonMap);
        }
        return trees;
    }
    
    public List<Map<String, Object>> getTrees(List<DepartmentBean> departmentBeanList)
    {
        
        List<Map<String, Object>> trees = new ArrayList<Map<String, Object>>();
        for (DepartmentBean departmentBean : departmentBeanList)
        {
            Map<String, Object> deptMap = new HashMap<String, Object>();
            deptMap.put("id", Integer.parseInt(departmentBean.getDepID()));
            if ("-1".equals(departmentBean.getDepParID()))
            {
                deptMap.put("pId", Integer.parseInt(departmentBean.getOrgID()));
            }
            else
            {
                deptMap.put("pId", Integer.parseInt(departmentBean.getDepParID()));
            }
            deptMap.put("type", SysConstant.ORGANIZATION_BRANCH.DEPT);
            deptMap.put("name", departmentBean.getDepName());
            deptMap.put("status", "0");
            trees.add(deptMap);
        }
        return trees;
    }
    
    public List<Map<String, Object>> getDeptTrees(List<PostBean> postBeanList)
    {
        
        List<Map<String, Object>> trees = new ArrayList<Map<String, Object>>();
        for (PostBean postBean : postBeanList)
        {
            Map<String, Object> postMap = new HashMap<String, Object>();
            postMap.put("id", postBean.getDepID());
            postMap.put("pId", postBean.getOrgID());
            postMap.put("name", postBean.getPostName());
            postMap.put("type", SysConstant.ORGANIZATION_BRANCH.POST);
            postMap.put("status", "0");
            trees.add(postMap);
        }
        return trees;
    }
    
    /**
     * 查询组织管理树
     *
     * @return 所有组织信息
     */
    @Override
    public List<Map<String, Object>> selectOrgTree()
    {
        List<Map<String, Object>> trees = new ArrayList<Map<String, Object>>();
        List<Organization> organizationList = selectOrgList();
        trees = getTrees(organizationList, false);
        return trees;
    }
    
    @Override
    public List<Map<String, Object>> selectDeptTree()
    {
        List<Map<String, Object>> trees = new ArrayList<Map<String, Object>>();
        List<DepartmentBean> deptList = selectDeptByOrgId();
        trees = getTrees(deptList);
        return trees;
    }
    
    @Override
    public List<Map<String, Object>> selectPostTree()
    {
        List<Map<String, Object>> trees = new ArrayList<Map<String, Object>>();
        List<PostBean> postList = selectPost();
        trees = getDeptTrees(postList);
        return trees;
    }
    
    /**
     * 得到组织的所有子机构和部门、岗位
     *
     * */
    @Override
    public List<Map<String, Object>> selectOrgAll()
    {
        List<Map<String, Object>> list = new ArrayList<>();
        List<Map<String, Object>> orglist = selectOrgTree();
        List<Map<String, Object>> deptlist = selectDeptTree();
        List<Map<String, Object>> postlist = selectPostTree();
        list.addAll(deptlist);
        list.addAll(postlist);
        for (Map<String, Object> org : orglist)
        {
            for (Map<String, Object> sorg : list)
            {
                if (org.get("id") == sorg.get("pId"))
                {
                    org.put("isParent", "true");
                }
            }
        }
        list.addAll(orglist);
        return list;
    }
    
    @Override
    public List<Map<String, Object>> selectOrgTreeByOrgId(Long orgId)
    {
        List<Map<String, Object>> trees = new ArrayList<Map<String, Object>>();
        List<Organization> organizationList = new ArrayList<>();
        organizationList.add(organizationMapper.selectOrgTreeByOrgId(orgId));
        trees = getTrees(organizationList, false);
        return trees;
    }
    
    @Override
    public void insertOrg(Organization organization)
    {
        organizationMapper.insertOrg(organization);
    }
    
    @Override
    public void updateOrg(Organization organization)
    {
        organizationMapper.updateOrg(organization);
    }
    
    @Override
    public void deleteOrgByIds(Long orgId)
    {
        organizationMapper.deleteOrgByIds(orgId);
    }
    
    @Override
    public void bindOrg(Organization organization)
    {
        organizationMapper.bindOrg(organization);
    }
    
    @Override
    public void untiedOrg(Long orgId)
    {
        organizationMapper.untiedOrg(orgId);
    }
    
    @Override
    public Organization selectOrgByOrgId(Long orgId)
    {
        return organizationMapper.selectOrgByOrgId(orgId);
    }
    
}
