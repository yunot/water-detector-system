package com.isoftstone.oj.service;

import com.isoftstone.oj.entity.UserSubjectBean;
import com.isoftstone.oj.entity.UserSubjectSearch;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;

public interface UserSubjectService
{
    PadingRstType<UserSubjectBean> querySubjectList(UserSubjectSearch userSubjectSearch, PagingBean pagingBean);
    
    void deleteUserSubject(String userSubjectIds);
    
    void addUserSubject(UserSubjectBean userSubjectBean);
}
