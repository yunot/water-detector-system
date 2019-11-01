package com.isoftstone.warehouse.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.isoftstone.platform.entity.PagingBean;
import com.isoftstone.warehouse.entity.WarehouseBean;
import com.isoftstone.warehouse.entity.WarehouseSearch;

@Repository("warehouseDao")
public interface WarehouseDao
{
    List<WarehouseBean> queryWarehouseByPageList(
        @Param("search")
        WarehouseSearch warehouseSearch,
        @Param("paging")
        PagingBean PagingBean);
    
    Integer queryWarehouseTotal(
        @Param("search")
        WarehouseSearch warehouseSearch);
    
    void deleteWarehouseInfo(
        @Param("ids")
        String[] idsArray);
    
    void updateWarehouseDail(
        @Param("warehouse")
        WarehouseBean warehouseBean);
    
    void addWarehouseDail(
        @Param("warehouse")
        WarehouseBean warehouseBean);
}
