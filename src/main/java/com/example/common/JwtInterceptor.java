package com.example.common;

import cn.hutool.core.util.StrUtil;
import com.example.entity.Account;
import com.example.service.AdminService;
import com.example.service.UserService;
import com.example.utils.TokenUtils;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.jetbrains.annotations.NotNull;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

/**
 * JWT令牌拦截器（适配网页登录场景，使用Jackson返回JSON，无需Fastjson2）
 */
@Component
public class JwtInterceptor implements HandlerInterceptor {

    @Resource
    private AdminService adminService;
    @Resource
    private UserService userService;
    @Resource
    private TokenUtils tokenUtils;

    // 初始化Jackson的ObjectMapper（Spring Boot内置，无需额外依赖）
    private final ObjectMapper objectMapper = new ObjectMapper();

    /**
     * 请求处理前验证JWT令牌
     */
    @Override
    public boolean preHandle(@NotNull HttpServletRequest request, @NotNull HttpServletResponse response, @NotNull Object handler) {
        // 1. 获取Token（优先请求头，其次请求参数）
        String token = getTokenFromRequest(request);
        if (StrUtil.isBlank(token)) {
            // 返回401 JSON，前端捕获后跳登录页
            returnJson(response, 401, "未登录，请先登录");
            return false;
        }

        try {
            // 2. 解析Token中的用户ID和角色
            String[] tokenData = tokenUtils.parseTokenData(token);
            Integer userId = parseUserId(tokenData[0]);
            String role = tokenData[1];

            // 3. 根据角色查询用户
            Account account = getAccountByRole(userId, role);
            if (account == null) {
                returnJson(response, 401, "用户信息不存在");
                return false;
            }

            // 4. 验证Token签名和过期时间
            tokenUtils.verifyTokenSignature(token);

            // 5. 将用户信息存入请求，供业务层直接获取
            request.setAttribute("currentAccount", account);
            return true;

        } catch (Exception e) {
            // 细分异常提示，方便前端处理
            String msg = e.getMessage().contains("过期") ? "登录已过期，请重新登录" : "Token验证失败：" + e.getMessage();
            returnJson(response, 401, msg);
            return false;
        }
    }

    /**
     * 从请求中获取Token
     */
    private String getTokenFromRequest(HttpServletRequest request) {
        String token = request.getHeader("token");
        if (StrUtil.isEmpty(token)) {
            token = request.getParameter("token");
        }
        return token;
    }

    /**
     * 转换用户ID为Integer
     */
    private Integer parseUserId(String userIdStr) {
        if (StrUtil.isBlank(userIdStr)) {
            throw new RuntimeException("用户ID为空");
        }
        try {
            return Integer.parseInt(userIdStr);
        } catch (NumberFormatException e) {
            throw new RuntimeException("用户ID格式错误");
        }
    }

    /**
     * 根据角色查询对应用户
     */
    private Account getAccountByRole(Integer userId, String role) {
        if ("admin".equals(role)) {
            return adminService.selectById(userId);
        } else if ("user".equals(role)) {
            return userService.selectById(userId);
        } else {
            throw new RuntimeException("无效的角色类型：" + role);
        }
    }

    /**
     * 核心修改：使用Jackson返回JSON格式响应（替代Fastjson2）
     */
    private void returnJson(HttpServletResponse response, int code, String msg) {
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
        response.setCharacterEncoding("UTF-8");
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401状态码
        try (PrintWriter writer = response.getWriter()) {
            // 构建返回结果
            Map<String, Object> result = new HashMap<>();
            result.put("code", code);
            result.put("msg", msg);
            // 使用Jackson将Map转为JSON字符串（Spring Boot内置，无需额外依赖）
            writer.write(objectMapper.writeValueAsString(result));
            writer.flush();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}