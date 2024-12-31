package com.best.attendance;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AttendanceDAO {

	void insertAttendance();

	int checkHistory(LocalDate today);

	int updateStartTime(Map<String, Object> params);

	Map<String, Object> getWorkTime(Map<String, Object> params);

	List<Map<String, Object>> getAttendanceList(Map<String, Object> params);

	Map<String, Object> checkButton(Map<String, Object> params);

	int updateEndTime(Map<String, Object> params);

	Integer getLeave(Map<String, Object> params);

	void updateAbsent(LocalDate today);

	void upEmpStatus(Map<String, Object> params);

	void updateAttendance(Map<String, Object> map);

	int insertAttendanceHistory(Map<String, Object> map);

	Map<String, Object> selectAttendance(Map<String, Object> map);


}
