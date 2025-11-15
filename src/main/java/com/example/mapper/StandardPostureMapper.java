package com.example.mapper;

import com.example.entity.StandardPosture;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

/**
 * 标准姿态数据访问接口
 */
@Mapper
public interface StandardPostureMapper {
    /**
     * 查询所有标准姿态
     */
    List<StandardPosture> selectAll();
}