package com.isoftstone.contract.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.isoftstone.contract.entity.ContractInfoBean;
import com.isoftstone.contract.entity.ContractSearch;
import com.isoftstone.platform.entity.BaseSelectBean;
import com.isoftstone.platform.entity.PagingBean;

@Repository("contractDao")
public interface ContractDao
{
    List<ContractInfoBean> queryContractByPageList(@Param("search")
    ContractSearch contractSearch, @Param("paging")
    PagingBean PagingBean);
    
    Integer queryContractTotal(@Param("search")
    ContractSearch contractSearch);
    
    String getHtmlContentHead(@Param("docutmentHeadDataId")
    String docutmentHeadDataId);
    
    String getHtmlContentBody(@Param("docutmentBodyDataId")
    String docutmentBodyDataId);
    
    List<BaseSelectBean> getAll();
    void updateHtmlBody(@Param("body")
    String body, @Param("docutmentBodyDataId")
    String docutmentBodyDataId);
    
}
