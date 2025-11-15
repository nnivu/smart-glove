package com.example.entity;

import java.util.Date;
import lombok.Data;

/**
 * 风险因素实体类（保留原有字段，新增CRUD必要字段）
 */
@Data
public class RiskFactor {
    // 新增：主键ID（修改/删除的唯一标识，不影响原有查询）
    private Long id;
    // 原有字段（与数据库表字段对应）
    private String name; // 风险因素名称（对应数据库name）
    private Double probability; // 发生概率（对应数据库probability）
    private Integer impactLevel; // 影响程度（对应数据库impact_level，驼峰映射）
    private String relatedArea; // 关联区域（对应数据库related_area，驼峰映射）
    private String description; // 风险描述（对应数据库description）
    private Date createTime; // 创建时间（对应数据库create_time，原有可选字段）
    // 新增：更新时间（用于数据维护）
    private Date updateTime;
}