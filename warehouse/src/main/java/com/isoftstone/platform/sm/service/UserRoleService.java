package com.isoftstone.platform.sm.service;

import java.util.List;
import java.util.Set;

import com.isoftstone.platform.entity.BaseSelectBean;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.platform.entity.ZTreeInfoBean;
import com.isoftstone.platform.sm.entity.MenuBean;
import com.isoftstone.platform.sm.entity.RoleBean;
import com.isoftstone.warehouse.entity.WarehouseSearch;

public interface UserRoleService
{
    /**
     * 根据用户ID查询角色
     *
     * @param userId 用户ID
     * @return 权限列表
     * @author zsj
     */
    public Set<String> selectRoleKeys(Long userId);
    
    PadingRstType<RoleBean> getRoleDataList(WarehouseSearch warehouseSearch, PagingBean pagingBean);
    
    void modifyRole(RoleBean roleBean);
    
    void addRole(RoleBean roleBean);
    
    void deleteRole(String ids)
        throws Exception;
    
    List<ZTreeInfoBean> getZTreeData(List<MenuBean> menuList, String roleId);
    
    void insertMenuRefRole(String roleIds, String roleId);
    
    void deleteRoleById(String roleId, String menuID);
    
    List<RoleBean> getRoleDataShowList(WarehouseSearch warehouseSearch);
    
    List<BaseSelectBean> getAll();
    
}
