package com.example.dto.request;

import lombok.Data;
import javax.validation.constraints.NotBlank;

/**
 * 时间范围请求DTO
 */
@Data
public class TimeRangeRequest {
    @NotBlank(message = "时间范围不能为空")
    private String timeRange; // 时间范围（week/month/quarter/year）
}