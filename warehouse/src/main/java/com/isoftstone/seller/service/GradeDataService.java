package com.isoftstone.seller.service;

import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.seller.entity.GradeDataBean;
import com.isoftstone.seller.entity.GradeDataSearch;

public interface GradeDataService
{
    PadingRstType<GradeDataBean> queryGradeDataByPageList(GradeDataSearch gradeDataSearch, PagingBean pagingBean);
    
    void deleteGradeData(String ids);
    
    void updateGradeData(GradeDataBean gradeDataBean);
    
    void addGradeData(GradeDataBean gradeDataBean);
}
