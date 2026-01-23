package com.example.common;

import jakarta.annotation.Resource;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * Web配置类：注册JWT拦截器，配置拦截/放行规则
 */
@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Resource
    private JwtInterceptor jwtInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(jwtInterceptor)
                // 拦截所有请求
                .addPathPatterns("/**")
                // 放行的接口（登录/注册/静态资源）
                .excludePathPatterns(
                        "/login",          // 登录接口
                        "/register",       // 注册接口
                        "/login.html",     // 登录页面
                        "/register.html",  // 注册页面
                        "/static/**",      // 静态资源（css/js/img）
                        "/error",          // 错误页面
                        "/hello"           // 测试接口（可选放行）
                );
    }
}