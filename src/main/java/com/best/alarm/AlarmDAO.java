package com.best.alarm;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AlarmDAO {

	void insertAlarm(AlarmDTO alarm);

	List<AlarmDTO> alarmList(int emp_idx, String type, Integer flag);

}
