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

}
