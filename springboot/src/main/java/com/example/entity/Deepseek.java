package com.example.entity;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * Deepseek AI配置属性类
 * 用于读取配置文件中deepseek前缀的配置项
 */
@Component
@ConfigurationProperties(prefix = "deepseek")
public class Deepseek {
    private String apiKey;
    private String apiUrl;
    private String model;

    // Getter和Setter方法
    public String getApiKey() {
        return apiKey;
    }

    public void setApiKey(String apiKey) {
        this.apiKey = apiKey;
    }

    public String getApiUrl() {
        return apiUrl;
    }

    public void setApiUrl(String apiUrl) {
        this.apiUrl = apiUrl;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

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
