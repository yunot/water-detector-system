package com.isoftstone.platform.sm.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.isoftstone.platform.entity.BaseSelectBean;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.platform.sm.entity.MenuBean;
import com.isoftstone.platform.sm.entity.RoleBean;
import com.isoftstone.platform.sm.entity.UserRoleBean;
import com.isoftstone.warehouse.entity.WarehouseSearch;

@Repository("roleDao")
public interface UserRoleDao
{
    
    /**
     * �����û�ID��ѯ��ɫ
     *
     * @param userId �û�ID
     * @return ��ɫ�б�
     */
    public List<RoleBean> selectRolesByUserId(Long userId);
    
    List<RoleBean> getRoleDataList(@Param("role")
    WarehouseSearch warehouseSearch, @Param("paging")
    PagingBean pagingBean);
    
    Integer queryRoleTotal(@Param("role")
    WarehouseSearch warehouseSearch);
    
    void addRole(@Param("addRole")
    RoleBean roleBean);
    
    void modifyRole(@Param("modifyRole")
    RoleBean roleBean);
    
    void deleteRole(@Param("deleteRole")
    String id);
    
    List<UserRoleBean> queryUserRole();
    
    List<UserRoleBean> queryRolePrivilege();
    
    public List<UserRoleBean> queryRoleID(@Param("queryIDs")
    String[] idsArray);
    
    public void deletePrivilege(@Param("deletePrivilege")
    String id);
    
    public void deleteUserRole(@Param("deleteUserRole")
    String id);
    
    List<MenuBean> getMenuList();
    
    //���û���ɫ���в���һ����¼
    void insertMenuRefRole(@Param("menuID")
    String menuID, @Param("roleId")
    String roleId);
    
    //ɾ���û���ɫ����һ����¼
    void deleteRoleById(@Param("menuID")
    String menuID, @Param("roleId")
    String roleId);
    
    List<MenuBean> queryMenuListByRoleId(@Param("roleId")
    String roleId);
    
    List<RoleBean> getRoleDataShowList(@Param("role")
    WarehouseSearch warehouseSearch);
    
    List<BaseSelectBean> getAll();
    
}
