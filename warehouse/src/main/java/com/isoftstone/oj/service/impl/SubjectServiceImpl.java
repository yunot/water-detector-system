package com.isoftstone.oj.service.impl;

import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.isoftstone.oj.entity.SubjectBean;
import com.isoftstone.oj.entity.SubjectSearch;
import com.isoftstone.oj.repository.SubjectDao;
import com.isoftstone.oj.service.SubjectService;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;

@Service("subjectService")
public class SubjectServiceImpl implements SubjectService
{
    private final static Logger log = Logger.getLogger(SubjectServiceImpl.class);
    
    @Resource
    private SubjectDao subjectDao;
    
    @Override
    public PadingRstType<SubjectBean> querySubjectList(SubjectSearch subjectSearch, PagingBean pagingBean)
    {
        pagingBean.deal(SubjectBean.class);
        List<SubjectBean> subjectBeanList = subjectDao.querySubjectList(subjectSearch, pagingBean);
        Integer total = subjectDao.querySubjectTotal(subjectSearch);
        PadingRstType<SubjectBean> subjectBean = new PadingRstType<SubjectBean>();
        subjectBean.setPage(pagingBean.getPage());
        subjectBean.setTotal(total);
        subjectBean.putItems(SubjectBean.class, subjectBeanList);
        
        return subjectBean;
    }
    
    @Override
    public void deleteSubject(String subjectIds)
    {
        String[] idsArray = subjectIds.split(",");
        subjectDao.deleteSubject(idsArray);
    }
    
    @Override
    public void updateSubject(SubjectBean subjectBean)
    {
        log.info(subjectBean);
        Calendar calendar = Calendar.getInstance();
        subjectBean.setModifyTime(calendar.getTime().toString());
        System.out.println(subjectBean.getCreateTime() + ":" + subjectBean.getModifyTime());
        subjectDao.updateSubject(subjectBean);
    }
    
    @Override
    public void addSubject(SubjectBean subjectBean)
    {
        Calendar calendar = Calendar.getInstance();
        subjectBean.setCreateTime(calendar.getTime().toString());
        subjectBean.setModifyTime(calendar.getTime().toString());
        subjectDao.addSubject(subjectBean);
    }
    
}
