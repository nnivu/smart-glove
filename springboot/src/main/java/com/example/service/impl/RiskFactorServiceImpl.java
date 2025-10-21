package com.example.service.impl;

import com.example.entity.RiskFactor;
import com.example.mapper.RiskFactorMapper;
import com.example.service.RiskFactorService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RiskFactorServiceImpl implements RiskFactorService {

    @Resource
    private RiskFactorMapper riskFactorMapper;

    @Override
    public List<RiskFactor> selectAll() {
        return riskFactorMapper.selectAll();
    }
}