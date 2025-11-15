package com.example.service;

import com.example.entity.Accident;

import java.util.Date;
import java.util.List;

public interface AccidentService {
    List<Accident> selectAll();
    List<Accident> selectByTimeRange(Date start, Date end);
    /**
     * 新增事故数据
     * @param accident 事故实体
     * @return 新增成功返回true，失败返回false
     */
    boolean saveAccident(Accident accident);

    /**
     * 修改事故数据
     * @param accident 包含修改信息的事故实体
     * @return 修改成功返回true，失败返回false
     */
    boolean updateAccident(Accident accident);

    /**
     * 根据ID删除事故数据
     * @param id 事故ID
     * @return 删除成功返回true，失败返回false
     */
    boolean deleteAccidentById(Long id);


}