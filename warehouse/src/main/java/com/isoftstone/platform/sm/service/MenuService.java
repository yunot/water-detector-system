package com.isoftstone.platform.sm.service;

import com.isoftstone.platform.sm.entity.MenuBean;

import java.util.List;
import java.util.Set;

public interface MenuService
{
    /**
     * �����û�ID��ѯȨ��
     *
     * @param userId �û�ID
     * @return Ȩ���б�
     * @author zsj
     */
    public Set<String> selectPermsByUserId(Long userId);

    List<MenuBean> queryMenuInfo(String userID, String language);
    
}
