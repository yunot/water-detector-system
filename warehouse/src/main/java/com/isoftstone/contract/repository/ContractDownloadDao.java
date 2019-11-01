package com.isoftstone.contract.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.isoftstone.contract.entity.ContractInfoBean;

@Repository("contractDownloadDao")
public interface ContractDownloadDao
{
    List<ContractInfoBean> queryContractInfo(@Param("infoID")
    String infoID);
    
    String queryData(@Param("dataID")
    String dataID);
}
