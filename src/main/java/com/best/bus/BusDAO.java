package com.best.bus;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BusDAO {

	List<RouteDTO> driveInfo();

	List<Map<String, Object>> busDetail();

	void busInsert(BusDTO bus);

	void busManInsert(BusManageDTO busMan);

	BusDTO busUpdate(int bus_idx);

	BusManageDTO busManUpdate(int bus_idx);

	List<Map<String, Object>> busSum();

	void busUpdateDo(BusDTO bus);

	void busManUdateDo(BusManageDTO busMan);

}
