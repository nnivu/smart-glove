package com.example.entity;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * Deepseek AI配置属性类
 * 用于读取配置文件中deepseek前缀的配置项
 */
@Setter
@Getter
@Component
@ConfigurationProperties(prefix = "deepseek")
public class Deepseek {
    // Getter和Setter方法
    private String apiKey;
    private String apiUrl;
    private String model;

    // 与其他实体类保持一致的toString方法
    @Override
    public String toString() {
        return "Deepseek{" +
                "apiKey='***'" +  // 脱敏处理，保护密钥
                ", apiUrl='" + apiUrl + '\'' +
                ", model='" + model + '\'' +
                '}';
    }
}
