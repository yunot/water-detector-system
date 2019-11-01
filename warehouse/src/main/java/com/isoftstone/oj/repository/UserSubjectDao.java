package com.isoftstone.oj.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.isoftstone.oj.entity.UserSubjectBean;
import com.isoftstone.oj.entity.UserSubjectSearch;
import com.isoftstone.platform.entity.PagingBean;

@Repository("userSubjectDao")
public interface UserSubjectDao
{
    List<UserSubjectBean> queryUserSubjectList(@Param("search")
    UserSubjectSearch userSubjectSearch, @Param("paging")
    PagingBean pagingBean);
    
    Integer queryUserSubjectTotal(@Param("search")
    UserSubjectSearch userSubjectSearch);
    
    void deleteUserSubject(@Param("ids")
    String[] idsArray);
    
    void updateSubject(@Param("subject")
    UserSubjectBean userSubjectBean);
    
    void addUserSubject(@Param("subject")
    UserSubjectBean userSubjectBean);
}
