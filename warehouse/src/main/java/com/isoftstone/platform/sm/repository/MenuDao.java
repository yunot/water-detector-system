package com.isoftstone.platform.sm.repository;

import com.isoftstone.platform.sm.entity.MenuBean;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MenuDao
{
    /**
     * �����û�ID��ѯȨ��
     *
     * @param userId �û�ID
     * @return Ȩ���б�
     * @autor zsj
     */
    public List<String> selectPermsByUserId(Long userId);

    List<MenuBean> queryMenuInfo(@Param("userID") String userID);
    
    Integer queryBtnCount(String parentID);
    
    String queryValueByLang(@Param("menuId") String menuID, @Param("lang") String lang);
    
}
