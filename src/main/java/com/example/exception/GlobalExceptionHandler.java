package com.example.exception;

import com.example.common.Result;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 全局异常处理器
 * 统一处理Controller层抛出的异常
 */
@ControllerAdvice(basePackages = "com.example.controller") // 明确包路径写法，更规范
public class GlobalExceptionHandler {
    private static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    /**
     * 处理自定义业务异常（优先级最高）
     */
    @ExceptionHandler(BusinessException.class)
    @ResponseBody
    public Result<Void> handleBusinessException(BusinessException e) {
        // 业务异常通常是预期内的，日志级别用warn即可（避免error日志刷屏）
        log.warn("业务异常：{}({})", e.getMessage(), e.getCode());
        return Result.error(e); // 直接复用异常转结果的方法
    }

    /**
     * 处理系统异常（非预期异常）
     */
    @ExceptionHandler(Exception.class)
    @ResponseBody
    public Result<Void> handleSystemException(Exception e) {
        // 系统异常是预期外的，用error级别并打印堆栈，便于排查
        log.error("系统异常：", e); // 注意日志格式，异常对象放最后自动打印堆栈
        // 生产环境避免返回具体异常信息（如NullPointerException），防止泄露敏感信息
        return Result.error("系统繁忙，请稍后再试");
    }

    // 可根据需要新增其他异常处理器，如：
    // @ExceptionHandler(NullPointerException.class) 处理空指针
    // @ExceptionHandler(IllegalArgumentException.class) 处理参数非法
}