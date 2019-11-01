package com.isoftstone.rookie.system.organization.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.isoftstone.platform.sm.entity.DepartmentBean;
import com.isoftstone.platform.sm.entity.PostBean;
import com.isoftstone.rookie.system.organization.entity.Organization;

/**
 *
 * @author ZSJ
 */
@Repository
public interface OrganizationMapper
{
    //查出所有组织
    List<Organization> selectOrgList();
    
    List<Map<String, Object>> selectByOrg(Organization organization);
    
    Organization selectOrgTreeByOrgId(@Param("orgId") Long orgId);
    
    //查出所有组织结构的部门
    List<DepartmentBean> selectDeptByOrgId();
    
    List<PostBean> selectPost();
    
    void insertOrg(Organization organization);
    
    void updateOrg(Organization organization);
    
    void bindOrg(Organization organization);
    
    void untiedOrg(@Param("orgId") Long orgId);
    
    void deleteOrgByIds(@Param("orgId") Long orgId);
    
    Organization selectOrgByOrgId(@Param("orgId") Long orgId);
    
}
