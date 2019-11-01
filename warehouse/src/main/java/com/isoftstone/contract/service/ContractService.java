package com.isoftstone.contract.service;

import java.util.List;

import com.isoftstone.contract.entity.ContractInfoBean;
import com.isoftstone.contract.entity.ContractSearch;
import com.isoftstone.platform.entity.BaseSelectBean;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;

public interface ContractService
{
    PadingRstType<ContractInfoBean> queryContractByPageList(ContractSearch contractSearch, PagingBean pagingBean);
    
    String getHtmlContentHead(String docutmentHeadDataId);
    
    String getHtmlContentBody(String docutmentBodyDataId);
    
    List<BaseSelectBean> getAll();
    
    String getHtmlContent(String docutmentHeadDataId, String docutmentBodyDataId);
    
    void updateHtmlBody(String body, String docutmentBodyDataId);
    
    void newContract(String newContractHead, String newContractBody, String newContractName);
}
