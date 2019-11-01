package com.isoftstone.buyer.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.isoftstone.buyer.entity.BuyerBean;
import com.isoftstone.buyer.entity.BuyerSearch;
import com.isoftstone.buyer.repository.BuyerDao;
import com.isoftstone.buyer.service.BuyerService;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;

@Service("buyerService")
public class BuyerServiceImpl implements BuyerService
{
    private final static Logger log = Logger.getLogger(BuyerServiceImpl.class);
    
    @Resource
    private BuyerDao buyerDao;
    
    @Override
    public PadingRstType<BuyerBean> queryBuyerByPageList(BuyerSearch buyerSearch, PagingBean pagingBean)
    {
        
        pagingBean.deal(BuyerBean.class);
        List<BuyerBean> buyerBeanList = buyerDao.queryBuyerByPageList(buyerSearch, pagingBean);
        //        log.info(JSON.toJSONString(buyerBeanList));
        Integer total = buyerDao.queryBuyerTotal(buyerSearch);
        //        log.info(JSON.toJSONString(total));
        
        PadingRstType<BuyerBean> buyerBean = new PadingRstType<BuyerBean>();
        buyerBean.setPage(pagingBean.getPage());
        buyerBean.setTotal(total);
        buyerBean.putItems(BuyerBean.class, buyerBeanList);
        
        return buyerBean;
    }
    
    @Override
    public void deleteBuyerInfo(String ids)
    {
        String[] idsArray = ids.split(",");
        buyerDao.deleteBuyerInfo(idsArray);
        // TODO Auto-generated method stub
        
    }
    
    @Override
    public void updateBuyerDail(BuyerBean buyerBean)
    {
        buyerDao.updateBuyerDail(buyerBean);
        
    }
    
    @Override
    public void addBuyerDail(BuyerBean buyerBean)
    {
        buyerDao.addBuyerDail(buyerBean);
    }
    
}
