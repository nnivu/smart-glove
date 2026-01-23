package com.example.controller;

import cn.hutool.core.util.StrUtil;
import com.example.common.Result;
import com.example.entity.Account;
import com.example.entity.User;
import com.example.service.AdminService;
import com.example.service.UserService;
import com.example.utils.TokenUtils;
import jakarta.annotation.Resource;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

/**
 * 登录/注册控制器（适配JWT逻辑）
 */
@RestController
public class WebController {
    @Resource
    UserService userService;
    @Resource
    AdminService adminService;
    @Resource
    TokenUtils tokenUtils; // 注入JWT工具类

    @GetMapping("/hello")
    public Result hello() {
        return Result.success("hello");
    }

    /**
     * 登录接口（生成JWT Token，适配管理员/普通用户）
     */
    @PostMapping("/login")
    public Result login(@RequestBody Account account) {
        // 1. 参数校验
        if (StrUtil.isBlank(account.getUsername()) || StrUtil.isBlank(account.getPassword()) || StrUtil.isBlank(account.getRole())) {
            return Result.error("400", "用户名、密码、角色不能为空");
        }

        // 2. 验证账号密码（管理员/普通用户）
        Account dbAccount = null;
        if ("admin".equals(account.getRole())) {
            dbAccount = adminService.login(account);
        } else if ("user".equals(account.getRole())) {
            dbAccount = userService.login(account);
        } else {
            return Result.error("400", "无效的角色类型，仅支持admin/user");
        }

        // 3. 验证失败返回错误
        if (dbAccount == null) {
            return Result.error("401", "用户名或密码错误");
        }

        // 4. 登录成功：生成JWT Token（用户ID+角色）
        String token = tokenUtils.createToken(dbAccount.getId().toString(), account.getRole());

        // 5. 返回Token和用户信息（前端存储Token）
        return Result.success("登录成功", new LoginResponse(dbAccount, token));
    }

    /**
     * 普通用户注册接口（密码BCrypt加密存储）
     */
    @PostMapping("/register")
    public Result register(@RequestBody User user) {
        // 1. 参数校验
        if (StrUtil.isBlank(user.getUsername()) || StrUtil.isBlank(user.getPassword())) {
            return Result.error("400", "用户名、密码不能为空");
        }

        // 2. 检查用户名是否已存在（避免重复注册）
        User existingUser = userService.selectByUsername(user.getUsername());
        if (existingUser != null) {
            return Result.error("400", "用户名已存在，请更换");
        }

        // 3. 密码BCrypt加密（核心！禁止明文存储）
        String encryptPwd = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(encryptPwd); // 替换为加密后的密码

        // 4. 执行注册
        userService.register(user);

        // 5. 返回注册成功结果
        return Result.success("注册成功，请登录");
    }

    /**
     * 登录响应实体（封装用户信息+Token）
     */
    public static class LoginResponse {
        private Account userInfo; // 用户基本信息（不含密码）
        private String token;     // JWT Token

        public LoginResponse(Account userInfo, String token) {
            // 清空密码，避免敏感信息返回前端
            userInfo.setPassword(null);
            this.userInfo = userInfo;
            this.token = token;
        }

        // getter/setter（必须添加，否则JSON序列化失败）
        public Account getUserInfo() {
            return userInfo;
        }

        public void setUserInfo(Account userInfo) {
            this.userInfo = userInfo;
        }

        public String getToken() {
            return token;
        }

        public void setToken(String token) {
            this.token = token;
        }
    }
}