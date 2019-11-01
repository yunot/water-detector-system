package com.isoftstone.platform.sm.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.isoftstone.platform.common.MessageHolder;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.platform.entity.ZTreeInfoBean;
import com.isoftstone.platform.sm.entity.PostBean;
import com.isoftstone.platform.sm.entity.RoleBean;
import com.isoftstone.platform.sm.entity.UserInfoBean;
import com.isoftstone.platform.sm.entity.UserSearch;
import com.isoftstone.platform.sm.repository.PostDao;
import com.isoftstone.platform.sm.repository.UserInfoDao;
import com.isoftstone.platform.sm.service.UserInfoService;

@Service("userInfoService")
public class UserInfoServiceImpl implements UserInfoService
{
    private static final String UserSearch = null;
    
    @Resource
    private UserInfoDao userInfoDao;
    
    @Resource
    private PostDao postDao;
    
    @Value("#{propertiesConfig['passwd.key']}")
    private String passwdKey;
    
    @Value(value = "#{propertiesConfig['default.language']}")
    private String defaultLanguage = "zh";
    
    @Resource
    private MessageHolder messageHolder;
    
    @Override
    public UserInfoBean autoUserInfo(String userName, String password)
    {
        List<UserInfoBean> userInfoList = userInfoDao.autoUserInfo(userName, password, passwdKey);
        if (userInfoList.size() > 0)
        {
            return userInfoList.get(0);
        }
        return null;
    }
    
    @Override
    public void register(String account, String name, String telephone, String email, String gender, String password)
    {
        userInfoDao.register(account, name, telephone, email, gender, password);
    }
    
    @Override
    public void updatePasswordByEmail(String resetEmail, String password)
    {
        userInfoDao.updatePasswordByEmail(resetEmail, password);
    }
    
    @Override
    public PadingRstType<UserInfoBean> queryUserByPageList(UserSearch userSearch, PagingBean pagingBean)
    {
        pagingBean.deal(UserInfoBean.class);
        List<UserInfoBean> userBeanList = userInfoDao.queryUserByPageList(userSearch, pagingBean);
        //userBeanList.remove(0);
        Integer total = userInfoDao.queryUserTotal(userSearch);
        
        PadingRstType<UserInfoBean> userBean = new PadingRstType<UserInfoBean>();
        userBean.setPage(pagingBean.getPage());
        userBean.setTotal(total);
        userBean.putItems(UserInfoBean.class, userBeanList);
        
        return userBean;
    }
    
    @Override
    public void deleteUserInfo(String ids)
    {
        String[] idsArray = ids.split(",");
        userInfoDao.deleteUserInfo(idsArray);
        // TODO Auto-generated method stub
        
    }
    
    @Override
    public void updateUserinfo(UserInfoBean userInfoBean)
    {
        userInfoDao.updateUserinfo(userInfoBean);
        
    }
    
    @Override
    public void addUserDail(UserInfoBean userInfoBean)
    {
        userInfoDao.addUserDail(userInfoBean);
    }
    
    @Override
    public List<ZTreeInfoBean> getZTreeData(String userId, String menuLanguage)
    {
        
        List<RoleBean> roleList = userInfoDao.getRoleList();
        
        List<ZTreeInfoBean> ztreeInfoList = new ArrayList<ZTreeInfoBean>();
        
        List<RoleBean> userRefRoleList = userInfoDao.queryRoleListByUserId(userId);
        
        ZTreeInfoBean ztreeInfoBean = new ZTreeInfoBean();
        
        ztreeInfoBean.setId(0);
        
        ztreeInfoBean.setName(messageHolder.getMessage("title.role"));
        ztreeInfoBean.setOpen(true);
        ztreeInfoBean.setpId(-1);
        
        ztreeInfoList.add(ztreeInfoBean);
        ZTreeInfoBean ztreeInfoBean1 = null;
        RoleBean roleBean = new RoleBean();
        for (int i = 0; i < roleList.size(); i++)
        {
            ztreeInfoBean1 = new ZTreeInfoBean();
            ztreeInfoBean1.setId(roleList.get(i).getRoleId());
            if ("zh".equals(menuLanguage))
            {
                ztreeInfoBean1.setName(roleList.get(i).getRoleName());
            }
            else
            {
                ztreeInfoBean1.setName(roleList.get(i).getEnglishName());
            }
            
            ztreeInfoBean1.setChkDisabled(false);
            
            roleBean.setRoleId(ztreeInfoBean1.getId());
            if (userRefRoleList.contains(roleBean))
            {
                ztreeInfoBean1.setChecked(true);
                ztreeInfoBean.setChecked(true);
            }
            else
            {
                ztreeInfoBean1.setChecked(false);
            }
            
            ztreeInfoBean1.setpId(0);
            ztreeInfoBean1.setIsCheck(0);
            ztreeInfoList.add(ztreeInfoBean1);
        }
        return ztreeInfoList;
        
    }
    
