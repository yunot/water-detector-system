package com.isoftstone.map.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.isoftstone.map.entity.MapInfoBean;
import com.isoftstone.map.entity.MapLogBean;
import com.isoftstone.map.entity.MapLogSearch;
import com.isoftstone.map.repository.MapLogDao;
import com.isoftstone.map.service.MapLogService;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;

@Service("MapLogService")
public class MapLogServiceImpl implements MapLogService{
	
	private static final Logger log = Logger.getLogger(MapLogServiceImpl.class);
    
    @Resource
    private MapLogDao mapLogDao;

	@Override
	public PadingRstType<MapLogBean> queryMapLogList(MapLogSearch mapLogSearch, PagingBean pagingBean) {
		// TODO Auto-generated method stub
		pagingBean.deal(MapInfoBean.class);
        List<MapLogBean> mapLogBeanList = mapLogDao.queryMapLogByPageList(mapLogSearch, pagingBean);
        //        log.info(JSON.toJSONString(warehouseBeanList));
        Integer total = mapLogDao.queryMapLogTotal(mapLogSearch);
        
        PadingRstType<MapLogBean> mapLogBean = new PadingRstType<MapLogBean>();
        mapLogBean.setPage(pagingBean.getPage());
        mapLogBean.setTotal(total);
        mapLogBean.putItems(MapLogBean.class, mapLogBeanList);
        
        return mapLogBean;
	}

	@Override
	public void deleteMapLog(String ids) {
		// TODO Auto-generated method stub
		String[] idsArray = ids.split(",");
        mapLogDao.deleteMapLog(idsArray);
	}

	@Override
	public void updateMapLogDail(MapLogBean mapLogBean) {
		// TODO Auto-generated method stub
		mapLogDao.updateMapLogDail(mapLogBean);
	}

	@Override
	public void addMapLogDail(MapLogBean mapLogBean) {
		// TODO Auto-generated method stub
		mapLogDao.addMapLogDail(mapLogBean);
	}

}
