package com.example.common;

import cn.hutool.core.util.StrUtil;
import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTDecodeException;
import com.example.entity.Account;
import com.example.exception.BusinessException;
import com.example.service.AdminService;
import com.example.service.UserService;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.jetbrains.annotations.NotNull;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

/**
 * JWT令牌拦截器，用于验证请求中的令牌合法性
 */
@Component
public class JwtInterceptor implements HandlerInterceptor {

    @Resource
    private AdminService adminService;

    @Resource
    private UserService userService;

    /**
     * 请求处理前验证JWT令牌
     */
    @Override
    public boolean preHandle(@NotNull HttpServletRequest request, @NotNull HttpServletResponse response, @NotNull Object handler) {
        // 1. 获取令牌（优先从请求头，其次从请求参数）
        String token = getTokenFromRequest(request);
        if (StrUtil.isBlank(token)) {
            throw new BusinessException("401", "令牌不存在，拒绝访问");
        }

        // 2. 解析令牌并验证用户信息
        Account account = verifyTokenAndGetAccount(token);
        if (account == null) {
            throw new BusinessException("401", "用户信息不存在，拒绝访问");
        }

        // 3. 验证令牌签名
        verifyTokenSignature(token, account.getPassword());

        // 4. 将用户信息存入请求属性，供后续控制器使用
        request.setAttribute("currentAccount", account);
        return true;
    }

    /**
     * 从请求中获取令牌（请求头优先，其次请求参数）
     */
    private String getTokenFromRequest(HttpServletRequest request) {
        String token = request.getHeader("token");
        if (StrUtil.isEmpty(token)) {
            token = request.getParameter("token");
        }
        return token;
    }

    /**
     * 解析令牌并获取对应的用户账户
     */
    private Account verifyTokenAndGetAccount(String token) {
        try {
            // 解析令牌载荷（audience中存储格式：userId-role）
            String audience = JWT.decode(token).getAudience().getFirst();
            if (StrUtil.isBlank(audience) || !audience.contains("-")) {
                throw new BusinessException("401", "令牌格式错误");
            }

            String[] split = audience.split("-", 2); // 限制拆分次数，避免角色中包含"-"
            String userIdStr = split[0];
            String role = split[1];

            // 转换userId为Integer（若实际业务为String，可删除此步直接使用）
            Integer userId = parseUserId(userIdStr);

            // 根据角色查询对应账户
            return getAccountByRole(userId, role);

        } catch (JWTDecodeException e) {
            throw new BusinessException("401", "令牌解析失败");
        } catch (NumberFormatException e) {
            throw new BusinessException("401", "用户ID格式错误");
        } catch (BusinessException e) {
            throw e; // 抛出已定义的业务异常
        } catch (Exception e) {
            throw new BusinessException("401", "令牌验证失败");
        }
    }

    /**
     * 将用户ID字符串转换为Integer（若ID为字符串类型，可删除此方法）
     */
    private Integer parseUserId(String userIdStr) {
        if (StrUtil.isBlank(userIdStr)) {
            throw new BusinessException("401", "用户ID为空");
        }
        return Integer.parseInt(userIdStr);
    }

    /**
     * 根据角色查询对应的用户账户
     */
    private Account getAccountByRole(Integer userId, String role) {
        if ("ADMIN".equals(role)) {
            return adminService.selectById(userId);
        } else if ("USER".equals(role)) {
            return userService.selectById(userId);
        } else {
            throw new BusinessException("401", "无效的角色类型");
        }
    }

    /**
     * 验证令牌签名是否有效
     */
    private void verifyTokenSignature(String token, String secret) {
        try {
            Algorithm algorithm = Algorithm.HMAC256(secret);
            JWTVerifier verifier = JWT.require(algorithm).build();
            verifier.verify(token); // 验证签名和过期时间等
        } catch (Exception e) {
            throw new BusinessException("401", "令牌签名无效或已过期");
        }
    }
}