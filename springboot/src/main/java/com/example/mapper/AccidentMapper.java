package com.example.mapper;

import com.example.entity.Accident;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

@Mapper
public interface AccidentMapper {
    List<Accident> selectAll();
    List<Accident> selectByTimeRange(@Param("start") Date start, @Param("end") Date end);
    List<Accident> selectByCondition(Accident condition);
}