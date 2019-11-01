package com.isoftstone.platform.sm.service.impl;

import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.platform.sm.entity.PostBean;
import com.isoftstone.platform.sm.entity.PostSearch;
import com.isoftstone.platform.sm.entity.UserInfoBean;
import com.isoftstone.platform.sm.repository.PostDao;
import com.isoftstone.platform.sm.service.PostService;

@Service("postService")
public class PostServiceImpl implements PostService
{
    @Resource
    private PostDao postDao;
    
    @Override
    public PadingRstType<PostBean> getPostDataList(PostSearch postSearch, PagingBean pagingBean)
    {
        pagingBean.deal(PostBean.class);
        List<PostBean> postBeanList = postDao.getPostDataList(postSearch, pagingBean);
        
        //log.info(JSON.toJSONString(wareHouseBeanList));
        Integer total = postDao.queryPostTotal(postSearch);
        //log.info(JSON.toJSONString(total));
        
        PadingRstType<PostBean> postBean = new PadingRstType<PostBean>();
        postBean.setPage(pagingBean.getPage());
        postBean.setTotal(total);
        postBean.putItems(PostBean.class, postBeanList);
        
        return postBean;
    }
    
    //    @Override
    //    public PostBean queryDetail(String postID)
    //    {
    //        return postDao.queryDetail(postID);
    //        
    //    }
    
    @Override
    public PostBean queryDetail(String postID)
    {
        return postDao.queryDetail(postID);
        
    }
    
    @Override
    public PadingRstType<UserInfoBean> queryUserByPageList(String postID, PagingBean pagingBean)
    {
        pagingBean.deal(UserInfoBean.class);
        List<UserInfoBean> userInfoBeanList = postDao.queryUserByPageList(postID, pagingBean);
        
        Integer total = postDao.queryUserTotal(postID);
        
        PadingRstType<UserInfoBean> userInfoBeans = new PadingRstType<UserInfoBean>();
        userInfoBeans.setPage(pagingBean.getPage());
        userInfoBeans.setTotal(total);
        userInfoBeans.putItems(UserInfoBean.class, userInfoBeanList);
        return userInfoBeans;
    }
    
    @Override
    public void addPostDail(PostBean postBean)
    {
        Calendar calendar = Calendar.getInstance();
        postBean.setCreatTime(calendar.getTime().toString());
        postBean.setModifyTime(calendar.getTime().toString());
        postDao.addPostDail(postBean);
        
    }
    
    @Override
    public void delPostUser(String postID, String userIDs)
    {
        String[] userArray = userIDs.split(",");
        postDao.delPostUser(postID, userArray);
    }
    
    @Override
    public void delPostDail(String ids)
    {
        String[] idsArray = ids.split(",");
        postDao.delPostDail(idsArray);
    }
}
