package com.isoftstone.warehouse.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.warehouse.entity.WarehouseBean;
import com.isoftstone.warehouse.entity.WarehouseSearch;
import com.isoftstone.warehouse.repository.WarehouseDao;
import com.isoftstone.warehouse.service.WarehouseService;

@Service("warehouseService")
public class WarehouseServiceImpl
    implements WarehouseService
{
    private final static Logger log =
        Logger.getLogger(WarehouseServiceImpl.class);
    
    @Resource
    private WarehouseDao warehouseDao;
    
    @Override
    public PadingRstType<WarehouseBean> queryWarehouseByPageList(
        WarehouseSearch warehouseSearch,
        PagingBean pagingBean)
    {
        
        pagingBean.deal(WarehouseBean.class);
        List<WarehouseBean> warehouseBeanList =
            warehouseDao.queryWarehouseByPageList(warehouseSearch,
                pagingBean);
        //        log.info(JSON.toJSONString(warehouseBeanList));
        Integer total =
            warehouseDao.queryWarehouseTotal(warehouseSearch);
        //        log.info(JSON.toJSONString(total));
        
        PadingRstType<WarehouseBean> warehouseBean =
            new PadingRstType<WarehouseBean>();
        warehouseBean.setPage(pagingBean.getPage());
        warehouseBean.setTotal(total);
        warehouseBean.putItems(WarehouseBean.class,
            warehouseBeanList);
        
        return warehouseBean;
    }
    
    @Override
    public void deleteWarehouseInfo(
        String ids)
    {
        String[] idsArray =
            ids.split(",");
        warehouseDao.deleteWarehouseInfo(idsArray);
        // TODO Auto-generated method stub
        
    }
    
    @Override
    public void updateWarehouseDail(
        WarehouseBean warehouseBean)
    {
        warehouseDao.updateWarehouseDail(warehouseBean);
        
    }
    
    @Override
    public void addWarehouseDail(
        WarehouseBean warehouseBean)
    {
        warehouseDao.addWarehouseDail(warehouseBean);
        
    }
}
