package com.isoftstone.contract.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.isoftstone.contract.entity.ContractDataBean;
import com.isoftstone.contract.entity.ContractInfoBean;

@Repository("contractUploadDao")
public interface ContractUploadDao
{
    void saveContractInfo(@Param("contractInfo")
    ContractInfoBean contractInfoBean);
    
    List<ContractInfoBean> queryContractInfoById(@Param("contractId")
    String contractId);
    
    void saveContractData(@Param("contractData")
    ContractDataBean contractDataBean);
}
