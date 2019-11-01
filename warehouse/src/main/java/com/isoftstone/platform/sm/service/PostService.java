package com.isoftstone.platform.sm.service;

import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.platform.sm.entity.PostBean;
import com.isoftstone.platform.sm.entity.PostSearch;
import com.isoftstone.platform.sm.entity.UserInfoBean;

public interface PostService
{
    PadingRstType<PostBean> getPostDataList(PostSearch postSearch, PagingBean pagingBean);
    
    PostBean queryDetail(String postID);
    
    PadingRstType<UserInfoBean> queryUserByPageList(String postID, PagingBean pagingBean);
    
    void addPostDail(PostBean postBean);
    
    void delPostUser(String postID, String userIDs);
    
    void delPostDail(String ids);
}
