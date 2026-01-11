package com.example.dto.response;

import lombok.Data;

/**
 * 训练统计响应DTO
 */
@Data
public class TrainingStatsResponse {
    private Integer trainingTimes; // 训练次数
    private Double avgScore;       // 平均评分
    private Double errorRate;      // 错误率（%）
    private Double accuracy;       // 准确率（%）
    private String level;          // 等级
    private String certification;  // 认证率（%）
}