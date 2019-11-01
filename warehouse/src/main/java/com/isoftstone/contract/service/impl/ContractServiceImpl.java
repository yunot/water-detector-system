package com.isoftstone.contract.service.impl;

import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.isoftstone.contract.entity.ContractDataBean;
import com.isoftstone.contract.entity.ContractInfoBean;
import com.isoftstone.contract.entity.ContractSearch;
import com.isoftstone.contract.repository.ContractDao;
import com.isoftstone.contract.repository.ContractUploadDao;
import com.isoftstone.contract.service.ContractService;
import com.isoftstone.platform.entity.BaseSelectBean;
import com.isoftstone.platform.entity.PadingRstType;
import com.isoftstone.platform.entity.PagingBean;

@Service("contractService")
public class ContractServiceImpl implements ContractService
{
    private final static Logger log = Logger.getLogger(ContractServiceImpl.class);
    
    @Resource
    private ContractDao contractDao;
    
    @Resource
    private ContractUploadDao contractUploadDao;
    
    @Value("#{propertiesConfig['pic.path']}")
    private String picPath = "http://127.0.0.1:18080/warehouse/contractUpload/downloadPic";
    
    @Override
    public PadingRstType<ContractInfoBean> queryContractByPageList(ContractSearch contractSearch, PagingBean pagingBean)
    {
        
        pagingBean.deal(ContractInfoBean.class);
        List<ContractInfoBean> contractInfoBeanList = contractDao.queryContractByPageList(contractSearch, pagingBean);
        //        log.info(JSON.toJSONString(warehouseBeanList));
        Integer total = contractDao.queryContractTotal(contractSearch);
        //        log.info(JSON.toJSONString(total));
        
        PadingRstType<ContractInfoBean> contractInfoBean = new PadingRstType<ContractInfoBean>();
        contractInfoBean.setPage(pagingBean.getPage());
        contractInfoBean.setTotal(total);
        contractInfoBean.putItems(ContractInfoBean.class, contractInfoBeanList);
        
        return contractInfoBean;
    }
    
    @Override
    public String getHtmlContentHead(String docutmentHeadDataId)
    {
        return contractDao.getHtmlContentHead(docutmentHeadDataId);
    }
    
    @Override
    public String getHtmlContentBody(String docutmentBodyDataId)
    {
        return contractDao.getHtmlContentBody(docutmentBodyDataId);
    }
    
    @Override
    public List<BaseSelectBean> getAll()
    {
        return contractDao.getAll();
    }
    
    public String getHtmlContent(String docutmentHeadDataId, String docutmentBodyDataId)
    {
        String head = contractDao.getHtmlContentHead(docutmentHeadDataId);
        String body = contractDao.getHtmlContentBody(docutmentBodyDataId);
        String contract = head + body;
        contract = contract.replaceAll("##", picPath);
        return contract;
    }
    
    @Override
    public void updateHtmlBody(String body, String docutmentBodyDataId)
    {
        contractDao.updateHtmlBody(body, docutmentBodyDataId);
    }
    
    @Override
    public void newContract(String newContractHead, String newContractBody, String newContractName)
    {
        ContractDataBean contractDataHeadBean = new ContractDataBean();
        ContractDataBean contractDataBodyBean = new ContractDataBean();
        ContractInfoBean contractInfoBean = new ContractInfoBean();
        
        String uuidSubStr = UUID.randomUUID().toString();
        String uuidHead = UUID.randomUUID().toString();
        String uuidBody = UUID.randomUUID().toString();
        
        contractInfoBean.setDocutmentInfoName(newContractName);
        contractInfoBean.setDocutmentHeadDataId(uuidHead);
        contractInfoBean.setDocutmentBodyDataId(uuidBody);
        contractInfoBean.setDocutmentPictDataId(uuidSubStr);
        
        contractDataHeadBean.setDocutmentDataId(uuidHead);
        contractDataHeadBean.setDocutmentDataName(newContractName);
        contractDataHeadBean.setDocutmentData(newContractHead);
        
        contractDataBodyBean.setDocutmentDataId(uuidBody);
        contractDataBodyBean.setDocutmentDataName(newContractName);
        contractDataBodyBean.setDocutmentData(newContractBody);
        contractUploadDao.saveContractInfo(contractInfoBean);
        contractUploadDao.saveContractData(contractDataHeadBean);
        contractUploadDao.saveContractData(contractDataBodyBean);
        
    }
    
}
