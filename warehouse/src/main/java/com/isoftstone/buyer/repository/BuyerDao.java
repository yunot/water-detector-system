package com.isoftstone.buyer.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.isoftstone.buyer.entity.BuyerBean;
import com.isoftstone.buyer.entity.BuyerSearch;
import com.isoftstone.platform.entity.PagingBean;

@Repository("buyerDao")
public interface BuyerDao
{
    List<BuyerBean> queryBuyerByPageList(@Param("search")
    BuyerSearch buyerSearch, @Param("paging")
    PagingBean PagingBean);
    
    Integer queryBuyerTotal(@Param("search")
    BuyerSearch buyerSearch);
    
    void deleteBuyerInfo(@Param("ids")
    String[] idsArray);
    
    void updateBuyerDail(@Param("buyer")
    BuyerBean buyerBean);
    
    void addBuyerDail(@Param("buyer")
    BuyerBean buyerBean);
}
