package com.example.controller;

import cn.hutool.core.date.DateField;
import com.example.common.Result;
import com.example.common.util.DateUtil;
import com.example.entity.RiskFactor;
import com.example.service.AccidentService;
import com.example.service.RiskFactorService;
import com.example.service.StatisticsService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;

/**
 * 安全事故统计分析控制器
 * 功能：提供事故类型分布、时间趋势、风险矩阵、关键指标、决策支持等统计接口
 * 适配前端图表展示（饼图、柱状图、风险矩阵）与数据决策需求
 */
@RestController
@RequestMapping("/errorStats") // 接口统一前缀，区分其他业务模块
public class ErrorStatsController {

    @Resource
    private AccidentService accidentService; // 事故核心业务服务（预留扩展）

    @Resource
    private RiskFactorService riskFactorService; // 风险因素查询服务

    @Resource
    private StatisticsService statisticsService; // 统计分析核心服务（数据聚合计算）

    /**
     * 事故类型分布饼图数据
     * 用途：前端渲染饼图，展示不同级别事故的数量占比
     * @return Result<List<Map<String, Object>>> 响应格式：[{name: "事故级别", value: 数量}, ...]
     */
    @GetMapping("/pie")
    public Result accidentTypePie() {
        List<Map<String, Object>> result = new ArrayList<>();
        // 1. 调用统计服务，按事故级别统计数量（如：特别重大、重大、较大、一般）
        Map<String, Long> typeCountMap = statisticsService.countByAccidentLevel();

        // 2. 格式化数据为前端饼图所需结构，统一级别名称显示
        typeCountMap.forEach((level, count) -> {
            Map<String, Object> data = new HashMap<>();
            data.put("name", formatLevelName(level)); // 格式化级别名称（如"特别重大"→"重特大事故"）
            data.put("value", count); // 该级别事故数量
            result.add(data);
        });

        return Result.success(result);
    }

    /**
     * 事故时间趋势柱状图数据
     * 用途：前端渲染柱状图，展示指定时间范围内的事故数量变化趋势
     * @param timeRange 时间范围筛选参数（默认week），可选值：week(近7天)/month(近1月)/quarter(近3月)/year(近1年)
     * @return Result<Map<String, Object>> 响应格式：{xAxis: [时间标签列表], yAxis: [对应时间的事故数量列表]}
     */
    @GetMapping("/bar")
    public Result timeTrendBar(@RequestParam(defaultValue = "week") String timeRange) {
        Map<String, Object> result = new HashMap<>();
        List<String> xAxis = new ArrayList<>(); // 柱状图X轴：时间标签（如"10-01"、"10-02"）
        List<Long> yAxis = new ArrayList<>(); // 柱状图Y轴：对应时间的事故数量

        // 1. 根据时间范围参数，计算起始时间和结束时间（结束时间为当前时间）
        Date[] dateRange = getDateRangeByType(timeRange);
        // 2. 调用统计服务，按时间范围和粒度统计事故数量（如按天/按月分组）
        List<Map<String, Object>> trendData = statisticsService.countByTimeRange(
                dateRange[0], dateRange[1], timeRange);

        // 3. 拆分时间标签和数量，组装为前端图表所需结构
        for (Map<String, Object> data : trendData) {
            xAxis.add(data.get("timeLabel").toString()); // 提取时间标签（如"2024-10-01"）
            yAxis.add(Long.parseLong(data.get("count").toString())); // 提取对应时间的事故数量
        }

        result.put("xAxis", xAxis);
        result.put("yAxis", yAxis);
        return Result.success(result);
    }

    /**
     * 风险矩阵数据
     * 用途：前端渲染风险矩阵图，展示各风险因素的概率、影响程度及综合风险得分
     * @return Result<List<Map<String, Object>>> 响应格式：[{factorName: 风险因素名, probability: 发生概率, impact: 影响级别, riskScore: 风险得分}, ...]
     */
    @GetMapping("/riskMatrix")
    public Result riskMatrix() {
        List<Map<String, Object>> matrixData = new ArrayList<>();
        // 1. 查询所有风险因素（如：操作不当、设备老化、环境因素等）
        List<RiskFactor> riskFactors = riskFactorService.selectAll();

        // 2. 计算各风险因素的综合风险得分（得分=发生概率×影响级别），组装矩阵数据
        for (RiskFactor factor : riskFactors) {
            Map<String, Object> data = new HashMap<>();
            data.put("factorName", factor.getName()); // 风险因素名称
            data.put("probability", factor.getProbability()); // 发生概率（0-100）
            data.put("impact", factor.getImpactLevel()); // 影响级别（1-5级）
            data.put("riskScore", factor.getProbability() * factor.getImpactLevel()); // 综合风险得分
            matrixData.add(data);
        }

        return Result.success(matrixData);
    }

