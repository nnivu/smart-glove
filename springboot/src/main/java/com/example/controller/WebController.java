package com.example.controller;

import com.example.common.Result;
import com.example.entity.Account;
import com.example.entity.User;
import com.example.service.AdminService;
import com.example.service.UserService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class WebController {
    @Resource
    UserService userService;
    @Resource
    AdminService adminService;

    @GetMapping("/hello")
    public Result hello() {
        return Result.success("hello");
    }

    @PostMapping("/login")//登录
    public Result login(@RequestBody Account account) {
        Account dbAccount = null;
        if ("admin".equals(account.getRole())) {
            dbAccount = adminService.login(account);
        } else if ("user".equals(account.getRole())) {
            dbAccount = userService.login(account);
        }

        return Result.success(dbAccount);

    }

    @PostMapping("/register")//普通用户注册
    public Result register(@RequestBody User user) {
        userService.register(user);
        return Result.success();
    }
}
