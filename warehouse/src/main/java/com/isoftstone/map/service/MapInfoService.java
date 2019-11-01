package com.isoftstone.map.service;

import com.isoftstone.map.entity.MapInfoBean;
import com.isoftstone.map.entity.MapInfoSearch;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;

public interface MapInfoService {
    PadingRstType<MapInfoBean> queryMapInfoList(MapInfoSearch mapInfoSearch, PagingBean pagingBean);
    
    void deleteMapInfo(String ids);
    
    void updateMapInfoDail(MapInfoBean mapInfoBean);
    
    void addMapInfoDail(MapInfoBean mapInfoBean);
}
