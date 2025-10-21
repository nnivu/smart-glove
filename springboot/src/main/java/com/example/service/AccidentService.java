package com.example.service;

import com.example.entity.Accident;

import java.util.Date;
import java.util.List;

public interface AccidentService {
    List<Accident> selectAll();
    List<Accident> selectByTimeRange(Date start, Date end);
}