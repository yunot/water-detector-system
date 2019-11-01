package com.isoftstone.contract.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.isoftstone.contract.entity.ContractInfoBean;

@Repository("contractDeleteDao")
public interface ContractDeleteDao
{
    void delContractInfo(@Param("infoID")
    String infoID);
    
    void delContractData(@Param("dataID")
    String dataID);
    
    List<ContractInfoBean> queryContractInfo(@Param("infoID")
    String infoID);
}
