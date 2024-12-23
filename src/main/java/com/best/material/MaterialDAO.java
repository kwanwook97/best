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

	int getReserveIdx(Map<String, Object> params);

	List<Map<String, Integer>> getMaterialConfirm(int reserveIdx);

	int updateRemainQuantity(int materialIdx, int quantity);

	int updateHandlerEmp(int borrowIdx,int loginId);

	int getBorrowCount(Map<String, Object> params);

}
