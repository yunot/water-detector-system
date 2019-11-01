package com.isoftstone.seller.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.seller.entity.GradeDataBean;
import com.isoftstone.seller.entity.GradeDataSearch;
import com.isoftstone.seller.repository.GradeDataDao;
import com.isoftstone.seller.service.GradeDataService;

@Service("gradeDataService")
public class GradeDataServiceImpl implements GradeDataService
{
    private final static Logger log = Logger.getLogger(GradeDataServiceImpl.class);
    
    @Resource
    private GradeDataDao gradeDataDao;
    
    @Override
    public PadingRstType<GradeDataBean> queryGradeDataByPageList(GradeDataSearch gradeDataSearch, PagingBean pagingBean)
    {
        
        pagingBean.deal(GradeDataBean.class);
        List<GradeDataBean> gradeDataBeanList = gradeDataDao.queryGradeDataByPageList(gradeDataSearch, pagingBean);
        //        log.info(JSON.toJSONString(GradeDataBeanList));
        Integer total = gradeDataDao.queryGradeDataTotal(gradeDataSearch);
        //        log.info(JSON.toJSONString(total));
        
        PadingRstType<GradeDataBean> gradeDataBean = new PadingRstType<GradeDataBean>();
        gradeDataBean.setPage(pagingBean.getPage());
        gradeDataBean.setTotal(total);
        gradeDataBean.putItems(GradeDataBean.class, gradeDataBeanList);
        
        return gradeDataBean;
    }
    
    @Override
    public void deleteGradeData(String ids)
    {
        // TODO Auto-generated method stub
        String[] idsArray = ids.split(",");
        gradeDataDao.deleteGradeData(idsArray);
    }
    
    @Override
    public void updateGradeData(GradeDataBean gradeDataBean)
    {
        // TODO Auto-generated method stub
        gradeDataDao.updateGradeData(gradeDataBean);
    }
    
    @Override
    public void addGradeData(GradeDataBean gradeDataBean)
    {
        // TODO Auto-generated method stub
        gradeDataDao.addGradeData(gradeDataBean);
    }
    
}
