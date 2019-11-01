package com.isoftstone.map.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.isoftstone.map.entity.MapLogBean;
import com.isoftstone.map.entity.MapLogSearch;
import com.isoftstone.platform.entity.PagingBean;

@Repository("mapLogDao")
public interface MapLogDao{
    List<MapLogBean> queryMapLogByPageList(@Param("search")
    MapLogSearch mapLogSearch, @Param("paging")
    PagingBean PagingBean);
    
    Integer queryMapLogTotal(@Param("search")
    MapLogSearch mapLogSearch);
    
    void deleteMapLog(@Param("ids")
    String[] idsArray);
    
    void updateMapLogDail(@Param("mapLog")
    MapLogBean mapLogBean);
    
    void addMapLogDail(@Param("mapLog")
    MapLogBean mapLogBean);
}
