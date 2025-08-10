package com.example.controller; // 补充包声明

import com.example.entity.Admin;
import com.example.service.AdminService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import com.example.common.Result;

@RestController
@RequestMapping("/admin")
public class AdminController {

    @Resource
    AdminService adminService;

    @PostMapping("/add")
    public Result add(@RequestBody Admin admin) {//@RequestBody 接受前端的json参数
        adminService.add(admin);
        return Result.success();
    }

    @DeleteMapping("/delete/{id}")
    public Result update(@PathVariable Integer id) {//@PathVariable 接受前端传来的路径参数
        adminService.deleteById(id);
        return Result.success();
    }

    @PutMapping("/update")
    public Result update(@RequestBody Admin admin) {//@RequestBody 接受前端的json参数
        adminService.update(admin);
        return Result.success();
    }

    /**查询管理员表*/
    @GetMapping("/selectAll")
    public Result selectAll() {
        List<Admin> adminList = adminService.selectAll();
        return Result.success(adminList);
    }

    /**分页查询
     *
     * @param pageNum：当前页码
     * @param pageSize：每页个数
     */
    @GetMapping("/selectPage")
    public Result selectPage(@RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize,
                             @RequestParam(required = false)Admin admin) {
        // 假设 adminService.selectPage 返回分页结果对象（含数据、总条数等）
        Object pageResult = adminService.selectPage(pageNum, pageSize,admin);
        return Result.success(pageResult); // 传入分页数据返回
    }
}