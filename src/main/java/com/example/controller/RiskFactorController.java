package com.example.controller;

import com.example.common.Result;
import com.example.entity.RiskFactor;
import com.example.service.RiskFactorService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Date;

/**
 * 风险因素控制层（参考AccidentController风格，保留原有接口+新增CRUD）
 */
@RestController
@RequestMapping("/api/risk-factor") // 保留原有接口前缀，不影响现有调用
public class RiskFactorController {

    @Resource
    private RiskFactorService riskFactorService;

    // 原有接口：保留不变，兼容现有调用
    @GetMapping("/all")
    public Result getAllRiskFactors() {
        List<RiskFactor> riskFactors = riskFactorService.selectAll();
        return Result.success(riskFactors);
    }

    /**
     * 上传（新增）风险因素（参考AccidentController/add风格）
     * @param riskFactor 前端传递的风险因素信息（JSON格式）
     */
    @PostMapping("/add")
    public Result addRiskFactor(@RequestBody RiskFactor riskFactor) {
        // 补充基础字段（参考Accident补充创建时间的逻辑）
        if (riskFactor.getCreateTime() == null) {
            riskFactor.setCreateTime(new Date());
        }
        // 校验核心必填字段（增强健壮性，参考Accident无额外校验但补充必要逻辑）
        if (riskFactor.getName() == null || riskFactor.getProbability() == null || riskFactor.getImpactLevel() == null) {
            return Result.error("风险名称、发生概率、影响程度为必填字段");
        }
        // 调用Service层新增方法
        boolean success = riskFactorService.saveRiskFactor(riskFactor);
        return success ? Result.success("风险因素上传成功") : Result.error("风险因素上传失败");
    }

    /**
     * 修改已有风险因素（参考AccidentController/update风格）
     * @param riskFactor 包含id和修改信息的风险因素对象
     */
    @PostMapping("/update")
    public Result updateRiskFactor(@RequestBody RiskFactor riskFactor) {
        // 校验id是否存在（参考Accident的ID校验逻辑）
        if (riskFactor.getId() == null) {
            return Result.error("风险因素ID不能为空，无法修改");
        }
        boolean success = riskFactorService.updateRiskFactor(riskFactor);
        return success ? Result.success("风险因素更新成功") : Result.error("风险因素更新失败或数据未变化");
    }

    /**
     * 根据ID删除风险因素（参考AccidentController/delete风格）
     * @param id 风险因素ID
     */
    @GetMapping("/delete/{id}")
    public Result deleteRiskFactor(@PathVariable Long id) {
        boolean success = riskFactorService.deleteRiskFactorById(id);
        return success ? Result.success("风险因素删除成功") : Result.error("风险因素不存在或删除失败");
    }

    /**
     * 根据ID查询单个风险因素（可选，参考风格补充，便于前端回显）
     * @param id 风险因素ID
     */
    @GetMapping("/{id}")
    public Result getRiskFactorById(@PathVariable Long id) {
        RiskFactor riskFactor = riskFactorService.selectById(id);
        return riskFactor != null ? Result.success(riskFactor) : Result.error("风险因素不存在");
    }
}