    /**
     * 核心安全指标统计
     * 用途：前端展示关键安全数据看板，提供核心指标概览
     * @param timeRange 时间范围筛选参数（默认week），可选值：week/month/quarter/year
     * @return Result<Map<String, Object>> 响应格式：{totalAccidents: 总事故数, deathCount: 死亡人数, ...}
     */
    @GetMapping("/keyIndicators")
    public Result keyIndicators(@RequestParam(defaultValue = "week") String timeRange) {
        // 1. 根据时间范围参数，计算起始时间和结束时间
        Date[] dateRange = getDateRangeByType(timeRange);

        // 2. 调用统计服务，查询各类核心指标数据
        Map<String, Object> indicators = new HashMap<>();
        indicators.put("totalAccidents", statisticsService.countTotalAccidents(dateRange[0], dateRange[1])); // 总事故数
        indicators.put("deathCount", statisticsService.sumDeathCount(dateRange[0], dateRange[1])); // 死亡人数合计
        indicators.put("majorAccidents", statisticsService.countMajorAccidents(dateRange[0], dateRange[1])); // 重大事故数
        indicators.put("avgResponseTime", statisticsService.calcAvgResponseTime(dateRange[0], dateRange[1])); // 平均响应时间（分钟）
        indicators.put("involvedPersonCount", statisticsService.countInvolvedPersons(dateRange[0], dateRange[1])); // 涉及人数合计

        return Result.success(indicators);
    }

    /**
     * 安全决策支持数据
     * 用途：为管理人员提供风险管控建议，包括高风险区域、主要风险因素及具体措施
     * @return Result<Map<String, Object>> 响应格式：{highRiskAreas: 高风险区域列表, mainFactors: 主要风险因素, suggestion: 管控建议}
     */
    @GetMapping("/decisionSupport")
    public Result decisionSupport() {
        // 1. 查询Top3高风险区域（按风险得分排序）
        List<Map<String, Object>> highRiskAreas = statisticsService.findHighRiskAreas(3);
        // 2. 分析主要风险因素（按影响程度排序）
        List<Map<String, Object>> mainFactors = statisticsService.analyzeMainRiskFactors();
        // 3. 根据高风险区域和主要因素，生成针对性管控建议
        String suggestion = generateSuggestion(highRiskAreas, mainFactors);

        // 4. 组装响应数据
        Map<String, Object> result = new HashMap<>();
        result.put("highRiskAreas", highRiskAreas); // 高风险区域（含区域名、风险得分）
        result.put("mainFactors", mainFactors); // 主要风险因素（含因素名、影响占比）
        result.put("suggestion", suggestion); // 管控建议文案

        return Result.success(result);
    }

    /**
     * 私有工具方法：格式化事故级别名称
     * 作用：统一前端展示的级别名称，避免原始数据命名不统一
     * @param level 数据库中的事故级别（如"特别重大"、"重大"）
     * @return 格式化后的级别名称（如"特别重大"→"重特大事故"）
     */
    private String formatLevelName(String level) {
        return switch (level) {
            case "特别重大" -> "重特大事故";
            case "重大" -> "重大事故";
            case "较大" -> "较大事故";
            case "一般" -> "一般事故";
            default -> level; // 未知级别直接返回原始值，避免报错
        };
    }

    /**
     * 私有工具方法：根据时间范围类型，计算起始时间和结束时间
     * 作用：统一时间范围计算逻辑，避免重复代码
     * @param timeRange 时间范围类型（week/month/quarter/year）
     * @return Date[] 长度为2的数组，[0]为起始时间，[1]为结束时间（当前时间）
     */
    private Date[] getDateRangeByType(String timeRange) {
        return DateUtil.getDateRangeByType(timeRange);
    }

    /**
     * 私有工具方法：生成安全管控建议文案
     * 作用：根据高风险区域和主要风险因素，动态生成可落地的管控建议
     * @param areas 高风险区域列表（非空时取第一个区域）
     * @param factors 主要风险因素列表（非空时取第一个因素）
     * @return 管控建议文案（无数据时返回提示信息）
     */
    private String generateSuggestion(List<Map<String, Object>> areas, List<Map<String, Object>> factors) {
        if (areas.isEmpty() || factors.isEmpty()) {
            return "暂无足够风险数据生成建议，请先完善风险信息。";
        }
        // 动态拼接建议文案，基于查询到的高风险区域和主要因素
        return "1. 针对" + areas.getFirst().get("area") + "区域加强安全巡查；" +
                "2. 重点管控" + factors.getFirst().get("factorName") + "等风险因素；" +
                "3. 近期需开展专项安全培训，降低事故发生率。";
    }
}