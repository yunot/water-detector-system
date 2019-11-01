package com.isoftstone.platform.sm.service;

import com.isoftstone.platform.sm.entity.MenuBean;

import java.util.List;
import java.util.Set;

public interface MenuService
{
    /**
     * 根据用户ID查询权限
     *
     * @param userId 用户ID
     * @return 权限列表
     * @author zsj
     */
    public Set<String> selectPermsByUserId(Long userId);

    List<MenuBean> queryMenuInfo(String userID, String language);
    
}
