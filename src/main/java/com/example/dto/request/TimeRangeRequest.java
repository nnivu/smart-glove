package com.example.dto.request;

import lombok.Data;
import jakarta.validation.constraints.NotBlank;  // 关键修改：javax → jakarta

/**
 * 时间范围请求DTO
 */
@Data
public class TimeRangeRequest {

    @NotBlank(message = "时间范围不能为空")
    private String timeRange; // 时间范围（week/month/quarter/year）
}