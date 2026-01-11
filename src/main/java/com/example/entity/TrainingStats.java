package com.example.entity;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * 训练统计表（数据库映射）
 */
@Data
public class TrainingStats {
    private Long id;                // 主键ID（自增）
    private Integer trainingTimes;  // 训练次数
    private Double avgScore;        // 平均评分（0-100）
    private Double errorRate;       // 错误率（%）
    private Double accuracy;        // 准确率（%）
    private String level;           // 等级（Beginner/Intermediate/Advanced）
    private String certification;   // 认证率（%）
    private LocalDateTime statsDate; // 统计日期
    private LocalDateTime createTime; // 创建时间
    private LocalDateTime updateTime; // 更新时间
}