package com.example.dto.response;

import lombok.Data;

/**
 * 实时关键点响应DTO
 */
@Data
public class KeyPointResponse {
    private String name;        // 关键点名称
    private Integer x;          // X坐标
    private Integer y;          // Y坐标
    private String status;      // 状态（normal/warning/danger）
}