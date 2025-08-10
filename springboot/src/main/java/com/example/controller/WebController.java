package com.example.controller;

import com.example.common.Result;
import com.example.entity.Admin;
import com.example.service.AdminService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class WebController {

    //  表示这是一个 get请求的接口

    @Resource
    AdminService adminService;

    //  表示这是一个 get请求的接口
    @GetMapping("/hello") // 接口的路径，全局唯一的
    public Result hello() {
        return Result.success("hello"); // 接口的返回值
    }

    @GetMapping("/admin")
    public Result admin(String name) {
        String admin = adminService.admin(name);
        return Result.success(admin);
    }
}
