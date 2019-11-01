package com.isoftstone.platform.sm.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.isoftstone.platform.entity.BaseSelectBean;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.platform.entity.ZTreeInfoBean;
import com.isoftstone.platform.sm.entity.DeleteException;
import com.isoftstone.platform.sm.entity.MenuBean;
import com.isoftstone.platform.sm.entity.RoleBean;
import com.isoftstone.platform.sm.entity.UserRoleBean;
import com.isoftstone.platform.sm.repository.UserRoleDao;
import com.isoftstone.platform.sm.service.UserRoleService;
import com.isoftstone.warehouse.entity.WarehouseSearch;

@Service("roleService")
public class UserRoleServiceImpl implements UserRoleService
{
    
    @Resource
    private UserRoleDao userRoleDao;
    
    /**
     * ����û�ID��ѯ��ɫ
     *
     * @param userId �û�ID
     * @return Ȩ���б�
     * @author zsj
     */
    @Override
    public Set<String> selectRoleKeys(Long userId)
    {
        List<RoleBean> perms = userRoleDao.selectRolesByUserId(userId);
        System.out.println(userId);
        System.out.println(JSON.toJSONString(perms));
        Set<String> permsSet = new HashSet<>();
        for (RoleBean perm : perms)
        {
            if (null != perms)
            {
                permsSet.add(perm.getRoleName());
            }
        }
        return permsSet;
    }
    
    @Override
    public PadingRstType<RoleBean> getRoleDataList(WarehouseSearch warehouseSearch, PagingBean pagingBean)
    {
        pagingBean.deal(RoleBean.class);
        List<RoleBean> roleBeanList = userRoleDao.getRoleDataList(warehouseSearch, pagingBean);
        
        //log.info(JSON.toJSONString(wareHouseBeanList));
        Integer total = userRoleDao.queryRoleTotal(warehouseSearch);
        //log.info(JSON.toJSONString(total));
        
        PadingRstType<RoleBean> roleBean = new PadingRstType<RoleBean>();
        roleBean.setPage(pagingBean.getPage());
        roleBean.setTotal(total);
        roleBean.putItems(RoleBean.class, roleBeanList);
        
        return roleBean;
    }
    
    @Override
    public List<RoleBean> getRoleDataShowList(WarehouseSearch warehouseSearch)
    {
        
        List<RoleBean> roleBeanList = userRoleDao.getRoleDataShowList(warehouseSearch);
        
        return roleBeanList;
    }
    
    @Override
    public void modifyRole(RoleBean roleBean)
    {
        Calendar calendar = Calendar.getInstance();
        roleBean.setModifyTime(calendar.getTime().toString());
        userRoleDao.modifyRole(roleBean);
    }
    
    @Override
    public void addRole(RoleBean roleBean)
    {
        // TODO Auto-generated method stub
        Calendar calendar = Calendar.getInstance();
        roleBean.setCreatTime(calendar.getTime().toString());
        roleBean.setModifyTime(calendar.getTime().toString());
        userRoleDao.addRole(roleBean);
        
    }
    
    @Override
    public void deleteRole(String ids)
        throws Exception
    {
        String[] idsArray = ids.split(",");
        //�õ�roleID
        List<UserRoleBean> userRoleBeanList = userRoleDao.queryRoleID(idsArray);
        //��ѯ�û���ɫ���е�roleID
        List<UserRoleBean> userRoleList = userRoleDao.queryUserRole();
        
        List<UserRoleBean> rolePrivilege = userRoleDao.queryRolePrivilege();
        
        UserRoleBean userRoleBean = new UserRoleBean();
        for (int i = 0; i < userRoleBeanList.size(); i++)
        {
            userRoleBean.setRoleId(userRoleBeanList.get(i).getRoleId());
            if (!userRoleList.contains(userRoleBean))
            {
                userRoleDao.deleteRole(Integer.toString(userRoleBeanList.get(i).getRoleId()));
                userRoleDao.deleteUserRole(Integer.toString(userRoleBeanList.get(i).getRoleId()));
                if (rolePrivilege.contains(userRoleBean))
                {
                    userRoleDao.deletePrivilege(Integer.toString(userRoleBeanList.get(i).getRoleId()));
                }
                else
                {
                    continue;
                }
                
            }
            else
            {
                throw new DeleteException();
            }
        }
        
    }
    
    @Override
    public List<ZTreeInfoBean> getZTreeData(List<MenuBean> menuList, String roleId)
    {
        
        List<ZTreeInfoBean> ztreeInfoList = new ArrayList<ZTreeInfoBean>();
        
        List<MenuBean> userRefRoleList = userRoleDao.queryMenuListByRoleId(roleId);
        
        MenuBean menuBean = new MenuBean();
        for (int i = 0; i < menuList.size(); i++)
        {
            ZTreeInfoBean ztreeInfoBean = new ZTreeInfoBean();
            ztreeInfoBean.setId(menuList.get(i).getMenuID());
            ztreeInfoBean.setName(menuList.get(i).getMenuName());
            ztreeInfoBean.setChkDisabled(false);
            
            menuBean.setMenuID(ztreeInfoBean.getId());
            if (userRefRoleList.contains(menuBean))
            {
                ztreeInfoBean.setChecked(true);
            }
            else
            {
                ztreeInfoBean.setChecked(false);
            }
            ztreeInfoBean.setpId(menuList.get(i).getParentID());
            ztreeInfoBean.setIsCheck(0);
            ztreeInfoList.add(ztreeInfoBean);
        }
        return ztreeInfoList;
        
    }
    
    @Override
    public void insertMenuRefRole(String roleIds, String roleId)
    {
        String[] roleIdArray = roleIds.split(",");//�����
        ArrayList<String> roleIdList = new ArrayList<String>();//�����list
        if (!"".equals(roleIds))
        {
            Collections.addAll(roleIdList, roleIdArray);
        }
        
        //roleIdList.remove(0);
        MenuBean menuBean = new MenuBean();
        List<MenuBean> existdataList = userRoleDao.queryMenuListByRoleId(roleId);//�����List
        //����ѡ���
        for (int i = 0; i < roleIdList.size(); i++)
        {
            menuBean.setMenuID(Integer.parseInt(roleIdList.get(i)));
            if (!existdataList.contains(menuBean))
            {
                userRoleDao.insertMenuRefRole(Integer.toString(menuBean.getMenuID()), roleId);
                
            }
            else
            {
                continue;
            }
        }
        //ɾ��δѡ��
        for (int i = 0; i < existdataList.size(); i++)
        {
            if (!roleIdList.contains(existdataList.get(i).getMenuID() + ""))
            {
                userRoleDao.deleteRoleById(existdataList.get(i).getMenuID() + "", roleId);
            }
        }
        
    }
    
    @Override
    public void deleteRoleById(String roleId, String menuID)
    {
        userRoleDao.deleteRoleById(roleId, menuID);
    }
    
    @Override
    public List<BaseSelectBean> getAll()
    {
        return userRoleDao.getAll();
    }
    
}
