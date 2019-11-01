package com.isoftstone.seller.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.seller.entity.SellerInfoBean;
import com.isoftstone.seller.entity.SellerInfoSearch;
import com.isoftstone.seller.repository.SellerInfoDao;
import com.isoftstone.seller.service.SellerInfoService;

@Service("SellerInfoService")
public class SellerInfoServiceImpl implements SellerInfoService
{
    private static final Logger log = Logger.getLogger(SellerInfoServiceImpl.class);
    
    @Resource
    private SellerInfoDao sellerInfoDao;
    
    @Override
    public PadingRstType<SellerInfoBean> querySellerInfoList(SellerInfoSearch sellerInfoSearch, PagingBean pagingBean)
    {
        pagingBean.deal(SellerInfoBean.class);
        List<SellerInfoBean> sellerInfoBeanList = sellerInfoDao.querySellerInfoByPageList(sellerInfoSearch, pagingBean);
        //        log.info(JSON.toJSONString(warehouseBeanList));
        Integer total = sellerInfoDao.querySellerInfoTotal(sellerInfoSearch);
        
        PadingRstType<SellerInfoBean> sellerInfoBean = new PadingRstType<SellerInfoBean>();
        sellerInfoBean.setPage(pagingBean.getPage());
        sellerInfoBean.setTotal(total);
        sellerInfoBean.putItems(SellerInfoBean.class, sellerInfoBeanList);
        
        return sellerInfoBean;
    }
    
    @Override
    public void deleteSellerInfo(String ids)
    {
        String[] idsArray = ids.split(",");
        sellerInfoDao.deleteSellerInfo(idsArray);
        
    }
    
    @Override
    public void updateSellerInfoDail(SellerInfoBean sellerInfoBean)
    {
        // TODO Auto-generated method stub
        sellerInfoDao.updateSellerInfoDail(sellerInfoBean);
    }
    
    @Override
    public void addSellerInfoDail(SellerInfoBean sellerInfoBean)
    {
        // TODO Auto-generated method stub
        sellerInfoDao.addSellerInfoDail(sellerInfoBean);
    }
    
}
