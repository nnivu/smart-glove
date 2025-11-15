package com.example.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface StatisticsService {
    Map<String, Long> countByAccidentLevel();
    List<Map<String, Object>> countByTimeRange(Date start, Date end, String timeRange);
    Long countTotalAccidents(Date start, Date end);
    Integer sumDeathCount(Date start, Date end);
    Long countMajorAccidents(Date start, Date end);
    Double calcAvgResponseTime(Date start, Date end);
    Integer countInvolvedPersons(Date start, Date end);
    List<Map<String, Object>> findHighRiskAreas(Integer topN);
    List<Map<String, Object>> analyzeMainRiskFactors();
}