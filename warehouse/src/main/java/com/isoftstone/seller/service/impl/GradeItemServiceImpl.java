package com.isoftstone.seller.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.seller.entity.GradeItemBean;
import com.isoftstone.seller.entity.GradeItemSearch;
import com.isoftstone.seller.repository.GradeItemDao;
import com.isoftstone.seller.service.GradeItemService;

@Service("gradeItemService")
public class GradeItemServiceImpl implements GradeItemService
{
    private final static Logger log = Logger.getLogger(GradeItemServiceImpl.class);
    
    @Resource
    private GradeItemDao gradeItemDao;
    
    @Override
    public PadingRstType<GradeItemBean> queryGradeItemByPageList(GradeItemSearch gradeItemSearch, PagingBean pagingBean)
    {
        
        pagingBean.deal(GradeItemBean.class);
        List<GradeItemBean> gradeItemBeanList = gradeItemDao.queryGradeItemByPageList(gradeItemSearch, pagingBean);
        //        log.info(JSON.toJSONString(gradeItemBeanList));
        Integer total = gradeItemDao.queryGradeItemTotal(gradeItemSearch);
        //        log.info(JSON.toJSONString(total));
        
        PadingRstType<GradeItemBean> gradeItemBean = new PadingRstType<GradeItemBean>();
        gradeItemBean.setPage(pagingBean.getPage());
        gradeItemBean.setTotal(total);
        gradeItemBean.putItems(GradeItemBean.class, gradeItemBeanList);
        
        return gradeItemBean;
    }
    
    @Override
    public void deleteGradeItemInfo(String ids)
    {
        String[] idsArray = ids.split(",");
        gradeItemDao.deleteGradeItemInfo(idsArray);
        // TODO Auto-generated method stub
        
    }
    
    @Override
    public void updateGradeItemDail(GradeItemBean gradeItemBean)
    {
        gradeItemDao.updateGradeItemDail(gradeItemBean);
        
    }
    
    @Override
    public void addGradeItemDail(GradeItemBean gradeItemBean)
    {
        gradeItemDao.addGradeItemDail(gradeItemBean);
        
    }
    
}
