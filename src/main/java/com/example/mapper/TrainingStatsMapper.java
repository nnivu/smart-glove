package com.example.mapper;

import com.example.entity.TrainingStats;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 训练统计数据访问接口
 */
@Mapper
public interface TrainingStatsMapper {
    /**
     * 根据时间范围查询训练统计
     * @param startDate 开始日期（yyyy-MM-dd）
     * @param endDate 结束日期（yyyy-MM-dd）
     */
    TrainingStats selectByDateRange(
            @Param("startDate") String startDate,
            @Param("endDate") String endDate
    );
}