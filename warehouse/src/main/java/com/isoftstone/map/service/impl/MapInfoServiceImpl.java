package com.isoftstone.map.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.isoftstone.map.entity.MapInfoBean;
import com.isoftstone.map.entity.MapInfoSearch;
import com.isoftstone.map.repository.MapInfoDao;
import com.isoftstone.map.service.MapInfoService;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;

@Service("MapInfoService")
public class MapInfoServiceImpl implements MapInfoService{
	
	private static final Logger log = Logger.getLogger(MapInfoServiceImpl.class);
    
    @Resource
    private MapInfoDao mapInfoDao;

	@Override
	public PadingRstType<MapInfoBean> queryMapInfoList(MapInfoSearch mapInfoSearch, PagingBean pagingBean) {
		// TODO Auto-generated method stub
		pagingBean.deal(MapInfoBean.class);
        List<MapInfoBean> mapInfoBeanList = mapInfoDao.queryMapInfoByPageList(mapInfoSearch, pagingBean);
        //        log.info(JSON.toJSONString(warehouseBeanList));
        Integer total = mapInfoDao.queryMapInfoTotal(mapInfoSearch);
        
        PadingRstType<MapInfoBean> mapInfoBean = new PadingRstType<MapInfoBean>();
        mapInfoBean.setPage(pagingBean.getPage());
        mapInfoBean.setTotal(total);
        mapInfoBean.putItems(MapInfoBean.class, mapInfoBeanList);
        
        return mapInfoBean;
	}

	@Override
	public void deleteMapInfo(String ids) {
		// TODO Auto-generated method stub
		String[] idsArray = ids.split(",");
        mapInfoDao.deleteMapInfo(idsArray);
	}

	@Override
	public void updateMapInfoDail(MapInfoBean mapInfoBean) {
		// TODO Auto-generated method stub
		mapInfoDao.updateMapInfoDail(mapInfoBean);
	}

	@Override
	public void addMapInfoDail(MapInfoBean mapInfoBean) {
		// TODO Auto-generated method stub
		mapInfoDao.addMapInfoDail(mapInfoBean);
	}

}
