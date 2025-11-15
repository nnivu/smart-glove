package com.example.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * 实时关键点表（数据库映射）
 */
@Data
@TableName("t_key_point")
public class KeyPoint {
    @TableId(type = IdType.AUTO)
    private Long id;            // 主键ID
    private String name;        // 关键点名称（鼻子/左眼/右肩等）
    private Integer x;          // X坐标
    private Integer y;          // Y坐标
    private String status;      // 状态（normal/warning/danger）
    private Long trainingId;    // 关联训练ID
}