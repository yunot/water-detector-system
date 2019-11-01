package com.isoftstone.platform.sm.service;

import java.util.List;

import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.platform.entity.ZTreeInfoBean;
import com.isoftstone.platform.sm.entity.UserInfoBean;
import com.isoftstone.platform.sm.entity.UserSearch;

public interface UserInfoService
{
    PadingRstType<UserInfoBean> queryUserByPageList(UserSearch userSearch, PagingBean pagingBean);
    
    UserInfoBean autoUserInfo(String userName, String password);
    
    void register(String account, String name, String telephone, String email, String gender, String password);
    
    void updatePasswordByEmail(String resetEmail, String password);
    
    void deleteUserInfo(String ids);
    
    void updateUserinfo(UserInfoBean userInfoBean);
    
    void addUserDail(UserInfoBean userInfoBean);
    
    List<ZTreeInfoBean> getZTreeData(String userId, String menuLanguage);
    
    List<ZTreeInfoBean> getPostZTreeData(String userIds);
    
    void insertUserRefRole(String roleIds, String userId);
    
    void insertUserRefPost(String postId, String userIds);
    
    void deleteRoleById(String roleIds, String userId);
    
    void updateByAccount(UserInfoBean userinfo);
    
}
