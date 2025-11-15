package com.example.mapper;

import com.example.entity.PostureComparison;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 姿态对比数据访问接口
 */
@Mapper
public interface PostureComparisonMapper {
    /**
     * 根据训练ID查询姿态对比数据
     */
    List<PostureComparison> selectByTrainingId(@Param("trainingId") Long trainingId);
}