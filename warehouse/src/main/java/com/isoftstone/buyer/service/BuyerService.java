package com.isoftstone.buyer.service;

import com.isoftstone.buyer.entity.BuyerBean;
import com.isoftstone.buyer.entity.BuyerSearch;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;

public interface BuyerService
{
    PadingRstType<BuyerBean> queryBuyerByPageList(BuyerSearch buyerSearch, PagingBean pagingBean);
    
    void deleteBuyerInfo(String ids);
    
    void updateBuyerDail(BuyerBean buyerBean);
    
    void addBuyerDail(BuyerBean buyerBean);
}
