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
}