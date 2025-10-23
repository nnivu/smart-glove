package com.example.exception;

import lombok.Getter;

/**
 * 自定义业务异常
 * 继承RuntimeException，避免事务中需要手动捕获
 */
@Getter
public class BusinessException extends RuntimeException { // 类名更清晰：BusinessException（业务异常）
    private final String code; // 异常码（建议用final，避免后续修改）
    private final String message; // 异常信息（复用父类message字段，减少冗余）

    /**
     * 全参构造：指定异常码和信息
     */
    public BusinessException(String code, String message) {
        super(message); // 父类存储message，便于日志打印时获取
        this.code = code;
        this.message = message;
    }

    /**
     * 简化构造：默认异常码（如500）+ 自定义信息
     */
    public BusinessException(String message) {
        this("500", message); // 复用全参构造，减少代码冗余
    }

    // 移除无参构造：避免创建无意义的空异常（强制必须传入信息）
}