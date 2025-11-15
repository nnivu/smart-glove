package com.example.mapper;

import com.example.entity.PostureTraining;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 姿态训练数据访问接口
 */
@Mapper
public interface PostureTrainingMapper {
    /**
     * 查询最新的训练数据（默认取第一条）
     */
    PostureTraining selectLatestTraining();

    /**
     * 根据时间范围查询训练数据
     * @param startTime 开始时间
     * @param endTime 结束时间
     */
    List<PostureTraining> selectByTimeRange(
            @Param("startTime") String startTime,
            @Param("endTime") String endTime
    );

    /**
     * 插入训练数据
     */
    int insert(PostureTraining training);
}