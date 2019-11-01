package com.isoftstone.oj.service;

import java.net.Socket;

import com.isoftstone.oj.entity.SubjectBean;
import com.isoftstone.oj.entity.SubjectRst;
import com.isoftstone.oj.entity.SubjectSearch;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;

public interface OjService
{
    PadingRstType<SubjectBean> querySubjectByPageList(SubjectSearch subjectSearch, PagingBean pagingBean);
    
    SubjectBean querySubjectById(SubjectSearch subjectSearch, int id);
    
    public void sendSocket(Socket socket, SubjectBean subjectBean);
    
    public SubjectRst receiveSocket(SubjectBean subjectBean);
}
