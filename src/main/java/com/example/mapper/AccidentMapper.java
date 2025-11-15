package com.example.mapper;

import com.example.entity.Accident;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

@Mapper
public interface AccidentMapper {
    // 原有查询方法
    List<Accident> selectAll();
    List<Accident> selectByTimeRange(@Param("start") Date start, @Param("end") Date end);
    List<Accident> selectByCondition(Accident condition);

    // 新增：插入事故数据
    int insert(Accident accident);

    // 更新：根据ID全量更新
    int updateById(Accident accident);

    // （可选）更新：根据ID选择性更新（只更新非null字段）
    int updateSelective(Accident accident);

    // 删除：根据ID删除
    int deleteById(@Param("id") Long id);

    // 查询：根据ID查询单条
    Accident selectById(@Param("id") Long id);
}