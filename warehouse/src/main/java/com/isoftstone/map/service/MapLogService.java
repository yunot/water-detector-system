package com.isoftstone.map.service;

import com.isoftstone.map.entity.MapLogBean;
import com.isoftstone.map.entity.MapLogSearch;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;

public interface MapLogService {
    PadingRstType<MapLogBean> queryMapLogList(MapLogSearch mapLogSearch, PagingBean pagingBean);


    void deleteMapLog(String ids);
    
    void updateMapLogDail(MapLogBean mapLogBean);
    
    void addMapLogDail(MapLogBean mapLogBean);
}
