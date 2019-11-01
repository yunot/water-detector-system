package com.isoftstone.map.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.isoftstone.map.entity.MapInfoBean;
import com.isoftstone.map.entity.MapInfoSearch;
import com.isoftstone.platform.entity.PagingBean;

@Repository("mapInfoDao")
public interface MapInfoDao{
    List<MapInfoBean> queryMapInfoByPageList(@Param("search")
    MapInfoSearch mapInfoSearch, @Param("paging")
    PagingBean PagingBean);
    
    Integer queryMapInfoTotal(@Param("search")
    MapInfoSearch mapInfoSearch);
    
    void deleteMapInfo(@Param("ids")
    String[] idsArray);
    
    void updateMapInfoDail(@Param("mapInfo")
    MapInfoBean mapInfoBean);
    
    void addMapInfoDail(@Param("mapInfo")
    MapInfoBean mapInfoBean);
}
