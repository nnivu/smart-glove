package com.example.controller;

import com.example.common.Result;
import com.example.entity.Accident;
import com.example.service.AccidentService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

@RestController
@RequestMapping("/accident") // 事故业务接口根路径
public class AccidentController {

    @Resource
    private AccidentService accidentService;

    /**
     * 上传（新增）事故数据
     * @param accident 前端传递的事故信息（JSON格式）
     */
    @PostMapping("/add")
    public Result addAccident(@RequestBody Accident accident) {
        // 补充基础字段（如创建时间，也可由前端传递）
        if (accident.getCreateTime() == null) {
            accident.setCreateTime(new Date());
        }
        // 调用Service层新增方法
        boolean success = accidentService.saveAccident(accident);
        return success ? Result.success("事故数据上传成功") : Result.error("事故数据上传失败");
    }

    /**
     * 修改已有事故数据
     * @param accident 包含id和修改信息的事故对象
     */
    @PostMapping("/update")
    public Result updateAccident(@RequestBody Accident accident) {
        // 校验id是否存在（id是修改的唯一标识）
        if (accident.getId() == null) {
            return Result.error("事故ID不能为空，无法修改");
        }
        boolean success = accidentService.updateAccident(accident);
        return success ? Result.success("事故数据更新成功") : Result.error("事故数据更新失败或数据未变化");
    }

    /**
     * 根据ID删除事故数据（可选，用于数据清理）
     * @param id 事故ID
     */
    @GetMapping("/delete/{id}")
    public Result deleteAccident(@PathVariable Long id) {
        boolean success = accidentService.deleteAccidentById(id);
        return success ? Result.success("事故数据删除成功") : Result.error("事故数据不存在或删除失败");
    }
}