/*package com.example.controller;

import com.example.common.Result;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/echarts")//图表
public class EchartsController {

    // 注入 CategoryService，用于操作分类相关数据
    @Resource
    public CategoryService categoryService;
    // 注入 IntroductionService，用于操作帖子（Introduction）相关数据
    @Resource
    public IntroductionService introductionService;

    @Resource
    public Userservice userservice;

    @RequestMapping("/pie")//饼图
    public Result pie() {
        // 用于存储最终要返回的饼图数据（每个分类及对应帖子数量的 Map 集合）
        List<Map<String, Object>> list = new ArrayList<>();

        // 1. 查询所有分类信息
        List<Category> categories = categoryService.selectAll(new Category());
        // 2. 查询所有帖子信息
        List<Introduction> introductions = introductionService.selectAll(new Introduction());

        // 遍历每个分类，统计该分类下帖子数量
        for (Category category : categories) {
            // 使用 Stream 流过滤出帖子分类 ID 与当前分类 ID 匹配的帖子，并统计数量
            long count = introductions.stream()
                    .filter(x -> category.getId().equals(x.getCategoryId()))
                    .count();

            // 创建 Map 存储分类名称和对应帖子数量，用于给 ECharts 饼图提供数据
            Map<String, Object> map = new HashMap<>();
            // 放入分类名称
            map.put("name", category.getTitle());
            // 放入该分类下帖子数量
            map.put("value", count);
            // 将当前分类的数据 Map 加入结果集合
            list.add(map);
        }
        // 返回包含饼图数据的成功响应
        return Result.success(list);
    }

    @GetMapping("/bar")//柱状图
    public Result bar() {
        // 存储最终返回给前端的结果，包含 x 轴（用户名）、y 轴（发帖数）数据
        Map<String, Object> resultMap = new HashMap<>();
        // x 轴数据：存储用户名
        List<String> xList = new ArrayList<>();
        // y 轴数据：存储每个用户对应的发帖数量
        List<Long> yList = new ArrayList<>();

        // 1. 查询数据：从 userService 获取全量用户信息
        List<User> users = userService.selectAll(new User());
        // 从 introductionService 获取全量帖子信息
        List<Introduction> introductions = introductionService.selectAll(new Introduction());

        // 2. 遍历用户，统计每个用户发帖数量
        for (User user : users) {
            // 用 Stream 流过滤出「帖子用户 ID = 当前用户 ID」的帖子，统计数量
            long count = introductions.stream()
                    .filter(x -> user.getId().equals(x.getUserId()))
                    .count();

            // 将用户名加入 x 轴数据
            xList.add(user.getName());
            // 将该用户发帖数加入 y 轴数据
            yList.add(count);
        }

        // 3. 组装结果：把 x、y 轴数据放入 resultMap，方便前端解析
        resultMap.put("xAxis", xList);
        resultMap.put("yAxis", yList);

        // 返回成功响应，携带组装好的数据
        return Result.success(resultMap);
    }

    @GetMapping("/line")//折线图
    public Result line() {
        // 用于存储最终返回结果的 Map，包含 x 轴和 y 轴数据
        Map<String, Object> resultMap = new HashMap<>();
        // 用于存储 y 轴数据（统计每天的帖子数量）
        List<Long> yList = new ArrayList<>();

        // 获取当前日期
        Date today = new Date();
        // 计算起始日期，为当前日期往前推 7 天（offset: -7 表示向前偏移 7 天 ）
        DateTime start = DateUtil.offsetDay(today, -7);
        // 生成从 start 到 today 的日期列表，按年中的天数（DAY_OF_YEAR）为间隔，
        // 并将日期格式化为字符串，最终转换为 List<String> ，作为 x 轴数据（日期）
        List<String> xList = DateUtil.rangeToList(start, today, DateField.DAY_OF_YEAR)
                .stream()
                .map(DateUtil::formatDate)
                .toList();

        // 从 introductionService 获取所有帖子信息（Introduction 实体列表 ）
        List<Introduction> introductions = introductionService.selectAll(new Introduction());

        // 遍历 xList 中的每个日期（day）
        for (String day : xList) {
            // 统计 introductions 中满足条件的帖子数量：
            // 1. x.getTime() 不为空（ObjectUtil.isNotEmpty 做非空校验 ）
            // 2. x.getTime() 包含当前遍历的日期 day（这里可能存在类型不匹配问题，后续说明 ）
            long count = introductions.stream()
                    .filter(x -> ObjectUtil.isNotEmpty(x.getTime()) && x.getTime().contains(day))
                    .count();
            // 将统计的数量添加到 yList 中
            yList.add(count);
        }

        // 将 x 轴数据（日期列表）放入 resultMap
        resultMap.put("xAxis", xList);
        // 将 y 轴数据（每日帖子数量列表）放入 resultMap
        resultMap.put("yAxis", yList);
        // 返回包含统计结果的成功响应
        return Result.success(resultMap);
    }

}*/