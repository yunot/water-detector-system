package com.isoftstone.rookie.system.dictionary.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.isoftstone.rookie.system.dictionary.entity.DictData;

/**
 *
 * @author ZSJ
 */
@Repository
public interface DictDataMapper
{
    
    public List<DictData> selectDictDataByType(@Param("dictType")
    String dictType, @Param("code")
    String code);
    
    public String selectDictLabel(@Param("dictType")
    String dictType, @Param("dictValue")
    String dictValue);
    
    /**
     * 根据字典数据ID查询信息
     *
     * @param dictCode 字典数据ID
     * @return 字典数据
     */
    public DictData selectDictDataById(Long dictCode);
    
    /**
     * 查询字典数据
     *
     * @param dictType 字典类型
     * @return 字典数据
     */
    public int countDictDataByType(String dictType);
}
