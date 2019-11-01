package com.isoftstone.oj.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.isoftstone.oj.entity.SubjectBean;
import com.isoftstone.oj.entity.SubjectSearch;
import com.isoftstone.platform.entity.PagingBean;

@Repository("subjectDao")
public interface SubjectDao
{
    List<SubjectBean> querySubjectList(@Param("search")
    SubjectSearch subjectSearch, @Param("paging")
    PagingBean pagingBean);
    
    Integer querySubjectTotal(@Param("search")
    SubjectSearch subjectSearch);
    
    void deleteSubject(@Param("ids")
    String[] idsArray);
    
    void updateSubject(@Param("subject")
    SubjectBean subjectBean);
    
    void addSubject(@Param("subject")
    SubjectBean subjectBean);
}
