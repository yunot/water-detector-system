package com.isoftstone.platform.sm.service.impl;

import com.alibaba.fastjson.JSON;
import com.isoftstone.platform.sm.entity.MenuBean;
import com.isoftstone.platform.sm.repository.MenuDao;
import com.isoftstone.platform.sm.service.MenuService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service("menuService")
public class MenuServiceImpl implements MenuService
{
    @Resource
    private MenuDao menuDao;

    /**
     * �����û�ID��ѯȨ��
     *
     * @param userId �û�ID
     * @return Ȩ���б�
     */
    @Override
    public Set<String> selectPermsByUserId(Long userId) {
        List<String> perms = menuDao.selectPermsByUserId(userId);
        System.out.println("�û�Ȩ��"+ JSON.toJSONString(perms));
        Set<String> permsSet = new HashSet<>();
        for (String perm : perms) {
            if (perm != null && !"".equals(perm)) {
                permsSet.addAll(Arrays.asList(perm.trim().split(",")));
            }
        }
        return permsSet;
    }

    @Override
    public List<MenuBean> queryMenuInfo(String userID, String language)
    {
        List<MenuBean> list = menuDao.queryMenuInfo(userID);
        for (MenuBean menuBean : list)
        {
            menuBean.setMenuName(menuDao.queryValueByLang(menuBean.getMenuID() + "", language));
        }
        return list;
    }
    
}
