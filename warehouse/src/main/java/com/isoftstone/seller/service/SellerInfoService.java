package com.isoftstone.seller.service;

import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.seller.entity.SellerInfoBean;
import com.isoftstone.seller.entity.SellerInfoSearch;

public interface SellerInfoService
{
    PadingRstType<SellerInfoBean> querySellerInfoList(SellerInfoSearch sellerInfoSearch, PagingBean pagingBean);
    
    void deleteSellerInfo(String ids);
    
    void updateSellerInfoDail(SellerInfoBean sellerInfoBean);
    
    void addSellerInfoDail(SellerInfoBean sellerInfoBean);
}
