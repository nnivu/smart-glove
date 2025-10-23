package com.example.controller;

import com.example.common.Result;
import com.example.entity.RiskFactor;
import com.example.service.AccidentService;
import com.example.service.RiskFactorService;
import com.example.service.StatisticsService;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.DateField;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/errorStats")
public class ErrorStatsController {

    @Resource
    private AccidentService accidentService;

    @Resource
    private RiskFactorService riskFactorService;

    @Resource
    private StatisticsService statisticsService;

    @GetMapping("/pie")
    public Result accidentTypePie() {
        List<Map<String, Object>> result = new ArrayList<>();
        Map<String, Long> typeCountMap = statisticsService.countByAccidentLevel();

        typeCountMap.forEach((level, count) -> {
            Map<String, Object> data = new HashMap<>();
            data.put("name", formatLevelName(level));
            data.put("value", count);
            result.add(data);
        });

        return Result.success(result);
    }

    @GetMapping("/bar")
    public Result timeTrendBar(@RequestParam(defaultValue = "week") String timeRange) {
        Map<String, Object> result = new HashMap<>();
        List<String> xAxis = new ArrayList<>();
        List<Long> yAxis = new ArrayList<>();

        Date[] dateRange = getDateRangeByType(timeRange);
        List<Map<String, Object>> trendData = statisticsService.countByTimeRange(
                dateRange[0], dateRange[1], timeRange);

        for (Map<String, Object> data : trendData) {
            xAxis.add(data.get("timeLabel").toString());
            yAxis.add(Long.parseLong(data.get("count").toString()));
        }

        result.put("xAxis", xAxis);
        result.put("yAxis", yAxis);
        return Result.success(result);
    }

    @GetMapping("/riskMatrix")
    public Result riskMatrix() {
        List<Map<String, Object>> matrixData = new ArrayList<>();
        List<RiskFactor> riskFactors = riskFactorService.selectAll();

        for (RiskFactor factor : riskFactors) {
            Map<String, Object> data = new HashMap<>();
            data.put("factorName", factor.getName());
            data.put("probability", factor.getProbability());
            data.put("impact", factor.getImpactLevel());
            data.put("riskScore", factor.getProbability() * factor.getImpactLevel());
            matrixData.add(data);
        }

        return Result.success(matrixData);
    }

    @GetMapping("/keyIndicators")
    public Result keyIndicators(@RequestParam(defaultValue = "week") String timeRange) {
        Date[] dateRange = getDateRangeByType(timeRange);

        Map<String, Object> indicators = new HashMap<>();
        indicators.put("totalAccidents", statisticsService.countTotalAccidents(dateRange[0], dateRange[1]));
        indicators.put("deathCount", statisticsService.sumDeathCount(dateRange[0], dateRange[1]));
        indicators.put("majorAccidents", statisticsService.countMajorAccidents(dateRange[0], dateRange[1]));
        indicators.put("avgResponseTime", statisticsService.calcAvgResponseTime(dateRange[0], dateRange[1]));
        indicators.put("involvedPersonCount", statisticsService.countInvolvedPersons(dateRange[0], dateRange[1]));

        return Result.success(indicators);
    }

    @GetMapping("/decisionSupport")
    public Result decisionSupport() {
        List<Map<String, Object>> highRiskAreas = statisticsService.findHighRiskAreas(3);
        List<Map<String, Object>> mainFactors = statisticsService.analyzeMainRiskFactors();
        String suggestion = generateSuggestion(highRiskAreas, mainFactors);

        Map<String, Object> result = new HashMap<>();
        result.put("highRiskAreas", highRiskAreas);
        result.put("mainFactors", mainFactors);
        result.put("suggestion", suggestion);

        return Result.success(result);
    }

    private String formatLevelName(String level) {
        return switch (level) {
            case "特别重大" -> "重特大事故";
            case "重大" -> "重大事故";
            case "较大" -> "较大事故";
            case "一般" -> "一般事故";
            default -> level;
        };
    }

    private Date[] getDateRangeByType(String timeRange) {
        Date end = new Date();
        Date start;
        return switch (timeRange) {
            case "month" -> new Date[]{DateUtil.offsetMonth(end, -1), end};
            case "quarter" -> new Date[]{DateUtil.offsetMonth(end, -3), end};
            case "year" -> new Date[]{DateUtil.offset(end, DateField.YEAR, -1), end};
            default -> new Date[]{DateUtil.offsetDay(end, -6), end};
        };
    }

    private String generateSuggestion(List<Map<String, Object>> areas, List<Map<String, Object>> factors) {
        if (areas.isEmpty() || factors.isEmpty()) {
            return "暂无足够风险数据生成建议，请先完善风险信息。";
        }
        return "1. 针对" + areas.get(0).get("area") + "区域加强安全巡查；" +
                "2. 重点管控" + factors.get(0).get("factorName") + "等风险因素；" +
                "3. 近期需开展专项安全培训，降低事故发生率。";
    }
}