    @Override
    public List<ZTreeInfoBean> getPostZTreeData(String userIds)
    {
        List<PostBean> postList = postDao.getPostDataList(null, null);
        List<ZTreeInfoBean> ztreeInfoList = new ArrayList<ZTreeInfoBean>();
        ZTreeInfoBean ztreeInfoBean = new ZTreeInfoBean();
        
        ztreeInfoBean.setId(0);
        ztreeInfoBean.setName(messageHolder.getMessage("post"));
        ztreeInfoBean.setOpen(true);
        ztreeInfoBean.setChkDisabled(true);
        ztreeInfoBean.setpId(-1);
        
        ztreeInfoList.add(ztreeInfoBean);
        for (int i = 0; i < postList.size(); i++)
        {
            ztreeInfoBean = new ZTreeInfoBean();
            ztreeInfoBean.setId(postList.get(i).getPostID());
            ztreeInfoBean.setName(postList.get(i).getPostName());
            ztreeInfoBean.setChkDisabled(false); //可选
            ztreeInfoBean.setChecked(false); //不选中
            ztreeInfoBean.setpId(0); //父id
            ztreeInfoBean.setIsCheck(0);
            ztreeInfoList.add(ztreeInfoBean);
        }
        return ztreeInfoList;
    }
    
    @Override
    public void insertUserRefRole(String roleIds, String userId)
    {
        String[] roleIdArray = roleIds.split(",");//�����
        ArrayList<String> roleIdList = new ArrayList<String>();//�����list
        if (!"".equals(roleIds))
        {
            Collections.addAll(roleIdList, roleIdArray);
        }
        if (roleIdList.size() > 0)
        {
            roleIdList.remove(0);
        }
        RoleBean roleBean = new RoleBean();
        List<RoleBean> existdataList = userInfoDao.queryRoleListByUserId(userId);//�����List
        //����ѡ���
        for (int i = 0; i < roleIdList.size(); i++)
        {
            roleBean.setRoleId(Integer.parseInt(roleIdList.get(i)));
            if (!existdataList.contains(roleBean))
            {
                userInfoDao.insertUserRefRole(roleIdList.get(i), userId);
                
            }
            else
            {
                continue;
            }
        }
        //ɾ��δѡ��
        for (int i = 0; i < existdataList.size(); i++)
        {
            if (!roleIdList.contains(existdataList.get(i).getRoleId() + ""))
            {
                userInfoDao.deleteRoleById(existdataList.get(i).getRoleId() + "", userId);
            }
            
        }
        
    }
    
    @Override
    public void deleteRoleById(String roleId, String userId)
    {
        userInfoDao.deleteRoleById(roleId, userId);
    }
    
    @Override
    public void updateByAccount(UserInfoBean userinfo)
    {
        userInfoDao.updateByAccount(userinfo);
        
    }
    
    @Override
    public void insertUserRefPost(String postId, String userIds)
    {
        String[] userIdArray = userIds.split(",");
        List<String> list = postDao.getPostRefUserDataList(postId);
        for (int i = 0; i < userIdArray.length; i++)
        {
            for (int j = 0; j < list.size(); j++)
            {
                if (userIdArray[i].equals(list.get(j)))
                    break;
                else if (j == list.size() - 1)
                    userInfoDao.insertUserRefPost(postId, userIdArray[i]);
            }
        }
    }
}