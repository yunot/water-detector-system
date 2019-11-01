package com.isoftstone.rookie.system.dictionary.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.isoftstone.rookie.system.dictionary.dao.DictDataMapper;
import com.isoftstone.rookie.system.dictionary.entity.DictData;
import com.isoftstone.rookie.system.dictionary.service.DictDatService;

@Service
public class DictDataServiceImpl implements DictDatService
{
    @Resource
    private DictDataMapper dictDataMapper;
    
    @Override
    public List<DictData> selectDictDataByType(String dictType, String code)
    {
        return dictDataMapper.selectDictDataByType(dictType, code);
    }
}
