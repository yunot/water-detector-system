package com.isoftstone.platform.sm.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.platform.sm.entity.PostBean;
import com.isoftstone.platform.sm.entity.PostSearch;
import com.isoftstone.platform.sm.entity.UserInfoBean;

@Repository("postDao")
public interface PostDao
{
    
    List<PostBean> getPostDataList(@Param("post")
    PostSearch postSearch, @Param("paging")
    PagingBean pagingBean);
    
    Integer queryPostTotal(@Param("post")
    PostSearch postSearch);
    
    PostBean queryDetail(@Param("postID")
    String postID);
    
    List<UserInfoBean> queryUserByPageList(@Param("postID")
    String postID, @Param("paging")
    PagingBean PagingBean);
    
    Integer queryUserTotal(@Param("postID")
    String postID);
    
    void addPostDail(@Param("addPostDail")
    PostBean postBean);
    
    void delPostUser(@Param("postID")
    String postID, @Param("userIDs")
    String[] userArray);
    
    void delPostDail(@Param("ids")
    String[] idsArray);
    
    List<String> getPostRefUserDataList(@Param("postID")
    String postId);
    
}
