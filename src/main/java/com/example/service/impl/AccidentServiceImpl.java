package com.example.service.impl;

import com.example.entity.Accident;
import com.example.mapper.AccidentMapper;
import com.example.service.AccidentService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class AccidentServiceImpl implements AccidentService {

    @Resource
    private AccidentMapper accidentMapper;

    @Override
    public List<Accident> selectAll() {
        return accidentMapper.selectAll();
    }

    @Override
    public List<Accident> selectByTimeRange(Date start, Date end) {
        return accidentMapper.selectByTimeRange(start, end);
    }

    @Override
    public boolean saveAccident(Accident accident) {
        // 业务校验：确保关键字段非空
        if (accident.getHappenTime() == null) {
            throw new IllegalArgumentException("事故发生时间不能为空");
        }
        if (accident.getLevel() == null || accident.getLevel().isEmpty()) {
            throw new IllegalArgumentException("事故级别不能为空");
        }
        // 调用Mapper插入数据（返回值为影响行数，>0表示成功）
        return accidentMapper.insert(accident) > 0;
    }

    @Override
    public boolean updateAccident(Accident accident) {
        // 校验数据是否存在（可选，也可由Mapper层SQL判断）
        Accident existing = accidentMapper.selectById(accident.getId());
        if (existing == null) {
            return false;
        }
        // 调用Mapper更新数据
        return accidentMapper.updateById(accident) > 0;
    }

    @Override
    public boolean deleteAccidentById(Long id) {
        // 调用Mapper删除数据
        return accidentMapper.deleteById(id) > 0;
    }

}