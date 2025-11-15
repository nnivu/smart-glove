package com.example.common.util;

import cn.hutool.core.date.DateField;

import java.util.Date;

/**
 * 日期工具类（基于Hutool封装）
 */
public class DateUtil extends cn.hutool.core.date.DateUtil {

    /**
     * 根据时间范围类型获取时间区间
     * @param timeRange 时间范围（week/month/quarter/year）
     * @return 数组[开始时间, 结束时间]
     */
    public static Date[] getDateRangeByType(String timeRange) {
        Date end = new Date();
        return switch (timeRange) {
            case "month" -> new Date[]{DateUtil.offsetMonth(end, -1), end};
            case "quarter" -> new Date[]{DateUtil.offsetMonth(end, -3), end};
            case "year" -> new Date[]{DateUtil.offset(end, DateField.YEAR, -1), end};
            default -> new Date[]{DateUtil.offsetDay(end, -6), end}; // 默认近7天
        };
    }
}