package com.isoftstone.oj.service;

import com.isoftstone.oj.entity.SubjectBean;
import com.isoftstone.oj.entity.SubjectSearch;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;

public interface SubjectService
{
    PadingRstType<SubjectBean> querySubjectList(SubjectSearch subjectSearch, PagingBean pagingBean);
    
    void deleteSubject(String subjectIds);
    
    void updateSubject(SubjectBean subjectBean);
    
    void addSubject(SubjectBean subjectBean);
}
