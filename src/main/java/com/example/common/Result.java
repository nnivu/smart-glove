package com.example.common;

import com.example.exception.BusinessException;
import com.example.common.ResultCode;
import lombok.Getter;
import lombok.NoArgsConstructor;

/**
 * 统一接口返回结果
 */
@Getter
@NoArgsConstructor
public class Result<T> {
    private String code;       // 状态码（关联ResultCode枚举）
    private T data;            // 泛型数据，明确返回类型
    private String message;    // 提示信息

    // 私有构造，强制通过静态方法创建
    private Result(String code, T data, String message) {
        this.code = code;
        this.data = data;
        this.message = message;
    }

    /**
     * 成功：无数据返回
     */
    public static Result<Void> success() {
        return new Result<>(ResultCode.SUCCESS.getCode(), null, ResultCode.SUCCESS.getMsg());
    }

    /**
     * 成功：带数据返回
     */
    public static <T> Result<T> success(T data) {
        return new Result<>(ResultCode.SUCCESS.getCode(), data, ResultCode.SUCCESS.getMsg());
    }

    /**
     * 成功：自定义提示信息
     */
    public static <T> Result<T> success(T data, String message) {
        return new Result<>(ResultCode.SUCCESS.getCode(), data, message);
    }

    /**
     * 失败：默认系统异常（500）
     */
    public static Result<Void> error(String message) {
        return new Result<>(ResultCode.FAIL.getCode(), null, message);
    }

    /**
     * 失败：自定义异常码和信息
     */
    public static Result<Void> error(String code, String message) {
        return new Result<>(code, null, message);
    }

    /**
     * 从自定义业务异常构建失败结果
     */
    public static Result<Void> error(BusinessException e) {
        return new Result<>(e.getCode(), null, e.getMessage());
    }

    /**
     * 从状态码枚举构建结果
     */
    public static Result<Void> fromCode(ResultCode code) {
        return new Result<>(code.getCode(), null, code.getMsg());
    }
}