package com.isoftstone.seller.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.seller.entity.GradeItemBean;
import com.isoftstone.seller.entity.GradeItemSearch;

@Repository("gradeItemDao")
public interface GradeItemDao
{
    List<GradeItemBean> queryGradeItemByPageList(@Param("search")
    GradeItemSearch gradeItemSearch, @Param("paging")
    PagingBean PagingBean);
    
    Integer queryGradeItemTotal(@Param("search")
    GradeItemSearch gradeItemSearch);
    
    void deleteGradeItemInfo(@Param("ids")
    String[] idsArray);
    
    void updateGradeItemDail(@Param("gradeItem")
    GradeItemBean gradeItemBean);
    
    void addGradeItemDail(@Param("gradeItem")
    GradeItemBean gradeItemBean);
    
}
