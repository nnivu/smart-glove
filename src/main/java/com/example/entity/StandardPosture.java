package com.example.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.Date;

/**
 * 标准姿态参考表（数据库映射）
 */
@Data
@TableName("t_standard_posture")
public class StandardPosture {
    @TableId(type = IdType.AUTO)
    private Long id;                // 主键ID
    private String name;            // 标准姿态名称
    private String description;     // 描述
    private String imageUrl;        // 图片地址
    private Double standardArmAngle; // 标准手臂角度
    private Double standardWristPosition; // 标准手腕位置
    private String standardBodyPosture; // 标准身体姿态
    private Double standardSprayDistance; // 标准喷涂距离
    private Double standardSprayAngle; // 标准喷涂角度
    private Double standardPressure; // 标准压力
    private Date createTime;        // 创建时间
    private Date updateTime;        // 更新时间
}