package com.isoftstone.seller.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.seller.entity.SellerInfoBean;
import com.isoftstone.seller.entity.SellerInfoSearch;

@Repository("sellerInfoDao")
public interface SellerInfoDao
{
    List<SellerInfoBean> querySellerInfoByPageList(@Param("search")
    SellerInfoSearch sellerInfoSearch, @Param("paging")
    PagingBean PagingBean);
    
    Integer querySellerInfoTotal(@Param("search")
    SellerInfoSearch sellerInfoSearch);
    
    void deleteSellerInfo(@Param("ids")
    String[] idsArray);
    
    void updateSellerInfoDail(@Param("sellerInfo")
    SellerInfoBean sellerInfoBean);
    
    void addSellerInfoDail(@Param("sellerInfo")
    SellerInfoBean sellerInfoBean);
}
