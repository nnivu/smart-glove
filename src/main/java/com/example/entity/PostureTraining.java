package com.example.entity;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * 姿态训练表（数据库映射）
 */
@Data
public class PostureTraining {
    private Long id;                // 主键ID
    private String datasetName;     // 姿态数据集名称
    private Double score;           // 姿态评分
    private String riskLevel;       // 风险等级（低/中/高）
    private Double progress;        // 训练进度（%）
    private String deviceStatus;    // 设备状态（已连接/断开连接）
    private Double armAngle;        // 手臂角度（°）
    private Double wristPosition;   // 腕部位置（cm）
    private String bodyPosture;     // 身体姿态（正常/偏移/异常）
    private Double sprayDistance;   // 喷涂距离（cm）
    private Double sprayAngle;      // 喷涂角度（°）
    private Double pressure;        // 压力值
    private LocalDateTime createTime; // 创建时间
    private LocalDateTime updateTime; // 更新时间
}