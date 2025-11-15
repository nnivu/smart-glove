package com.example.service;

import com.example.entity.RiskFactor;
import java.util.List;

public interface RiskFactorService {
    // 原有方法：保留不变
    List<RiskFactor> selectAll();

    // 新增：上传（新增）风险因素
    boolean saveRiskFactor(RiskFactor riskFactor);

    // 新增：修改风险因素
    boolean updateRiskFactor(RiskFactor riskFactor);

    // 新增：根据ID删除风险因素
    boolean deleteRiskFactorById(Long id);

    // 新增：根据ID查询单个风险因素
    RiskFactor selectById(Long id);
}