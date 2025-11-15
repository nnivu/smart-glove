package com.example.controller;

import com.example.common.Result;
import com.example.dto.request.TimeRangeRequest;
import com.example.dto.response.*;
import com.example.service.PostureTrainingService;
import jakarta.annotation.Resource;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import java.util.List;

/**
 * 姿态训练控制层（接口暴露）
 */
@RestController
@RequestMapping("/api/posture")
public class PostureTrainingController {

    @Resource
    private PostureTrainingService postureTrainingService;

    /**
     * 获取最新姿态训练数据
     */
    @GetMapping("/training")
    public Result<TrainingDataResponse> getTrainingData() {
        TrainingDataResponse data = postureTrainingService.getLatestTrainingData();
        return Result.success(data);
    }

    /**
     * 获取实时关键点数据
     */
    @GetMapping("/keypoints")
    public Result<List<KeyPointResponse>> getKeyPoints() {
        List<KeyPointResponse> keyPoints = postureTrainingService.getRealtimeKeyPoints();
        return Result.success(keyPoints);
    }

    /**
     * 获取AI分析结果
     */
    @GetMapping("/ai-analysis")
    public Result<AIAnalysisResponse> getAIAnalysis() {
        AIAnalysisResponse analysis = postureTrainingService.getAIAnalysis();
        return Result.success(analysis);
    }

    /**
     * 获取训练统计数据
     * @param request 时间范围请求参数（默认week）
     */
    @GetMapping("/training-stats")
    public Result<TrainingStatsResponse> getTrainingStats(
            @Validated TimeRangeRequest request
    ) {
        TrainingStatsResponse stats = postureTrainingService.getTrainingStats(request);
        return Result.success(stats);
    }

    /**
     * 模拟开始监控（实际可对接硬件启动数据采集）
     */
    @PostMapping("/start-monitor")
    public Result<Void> startMonitor() {
        // 实际逻辑：调用硬件SDK启动姿态采集、关键点检测等
        System.out.println("开始实时监控姿态数据...");
        return Result.success();
    }

    /**
     * 模拟重置训练（实际可清空当前训练数据）
     */
    @PostMapping("/reset-training")
    public Result<Void> resetTraining() {
        // 实际逻辑：删除当前训练临时数据、重置设备状态等
        System.out.println("重置当前训练数据...");
        return Result.success();
    }

    /**
     * 模拟导出数据（实际可生成Excel/PDF文件）
     */
    @GetMapping("/export-data")
    public Result<String> exportData() {
        // 实际逻辑：查询训练数据、生成文件、返回下载地址
        String downloadUrl = "/download/training-data-202410.xlsx";
        return Result.success(downloadUrl);
    }
}