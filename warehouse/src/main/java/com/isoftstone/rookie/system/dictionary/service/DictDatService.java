package com.isoftstone.rookie.system.dictionary.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.isoftstone.rookie.system.dictionary.entity.DictData;

public interface DictDatService
{
    public List<DictData> selectDictDataByType(@Param("dictType") String dictType, @Param("code") String code);
}
