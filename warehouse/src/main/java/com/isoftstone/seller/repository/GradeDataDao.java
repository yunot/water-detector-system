package com.isoftstone.seller.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.seller.entity.GradeDataBean;
import com.isoftstone.seller.entity.GradeDataSearch;

@Repository("gradeDataDao")
public interface GradeDataDao
{
    List<GradeDataBean> queryGradeDataByPageList(@Param("search")
    GradeDataSearch pradeDataSearch, @Param("paging")
    //分页用
        PagingBean pagingBean);
    
    Integer queryGradeDataTotal(@Param("search")
    GradeDataSearch gradeDataSearch);
    
    void deleteGradeData(@Param("ids")
    String[] idsArray);
    
    void updateGradeData(@Param("gradeData")
    GradeDataBean gradeDataBean);
    
    void addGradeData(@Param("gradeData")
    GradeDataBean gradeDataBean);
}
