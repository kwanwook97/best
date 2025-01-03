package com.best.alarm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AlarmDAO {

	void insertAlarm(AlarmDTO alarm);

	List<AlarmDTO> alarmList(int emp_idx, String type, Integer flag, int offset, int limit);

	int getTotalAlarmCount(int emp_idx, String type, Integer flag);

	List<Map<String, Object>> getUpcomingEvents();

	List<Map<String, Object>> getUpcomingCalendarEvents();

	void updateAlarmFlag(int alarm_idx, int flag);

	List<Map<String, Object>> unreadAlarm(int emp_idx);


}
