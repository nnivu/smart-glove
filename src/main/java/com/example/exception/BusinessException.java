package com.example.exception;

import com.example.common.ResultCode;
import lombok.Getter;

/**
 * 自定义业务异常
 * 继承RuntimeException，避免事务中需要手动捕获
 */
@Getter
public class BusinessException extends RuntimeException {
    private final String code;
    private final String message;

    /**
     * 全参构造：指定异常码和信息
     */
    public BusinessException(String code, String message) {
        super(message);
        this.code = code;
        this.message = message;
    }

    /**
     * 简化构造：默认异常码（如500）+ 自定义信息
     */
    public BusinessException(String message) {
        this("500", message);
    }

    /**
     * 核心构造：通过ResultCode枚举构造异常（使用枚举的码和消息）
     */
    public BusinessException(ResultCode resultCode) {
        this(resultCode.getCode(), resultCode.getMsg());
    }

    /**
     * 扩展构造：通过ResultCode枚举+自定义消息构造异常（保留枚举码，覆盖消息）
     */
    public BusinessException(ResultCode resultCode, String message) {
        this(resultCode.getCode(), message);
    }
}