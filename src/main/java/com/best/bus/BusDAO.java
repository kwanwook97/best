package com.best.bus;

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

	BusManageDTO busManUpdate(int bus_idx);

	List<Map<String, Object>> busSum(String routeName);

	void busUpdateDo(BusDTO bus);

	void busManUdateDo(BusManageDTO busMan);

	List<String> busDispatch();

	List<Map<String, Object>> license(String routeName);

	List<Map<String, Object>> driver(String routeName);

	List<Map<String, Object>> shift();

	int dispatchInsert(DispatchDTO dispatch);

	List<Map<String, Object>> dispatchList(String date);

	int dispatchUpdate(Map<String, Object> updateData);

	Map<String, Object> getDispatchByIdx(int dispatchIdx);

}
