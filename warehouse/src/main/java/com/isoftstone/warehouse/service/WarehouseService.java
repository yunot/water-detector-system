package com.isoftstone.warehouse.service;

import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.warehouse.entity.WarehouseBean;
import com.isoftstone.warehouse.entity.WarehouseSearch;

public interface WarehouseService
{
    PadingRstType<WarehouseBean> queryWarehouseByPageList(
        WarehouseSearch warehouseSearch,
        PagingBean pagingBean);
    
    void deleteWarehouseInfo(
        String ids);
    
    void updateWarehouseDail(
        WarehouseBean warehouseBean);
    
    void addWarehouseDail(
        WarehouseBean warehouseBean);
}
