package com.best.calendar;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
@Mapper
public interface CalendarDAO {

	int saveCalendar(Map<String, Object> params);

	List<Map<String, Object>> getEvents(LocalDate startDate, LocalDate endDate);

	List<RoomDTO> getRoomList();

	List<Map<String, Object>> myReserveList(int limit, int offset, int loginId);

	int getTotalPages(int limit, int loginId);

	int myReserveUpdate(Map<String, Object> params);

	int cancelReserve(Map<String, Object> params);

	List<Map<String, Object>> getAllMaterials();

	List<Map<String, Object>> allRoomList();

	int insertRoomInfo(Map<String, Object> params);

	void insertRoomMaterial(Map<String, Object> params);

	int updateMaterial(Map<String, Object> params);

	int delRoomInfo(int roomIdx);

	List<ReserveDTO> selectReserveData(int roomIdx);

	int updateMaterialBecauseRoomInfo(int roomIdx);


}
