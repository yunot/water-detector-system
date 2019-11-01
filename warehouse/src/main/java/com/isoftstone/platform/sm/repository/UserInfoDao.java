package com.isoftstone.platform.sm.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.platform.sm.entity.RoleBean;
import com.isoftstone.platform.sm.entity.UserInfoBean;
import com.isoftstone.platform.sm.entity.UserSearch;

@Repository("userInfoDao")
public interface UserInfoDao
{
    
    List<UserInfoBean> autoUserInfo(@Param("userName")
    String userName, @Param("password")
    String password, @Param("passwdKey")
    String passwdKey);
    
    void register(@Param("account")
    String account, @Param("name")
    String name, @Param("telephone")
    String telephone, @Param("email")
    String email, @Param("gender")
    String gender, @Param("password")
    String password);
    
    void updatePasswordByEmail(@Param("resetemail")
    String resetemail, @Param("resetPassword")
    String resetPassword);
    
    Integer selectByEmail(@Param("email")
    String email);
    
    List<UserInfoBean> queryUserByPageList(@Param("search")
    UserSearch userSearch, @Param("paging")
    PagingBean PagingBean);
    
    Integer queryUserTotal(@Param("search")
    UserSearch userSearch);
    
    void deleteUserInfo(@Param("ids")
    String[] idsArray);
    
    void updateUserinfo(@Param("user")
    UserInfoBean userInfoBean);
    
    void addUserDail(@Param("user")
    UserInfoBean userInfoBean);
    
    List<RoleBean> getRoleList();
    
    //���û���ɫ���в���һ����¼
    void insertUserRefRole(@Param("roleIds")
    String roleIds, @Param("userId")
    String userId);
    
    //ɾ���û���ɫ����һ����¼
    void deleteRoleById(@Param("roleId")
    String roleId, @Param("userId")
    String userId);
    
    //�����û���ɫ������������������жϲ��뻹��ɾ��
    List<String> searchUserRoleNum();
    
    List<RoleBean> queryRoleListByUserId(@Param("userId")
    String userId);
    
    void updateByAccount(@Param("userinfo")
    UserInfoBean userinfo);
    
    void insertUserRefPost(@Param("postId")
    String postId, @Param("userId")
    String userIds);
    
}
