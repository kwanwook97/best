package com.best.leave;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LeaveDAO {

	List<Map<String, Object>> getEmpList();

	int getAttendanceRecords(int empIdx, LocalDate previousDate, LocalDate today);

	void updateLeave(int empIdx, int i);

	List<Map<String, Object>> getLeaveHistory(Map<String, Object> params);

	Map<String, Object> selectLeaveHistory(Map<String, Object> map);

	void updateLeaveHistory(Map<String, Object> map);

	int insertLeaveHistoryLog(Map<String, Object> map);

	List<Map<String, Object>> getLeaveHistoryLog(Map<String, Object> params);

	void insertAnnualLeave(int empIdx, int i, String text);

	void updateLeaveDel(Map<String, Object> map);

	List<Map<String, Object>> getAnnualLeave();

	void insertLeaveHistory(Map<String, Object> map);


}
