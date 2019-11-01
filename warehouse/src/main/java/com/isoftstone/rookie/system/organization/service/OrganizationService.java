package com.isoftstone.rookie.system.organization.service;

import java.util.List;
import java.util.Map;

import com.isoftstone.platform.sm.entity.DepartmentBean;
import com.isoftstone.platform.sm.entity.PostBean;
import com.isoftstone.rookie.system.organization.entity.Organization;

public interface OrganizationService
{
    
    List<Organization> selectOrgList();
    
    List<DepartmentBean> selectDeptByOrgId();
    
    List<PostBean> selectPost();
    
    List<Map<String, Object>> selectOrgTree();
    
    List<Map<String, Object>> selectDeptTree();
    
    List<Map<String, Object>> selectPostTree();
    
    List<Map<String, Object>> selectOrgAll();
    
    List<Map<String, Object>> selectOrgTreeByOrgId(Long orgId);
    
    void insertOrg(Organization organization);
    
    void updateOrg(Organization organization);
    
    void deleteOrgByIds(Long orgId);
    
    void bindOrg(Organization organization);
    
    void untiedOrg(Long orgId);
    
    Organization selectOrgByOrgId(Long orgId);
    
}
