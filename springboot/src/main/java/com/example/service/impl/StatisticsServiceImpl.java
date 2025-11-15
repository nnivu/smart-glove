package com.example.service.impl;

import com.example.entity.Accident;
import com.example.entity.RiskFactor;
import com.example.mapper.AccidentMapper;
import com.example.mapper.RiskFactorMapper;
import com.example.service.StatisticsService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.HashMap;
import cn.hutool.core.date.DateUtil;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class StatisticsServiceImpl implements StatisticsService {

    @Resource
    private AccidentMapper accidentMapper;

    @Resource
    private RiskFactorMapper riskFactorMapper;

    @Override
    public Map<String, Long> countByAccidentLevel() {
        List<Accident> accidents = accidentMapper.selectAll();
        return accidents.stream()
                .collect(Collectors.groupingBy(Accident::getLevel, Collectors.counting()));
    }

    @Override
    public List<Map<String, Object>> countByTimeRange(Date start, Date end, String timeRange) {
        List<Accident> accidents = accidentMapper.selectByTimeRange(start, end);
        List<Map<String, Object>> result = new ArrayList<>();

        if ("week".equals(timeRange)) {
            Map<String, Long> dayCount = accidents.stream()
                    .collect(Collectors.groupingBy(
                            a -> DateUtil.format(a.getHappenTime(), "MM-dd"),
                            Collectors.counting()
                    ));
            dayCount.forEach((day, count) -> {
                Map<String, Object> map = new HashMap<>();
                map.put("timeLabel", day);
                map.put("count", count);
                result.add(map);
            });
        }
        // 可补充month、quarter、year等时间范围的逻辑
        return result;
    }

    @Override
    public Long countTotalAccidents(Date start, Date end) {
        return (long) accidentMapper.selectByTimeRange(start, end).size();
    }

    @Override
    public Integer sumDeathCount(Date start, Date end) {
        List<Accident> accidents = accidentMapper.selectByTimeRange(start, end);
        return accidents.stream()
                .mapToInt(Accident::getDeathCount)
                .sum();
    }

    @Override
    public Long countMajorAccidents(Date start, Date end) {
        List<String> majorLevels = List.of("较大", "重大", "特别重大");
        return accidentMapper.selectByTimeRange(start, end).stream()
                .filter(a -> majorLevels.contains(a.getLevel()))
                .count();
    }

    @Override
    public Double calcAvgResponseTime(Date start, Date end) {
        List<Accident> accidents = accidentMapper.selectByTimeRange(start, end);
        long totalMinutes = 0;
        int validCount = 0;
        for (Accident a : accidents) {
            if (a.getHappenTime() != null && a.getResponseTime() != null) {
                long diff = a.getResponseTime().getTime() - a.getHappenTime().getTime();
                totalMinutes += diff / (1000 * 60);
                validCount++;
            }
        }
        return validCount == 0 ? 0.0 : (double) totalMinutes / validCount;
    }

    @Override
    public Integer countInvolvedPersons(Date start, Date end) {
        List<Accident> accidents = accidentMapper.selectByTimeRange(start, end);
        return accidents.stream()
                .mapToInt(a -> a.getDeathCount() + a.getInjuredCount())
                .sum();
    }

    @Override
    public List<Map<String, Object>> findHighRiskAreas(Integer topN) {
        List<RiskFactor> factors = riskFactorMapper.selectAll();
        Map<String, Double> areaRiskSum = factors.stream()
                .collect(Collectors.groupingBy(
                        RiskFactor::getRelatedArea,
                        Collectors.summingDouble(f -> f.getProbability() * f.getImpactLevel())
                ));
        return areaRiskSum.entrySet().stream()
                .sorted((e1, e2) -> e2.getValue().compareTo(e1.getValue()))
                .limit(topN)
                .map(e -> {
                    Map<String, Object> map = new HashMap<>();
                    map.put("area", e.getKey());
                    map.put("riskScore", e.getValue());
                    return map;
                })
                .collect(Collectors.toList());
    }

    @Override
    public List<Map<String, Object>> analyzeMainRiskFactors() {
        List<RiskFactor> factors = riskFactorMapper.selectAll();
        return factors.stream()
                .map(f -> {
                    Map<String, Object> map = new HashMap<>();
                    map.put("factorName", f.getName());
                    map.put("totalRiskScore", f.getProbability() * f.getImpactLevel());
                    return map;
                })
                .sorted((m1, m2) -> {
                    double s1 = (double) m1.get("totalRiskScore");
                    double s2 = (double) m2.get("totalRiskScore");
                    return Double.compare(s2, s1);
                })
                .collect(Collectors.toList());
    }
}