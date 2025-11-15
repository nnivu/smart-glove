package com.example.service.impl;

import com.example.entity.RiskFactor;
import com.example.mapper.RiskFactorMapper;
import com.example.service.RiskFactorService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import java.util.Date;
import java.util.List;

@Service
public class RiskFactorServiceImpl implements RiskFactorService {

    @Resource
    private RiskFactorMapper riskFactorMapper;

    // 原有方法：保留不变，不影响现有调用
    @Override
    public List<RiskFactor> selectAll() {
        return riskFactorMapper.selectAll();
    }

    // 新增：上传（新增）风险因素（补充创建时间/更新时间）
    @Override
    public boolean saveRiskFactor(RiskFactor riskFactor) {
        // 补充基础字段（前端无需传递）
        if (riskFactor.getCreateTime() == null) {
            riskFactor.setCreateTime(new Date());
        }
        riskFactor.setUpdateTime(new Date());
        // 调用Mapper插入数据（返回影响行数>0则成功）
        return riskFactorMapper.insert(riskFactor) > 0;
    }

    // 新增：修改风险因素（校验ID存在性+更新时间戳）
    @Override
    public boolean updateRiskFactor(RiskFactor riskFactor) {
        // 校验ID是否存在
        if (riskFactor.getId() == null || riskFactorMapper.selectById(riskFactor.getId()) == null) {
            return false;
        }
        riskFactor.setUpdateTime(new Date()); // 更新时间戳
        return riskFactorMapper.updateById(riskFactor) > 0;
    }

    // 新增：根据ID删除风险因素（校验ID存在性）
    @Override
    public boolean deleteRiskFactorById(Long id) {
        if (id == null || riskFactorMapper.selectById(id) == null) {
            return false;
        }
        return riskFactorMapper.deleteById(id) > 0;
    }

    // 新增：根据ID查询单个风险因素
    @Override
    public RiskFactor selectById(Long id) {
        return riskFactorMapper.selectById(id);
    }
}