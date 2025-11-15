package com.example.service;

import com.example.dto.request.TimeRangeRequest;
import com.example.dto.response.*;
import java.util.List;

/**
 * 姿态训练服务接口
 */
public interface PostureTrainingService {
    /**
     * 获取最新姿态训练数据
     */
    TrainingDataResponse getLatestTrainingData();

    /**
     * 获取实时关键点数据
     */
    List<KeyPointResponse> getRealtimeKeyPoints();

    /**
     * 获取AI分析结果
     */
    AIAnalysisResponse getAIAnalysis();

    /**
     * 获取训练统计数据
     */
    TrainingStatsResponse getTrainingStats(TimeRangeRequest request);

    /**
     * 生成实时趋势数据（模拟AI计算）
     */
    List<Double> generateRealtimeTrend();
}