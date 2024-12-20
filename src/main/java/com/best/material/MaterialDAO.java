package com.best.material;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MaterialDAO {

	List<Map<String, Object>> materialList(int limit, int offset);

	int getTotalPages(int limit, int offset);

	int insertMaterialInfo(Map<String, Object> params);

	int updateMaterialInfo(Map<String, Object> params);

	int updateTotalQuantity(Map<String, Object> params);

	int delMaterial(Map<String, Object> params);

	List<Map<String, Object>> getBorrowList(Map<String, Object> params);

	List<Map<String, Object>> getBorrowListFlagFalse(Map<String, Object> params);
	
	List<Map<String, Object>> getBorrowListFlagTrue(Map<String, Object> params);

}
