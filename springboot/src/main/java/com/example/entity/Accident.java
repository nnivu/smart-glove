package com.example.entity;

import lombok.Data;

import java.util.Date;

@Data
public class Accident {
    private Long id;
    private String level;
    private Date happenTime;
    private Date responseTime;
    private int deathCount;
    private int injuredCount;
    private String relatedArea;
    // 其他事故相关字段
}