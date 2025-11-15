package com.example.dto.response;

import lombok.Data;
import java.util.List;

/**
 * AI分析结果响应DTO
 */
@Data
public class AIAnalysisResponse {
    private List<String> humanAnalysis;   // 人体姿态分析
    private List<String> deviceAnalysis;  // 设备分析
    private List<String> realtimeAlerts;  // 实时警报
}