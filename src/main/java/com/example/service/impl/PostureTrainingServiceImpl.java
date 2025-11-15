package com.example.service.impl;

import com.example.common.ResultCode;
import com.example.common.util.DateUtil;
import com.example.dto.request.TimeRangeRequest;
import com.example.dto.response.AIAnalysisResponse;
import com.example.dto.response.KeyPointResponse;
import com.example.dto.response.TrainingDataResponse;
import com.example.dto.response.TrainingStatsResponse;
import com.example.entity.*;
import com.example.exception.BusinessException;
import com.example.mapper.*;
import com.example.service.PostureTrainingService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

/**
 * 姿态训练服务实现
 */
@Service
public class PostureTrainingServiceImpl implements PostureTrainingService {

    @Resource
    private PostureTrainingMapper postureTrainingMapper;

    @Resource
    private KeyPointMapper keyPointMapper;

    @Resource
    private StandardPostureMapper standardPostureMapper;

    @Resource
    private PostureComparisonMapper postureComparisonMapper;

    @Resource
    private TrainingStatsMapper trainingStatsMapper;

    /**
     * 获取最新姿态训练数据
     */
    @Override
    public TrainingDataResponse getLatestTrainingData() {
        PostureTraining latestTraining = postureTrainingMapper.selectLatestTraining();
        if (latestTraining == null) {
            // 调用“ResultCode枚举”构造方法
            throw new BusinessException(ResultCode.DATA_NOT_FOUND);
        }

        List<StandardPosture> standardPostures = standardPostureMapper.selectAll();
        List<PostureComparison> comparisons = postureComparisonMapper.selectByTrainingId(latestTraining.getId());
        List<Double> realtimeTrend = generateRealtimeTrend();

        TrainingDataResponse response = new TrainingDataResponse();
        response.setDataset("200K");
        response.setScore(latestTraining.getScore());
        response.setRiskLevel(latestTraining.getRiskLevel());
        response.setProgress(latestTraining.getProgress());
        response.setDeviceStatus(latestTraining.getDeviceStatus());

        TrainingDataResponse.RealtimeParams realtimeParams = new TrainingDataResponse.RealtimeParams();
        realtimeParams.setArmAngle(latestTraining.getArmAngle());
        realtimeParams.setWristPosition(latestTraining.getWristPosition());
        realtimeParams.setBodyPosture(latestTraining.getBodyPosture());
        realtimeParams.setSprayDistance(latestTraining.getSprayDistance());
        realtimeParams.setSprayAngle(latestTraining.getSprayAngle());
        realtimeParams.setPressure(latestTraining.getPressure());
        response.setRealtimeParams(realtimeParams);

        List<TrainingDataResponse.StandardPostureResponse> standardRespList = standardPostures.stream()
                .map(sp -> {
                    TrainingDataResponse.StandardPostureResponse resp = new TrainingDataResponse.StandardPostureResponse();
                    resp.setName(sp.getName());
                    resp.setDescription(sp.getDescription());
                    resp.setImageUrl(sp.getImageUrl());
                    return resp;
                })
                .collect(Collectors.toList());
        response.setStandardPostures(standardRespList);

        List<TrainingDataResponse.PostureComparisonResponse> comparisonRespList = comparisons.stream()
                .map(cmp -> {
                    TrainingDataResponse.PostureComparisonResponse resp = new TrainingDataResponse.PostureComparisonResponse();
                    resp.setItemName(cmp.getItemName());
                    resp.setUserValue(cmp.getUserValue());
                    resp.setStandardValue(cmp.getStandardValue());
                    return resp;
                })
                .collect(Collectors.toList());
        response.setPostureComparisons(comparisonRespList);

        response.setRealtimeTrend(realtimeTrend);
        return response;
    }

    /**
     * 获取实时关键点数据
     */
    @Override
    public List<KeyPointResponse> getRealtimeKeyPoints() {
        List<KeyPoint> keyPoints = keyPointMapper.selectLatestKeyPoints();
        if (CollectionUtils.isEmpty(keyPoints)) {
            // 调用“ResultCode枚举 + 自定义消息”构造方法
            throw new BusinessException(ResultCode.DATA_NOT_FOUND, "暂无关键点数据");
        }

        return keyPoints.stream()
                .map(kp -> {
                    KeyPointResponse resp = new KeyPointResponse();
                    resp.setName(kp.getName());
                    resp.setX(kp.getX());
                    resp.setY(kp.getY());
                    resp.setStatus(kp.getStatus());
                    return resp;
                })
                .collect(Collectors.toList());
    }

    /**
     * 获取AI分析结果
     */
    @Override
    public AIAnalysisResponse getAIAnalysis() {
        AIAnalysisResponse response = new AIAnalysisResponse();

        List<String> humanAnalysis = new ArrayList<>();
        humanAnalysis.add("手臂角度过度弯曲（需调整至30°-45°）");
        humanAnalysis.add("身体姿态偏移（建议保持直立）");
        humanAnalysis.add("肩部不平衡（左肩高于右肩5cm）");
        response.setHumanAnalysis(humanAnalysis);

        List<String> deviceAnalysis = new ArrayList<>();
        deviceAnalysis.add("喷涂距离过近（建议2.5-3.0cm）");
        deviceAnalysis.add("压力值偏高（建议85-90）");
        deviceAnalysis.add("喷涂角度偏差（建议与工件垂直）");
        response.setDeviceAnalysis(deviceAnalysis);

        List<String> realtimeAlerts = new ArrayList<>();
        realtimeAlerts.add("左肩角度过大，建议调整");
        realtimeAlerts.add("喷涂距离偏离建议值30%");
        realtimeAlerts.add("压力值超过阈值5%，存在安全风险");
        response.setRealtimeAlerts(realtimeAlerts);

        return response;
    }

    /**
     * 获取训练统计数据
     */
    @Override
    public TrainingStatsResponse getTrainingStats(TimeRangeRequest request) {
        Date[] dateRange = DateUtil.getDateRangeByType(request.getTimeRange());
        String startDate = DateUtil.formatDate(dateRange[0]);
        String endDate = DateUtil.formatDate(dateRange[1]);

        TrainingStats stats = trainingStatsMapper.selectByDateRange(startDate, endDate);
        if (stats == null) {
            // 调用“ResultCode枚举 + 自定义消息”构造方法
            throw new BusinessException(ResultCode.DATA_NOT_FOUND, "暂无该时间范围的训练统计数据");
        }

        TrainingStatsResponse response = new TrainingStatsResponse();
        response.setTrainingTimes(stats.getTrainingTimes());
        response.setAvgScore(stats.getAvgScore());
        response.setErrorRate(stats.getErrorRate());
        response.setAccuracy(stats.getAccuracy());
        response.setLevel(stats.getLevel());
        response.setCertification(stats.getCertification());

        return response;
    }

    /**
     * 生成实时趋势数据
     */
    @Override
    public List<Double> generateRealtimeTrend() {
        Random random = new Random();
        List<Double> trend = new ArrayList<>();
        trend.add(100.0);
        for (int i = 1; i < 5; i++) {
            double nextVal = trend.get(i-1) + (random.nextDouble() * 30 - 15);
            nextVal = Math.max(0, Math.min(100, nextVal));
            trend.add(Math.round(nextVal * 10) / 10.0);
        }
        return trend;
    }
}