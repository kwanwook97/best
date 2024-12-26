package com.best.attendance;

import java.time.LocalDate;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AttendanceDAO {

	void insertAttendance();

	int checkHistory(LocalDate today);

	int updateStartTime(Map<String, Object> params);

	Map<String, Object> getWorkTime(Map<String, Object> params);

}
