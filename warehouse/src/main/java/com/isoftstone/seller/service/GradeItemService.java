package com.isoftstone.seller.service;

import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.seller.entity.GradeItemBean;
import com.isoftstone.seller.entity.GradeItemSearch;

public interface GradeItemService
{
    PadingRstType<GradeItemBean> queryGradeItemByPageList(GradeItemSearch gradeItemSearch, PagingBean pagingBean);
    
    void deleteGradeItemInfo(String ids);
    
    void updateGradeItemDail(GradeItemBean gradeItemBean);
    
    void addGradeItemDail(GradeItemBean gradeItemBean);
}
