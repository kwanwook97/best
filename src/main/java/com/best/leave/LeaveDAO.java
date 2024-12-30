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


}
