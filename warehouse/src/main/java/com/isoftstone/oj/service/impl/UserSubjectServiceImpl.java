package com.isoftstone.oj.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;

import com.isoftstone.oj.entity.UserSubjectBean;
import com.isoftstone.oj.entity.UserSubjectSearch;
import com.isoftstone.oj.repository.UserSubjectDao;
import com.isoftstone.oj.service.UserSubjectService;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.platform.sm.entity.UserInfoBean;

@Service("userSubjectService")
public class UserSubjectServiceImpl implements UserSubjectService
{
    private final static Logger log = Logger.getLogger(SubjectServiceImpl.class);
    
    @Resource
    private UserSubjectDao userSubjectDao;
    
    @Override
    public PadingRstType<UserSubjectBean> querySubjectList(UserSubjectSearch userSubjectSearch, PagingBean pagingBean)
    {
        pagingBean.deal(UserSubjectBean.class);
        List<UserSubjectBean> userSubjectBeanList = userSubjectDao.queryUserSubjectList(userSubjectSearch, pagingBean);
        Integer total = userSubjectDao.queryUserSubjectTotal(userSubjectSearch);
        PadingRstType<UserSubjectBean> userSubjectBean = new PadingRstType<UserSubjectBean>();
        userSubjectBean.setPage(pagingBean.getPage());
        userSubjectBean.setTotal(total);
        userSubjectBean.putItems(UserSubjectBean.class, userSubjectBeanList);
        
        return userSubjectBean;
    }
    
    @Override
    public void deleteUserSubject(String userSubjectIds)
    {
        String[] idsArray = userSubjectIds.split(",");
        userSubjectDao.deleteUserSubject(idsArray);
    }
    
    @Override
    public void addUserSubject(UserSubjectBean userSubjectBean)
    {
        // 获取当前的用户
        UserInfoBean currentUser = (UserInfoBean)SecurityUtils.getSubject().getPrincipal();
        userSubjectBean.setUserId(currentUser.getUserId());
        userSubjectDao.addUserSubject(userSubjectBean);
        
    }
    
}
