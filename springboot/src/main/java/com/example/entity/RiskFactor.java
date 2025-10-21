package com.example.entity;

import lombok.Data;

@Data
public class RiskFactor {
    private Long id;
    private String name;
    private Double probability;
    private Integer impactLevel;
    private String relatedArea;
    // 其他风险因素相关字段
}