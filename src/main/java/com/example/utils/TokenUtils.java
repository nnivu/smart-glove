package com.example.utils;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTDecodeException;
import com.auth0.jwt.exceptions.TokenExpiredException;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.example.entity.Account;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.util.Date;
import java.util.Objects;

/**
 * JWT令牌工具类（适配登录场景，包含生成、解析、验证、获取当前用户）
 */
@Component
public class TokenUtils {

    // 从配置文件读取固定秘钥（生产环境建议32位以上随机字符串）
    @Value("${jwt.secret:your-32bit-secure-secret-key-888888}")
    private String jwtSecret;

    // Token过期时间（秒），默认1天
    @Value("${jwt.expire-time:86400}")
    private long expireTime;

    /**
     * 生成JWT Token（核心方法，适配admin/user角色）
     * @param userId 用户ID（字符串类型，兼容Integer/Long）
     * @param role 角色（admin/user）
     * @return 有效Token字符串
     */
    public String createToken(String userId, String role) {
        if (StrUtil.isBlank(userId) || StrUtil.isBlank(role)) {
            throw new IllegalArgumentException("用户ID和角色不能为空");
        }
        // 设置过期时间
        Date expireDate = DateUtil.offsetSecond(new Date(), (int) expireTime);
        // 构建Token：自定义Claim存储业务数据，固定秘钥签名
        return JWT.create()
                .withClaim("userId", userId)       // 自定义字段：用户ID
                .withClaim("role", role)           // 自定义字段：角色
                .withExpiresAt(expireDate)         // 过期时间
                .withIssuedAt(new Date())          // 签发时间
                .sign(Algorithm.HMAC256(jwtSecret)); // 固定秘钥签名
    }

    /**
     * 解析Token中的用户ID和角色（仅解析，不验证签名）
     * @param token JWT Token
     * @return 数组：[0]用户ID，[1]角色
     */
    public String[] parseTokenData(String token) {
        try {
            if (StrUtil.isBlank(token)) {
                throw new JWTDecodeException("Token不能为空");
            }
            DecodedJWT decodedJWT = JWT.decode(token);
            // 解析自定义字段
            String userId = decodedJWT.getClaim("userId").asString();
            String role = decodedJWT.getClaim("role").asString();
            // 校验必要字段
            if (StrUtil.isBlank(userId) || StrUtil.isBlank(role)) {
                throw new JWTDecodeException("Token缺少用户ID或角色信息");
            }
            return new String[]{userId, role};
        } catch (JWTDecodeException e) {
            throw new RuntimeException("Token解析失败：" + e.getMessage());
        }
    }

    /**
     * 验证Token签名和过期时间（核心验证逻辑）
     * @param token JWT Token
     */
    public void verifyTokenSignature(String token) {
        try {
            Algorithm algorithm = Algorithm.HMAC256(jwtSecret);
            JWTVerifier verifier = JWT.require(algorithm)
                    .acceptExpiresAt(0) // 严格验证过期时间（不允许过期）
                    .build();
            verifier.verify(token); // 验证签名+过期时间+格式
        } catch (TokenExpiredException e) {
            throw new RuntimeException("Token已过期，请重新登录");
        } catch (Exception e) {
            throw new RuntimeException("Token签名无效：" + e.getMessage());
        }
    }

    /**
     * 获取当前登录用户（从请求中获取拦截器存入的用户信息，避免重复查库）
     * @return 当前登录的Account对象
     */
    public static Account getCurrentUser() {
        try {
            // 获取当前请求
            HttpServletRequest request = ((ServletRequestAttributes) Objects.requireNonNull(RequestContextHolder.getRequestAttributes())).getRequest();
            // 获取拦截器存入的用户信息
            Account currentAccount = (Account) request.getAttribute("currentAccount");
            if (currentAccount == null) {
                throw new RuntimeException("当前未登录");
            }
            return currentAccount;
        } catch (Exception e) {
            throw new RuntimeException("获取当前用户失败：" + e.getMessage());
        }
    }
}