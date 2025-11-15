package com.example.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.time.LocalDateTime;

/**
 * 训练统计表（数据库映射）
 */
@Data
@TableName("t_training_stats") // 与数据库表名一致
public class TrainingStats {
    @TableId(type = IdType.AUTO)
    private Long id;                // 主键ID（自增）
    private Integer trainingTimes;  // 训练次数
    private Double avgScore;        // 平均评分（0-100）
    private Double errorRate;       // 错误率（%）
    private Double accuracy;        // 准确率（%）
    private String level;           // 等级（Beginner/Intermediate/Advanced）
    private String certification;   // 认证率（%）
    private LocalDateTime statsDate; // 统计日期（核心时间字段，与XML查询条件对应）
    // 新增审计字段（可选，用于数据追踪，与XML映射对齐）
    private LocalDateTime createTime; // 创建时间
    private LocalDateTime updateTime; // 更新时间
}