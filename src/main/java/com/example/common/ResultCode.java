package com.example.common;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 全局响应状态码枚举
 */
@Getter
@AllArgsConstructor
public enum ResultCode {
    SUCCESS("200", "操作成功"),
    FAIL("500", "操作失败"),
    PARAM_ERROR("400", "参数错误"),
    DATA_NOT_FOUND("404", "数据不存在");

    private final String code;
    private final String msg;
}