package com.example.mapper;

import com.example.entity.RiskFactor;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface RiskFactorMapper {
    // 原有方法：保留不变，不影响现有调用
    List<RiskFactor> selectAll();

    // 新增：上传（新增）风险因素
    int insert(RiskFactor riskFactor);

    // 新增：根据ID修改风险因素
    int updateById(RiskFactor riskFactor);

    // 新增：根据ID删除风险因素
    int deleteById(@Param("id") Long id);

    // 新增：根据ID查询单个风险因素（用于回显/校验）
    RiskFactor selectById(@Param("id") Long id);
}