package com.isoftstone.contract.service.impl;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.isoftstone.contract.entity.ContractInfoBean;
import com.isoftstone.contract.repository.ContractDeleteDao;
import com.isoftstone.contract.service.ContractDeleteService;
import com.isoftstone.platform.common.uitl.FileUtilTool;

@Service("contractDeleteService")
public class ContractDeleteServiceImpl implements ContractDeleteService
{
    @Value("#{propertiesConfig['local.path']}")
    private String localPath = "d:\\img\\";
    
    @Resource
    private ContractDeleteDao contractDeleteDao;
    
    @Override
    public void delContractInfo(String infoID)
        throws IOException
    {
        List<ContractInfoBean> list = contractDeleteDao.queryContractInfo(infoID);
        for (ContractInfoBean contractInfoBean : list)
        {
            contractDeleteDao.delContractData(contractInfoBean.getDocutmentHeadDataId());
            contractDeleteDao.delContractData(contractInfoBean.getDocutmentBodyDataId());
            FileUtilTool.deleteFile(localPath + contractInfoBean.getDocutmentPictDataId());
        }
        contractDeleteDao.delContractInfo(infoID);
        
    }
    
}
