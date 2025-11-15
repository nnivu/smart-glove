package com.example.mapper;

import com.example.entity.KeyPoint;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 关键点数据访问接口
 */
@Mapper
public interface KeyPointMapper {
    /**
     * 根据训练ID查询关键点数据
     */
    List<KeyPoint> selectByTrainingId(@Param("trainingId") Long trainingId);

    /**
     * 查询最新训练的关键点数据
     */
    List<KeyPoint> selectLatestKeyPoints();
}