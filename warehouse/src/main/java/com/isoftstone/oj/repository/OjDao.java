package com.isoftstone.oj.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.isoftstone.oj.entity.SubjectBean;
import com.isoftstone.oj.entity.SubjectSearch;
import com.isoftstone.platform.entity.PagingBean;

@Repository("ojDao")
public interface OjDao
{
    
    List<SubjectBean> querySubjectByPageList(@Param("search")
    SubjectSearch subjectSearch, @Param("paging")
    PagingBean pagingBean);
    
    Integer querySubjectTotal(@Param("search")
    SubjectSearch subjectSearch);
    
    SubjectBean querySubjectById(@Param("search")
    SubjectSearch subjectSearch, @Param("id")
    int id);
}
