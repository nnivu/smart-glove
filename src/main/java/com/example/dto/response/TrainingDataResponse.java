package com.example.dto.response;

import lombok.Data;
import java.util.List;

/**
 * 姿态训练数据响应DTO
 */
@Data
public class TrainingDataResponse {
    // 顶部统计信息
    private String dataset;
    private Double score;
    private String riskLevel;
    private Double progress;
    private String deviceStatus;

    // 实时参数
    private RealtimeParams realtimeParams;

    // 标准姿态参考
    private List<StandardPostureResponse> standardPostures;

    // 实时趋势数据
    private List<Double> realtimeTrend;

    // 姿态对比数据
    private List<PostureComparisonResponse> postureComparisons;

    // 内部嵌套DTO：实时参数
    @Data
    public static class RealtimeParams {
        private Double armAngle;
        private Double wristPosition;
        private String bodyPosture;
        private Double sprayDistance;
        private Double sprayAngle;
        private Double pressure;
    }

    // 内部嵌套DTO：标准姿态
    @Data
    public static class StandardPostureResponse {
        private String name;
        private String description;
        private String imageUrl;
    }

    // 内部嵌套DTO：姿态对比
    @Data
    public static class PostureComparisonResponse {
        private String itemName;
        private Double userValue;
        private Double standardValue;
    }
}