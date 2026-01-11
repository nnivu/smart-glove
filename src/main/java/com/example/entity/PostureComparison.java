package com.example.entity;

import lombok.Data;

/**
 * 姿态对比表（数据库映射）
 */
@Data
public class PostureComparison {
    private Long id;            // 主键ID
    private String itemName;    // 对比项名称（头部位置/肩部平衡等）
    private Double userValue;   // 用户实际值
    private Double standardValue; // 标准值
    private Long trainingId;    // 关联训练ID
}