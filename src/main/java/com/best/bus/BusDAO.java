package com.best.bus;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BusDAO {

	List<RouteDTO> driveInfo();

	List<Map<String, Object>> busDetail(String routeName, String filterType, String keyword);

	void busInsert(BusDTO bus);

	void busManInsert(BusManageDTO busMan);

	BusDTO busUpdate(int bus_idx);

	List<Map<String, Object>> busManUpdate(int bus_idx);

	List<Map<String, Object>> busSum(String routeName);

//	void busUpdateDo(BusDTO bus);
//
//	void busManUdateDo(BusManageDTO busMan);

	List<String> busDispatch();

	List<Map<String, Object>> license(String routeName);

	List<Map<String, Object>> driver(String routeName);

	List<Map<String, Object>> shift();

	int dispatchInsert(DispatchDTO dispatch);

	int driveInsert(DriveDTO drive);

	DispatchDTO checkDuplicateDispatch(DispatchDTO dispatch);

	List<Map<String, Object>> dispatchList(String date);

	int dispatchUpdate(Map<String, Object> updateData);

	Map<String, Object> getDispatchByIdx(int dispatchIdx);

	int getDriverIdx(int empIdx);

	int getDispatchIdx(int driverIdx, String date);

	void insertDrive(int dispatchIdx, String startTime, String status);

	Integer findDriverIdxByEmpIdx(int empIdx);

	Map<String, Object> findDispatchIdxByDriverIdxAndDate(Integer driverIdx, String date);

	int updateDriveStatus(Integer dispatchIdx, Date startTime, String status);

	void updateBusDriveStatus(Integer busIdx, String driveStatus);

	int updateDriveEndStatus(Integer dispatchIdx, Date endTime, String status);




}
