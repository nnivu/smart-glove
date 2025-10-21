package com.example.service;

import com.example.entity.RiskFactor;

import java.util.List;

public interface RiskFactorService {
    List<RiskFactor> selectAll();
    // 其他风险因素业务方法
}