package com.example.common;

import com.example.exception.BusinessException;
import lombok.Getter;
import lombok.NoArgsConstructor;

/**
 * 统一接口返回结果
 */
@Getter
@NoArgsConstructor // 仅保留必要的无参构造（JSON序列化可能需要）
public class Result<T> { // 泛型化，支持编译期类型检查
    private String code;       // 状态码（200成功，其他失败）
    private T data;            // 数据（泛型，明确返回数据类型）
    private String message;    // 提示信息

    // 私有构造：禁止外部直接创建，统一通过静态方法
    private Result(String code, T data, String message) {
        this.code = code;
        this.data = data;
        this.message = message;
    }

    /**
     * 成功：无数据返回
     */
    public static Result<Void> success() {
        return new Result<>("200", null, "操作成功");
    }

    /**
     * 成功：带数据返回
     */
    public static <T> Result<T> success(T data) {
        return new Result<>("200", data, "操作成功");
    }

    /**
     * 成功：自定义提示信息
     */
    public static <T> Result<T> success(T data, String message) {
        return new Result<>("200", data, message);
    }

    /**
     * 失败：默认系统异常（500）
     */
    public static Result<Void> error(String message) {
        return new Result<>("500", null, message);
    }

    /**
     * 失败：自定义异常码和信息
     */
    public static Result<Void> error(String code, String message) {
        return new Result<>(code, null, message);
    }

    /**
     * 从自定义异常构建失败结果
     */
    public static Result<Void> error(BusinessException e) {
        return new Result<>(e.getCode(), null, e.getMessage());
    }

}