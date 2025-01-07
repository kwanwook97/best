package com.best.material;

import java.util.HashMap; 
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MaterialService {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired MaterialDAO materialDAO;
	public Map<String, Object> materialList(int cnt, int page) {
		int limit = cnt;
		int offset = (page - 1) * cnt;
		
		List<Map<String, Object>> list = materialDAO.materialList(limit,offset);
		int  totalPages = materialDAO.getTotalPages(limit,offset);
	    Map<String, Object> response = new HashMap<>();
	    response.put("totalPages", totalPages);
	    response.put("currentPage", page);
	    response.put("list", list);
		
		return response;
	}
	public Map<String, Object> insertMaterialInfo(Map<String, Object> params) {
		int row = materialDAO.insertMaterialInfo(params);
		Map<String, Object> map = new HashMap<String, Object>();
		if (row>0) {
			map.put("msg","저장 성공");
		}
		return map;
	}
	
	@Transactional
	public Map<String, Object> updateMaterialInfo(Map<String, Object> params) {
		Map<String, Object> response = new HashMap<String, Object>();
		int row = materialDAO.updateMaterialInfo(params);
		response.put("msg", "업데이트 실패");
		int dow = 0;
		if (row>0) {
			dow = materialDAO.updateTotalQuantity(params);
			response.put("msg", "업데이트 성공");
		}else {
			response.put("msg", "예외 에러");
		}
		
		return response;
	}
	public Map<String, Object> delMaterial(Map<String, Object> params) {
		Map<String, Object> response = new HashMap<String, Object>();
		int row = materialDAO.delMaterial(params);
		response.put("msg", "삭제 실패");
		if (row>0) {
			response.put("msg","삭제 성공");
		}else {
			response.put("msg", "예외 발생");
		}
		return response;
	}
	
	
	public Map<String, Object> borrowList(Map<String, Object> params) {
	    int page = (int) params.getOrDefault("page", 1);
	    int size = (int) params.getOrDefault("size", 10);
	    
	    params.put("size", size);
	    params.put("offset", (page - 1) * size); 

	    logger.info("params 서비스 테스트: {}", params);

	    int totalCount = materialDAO.getBorrowCount(params); 
	    List<Map<String, Object>> borrowList = materialDAO.getBorrowList(params);

	    int totalPages = (int) Math.ceil((double) totalCount / size);

	    Map<String, Object> result = new HashMap<>();
	    logger.info("result  테스트: {}", result);
	    result.put("data", borrowList);
	    result.put("currentPage", page);
	    result.put("totalPages", totalPages);
	    return result;
	}
	
	@Transactional
	public Map<String, Object> confirmReturn(Map<String, Object> params) {
		int row = 0;
		int reserveIdx = materialDAO.getReserveIdx(params);
		List<Map<String, Integer>> updateArgument = materialDAO.getMaterialConfirm(reserveIdx);
		logger.info("종원 인자값 테스트 1 : {}",updateArgument);
		for (Map<String, Integer> material : updateArgument) {
	        int materialIdx = (int) material.get("material_idx");
	        int quantity = (int) material.get("quantity");
	        int borrowIdx = (int) material.get("borrow_idx");
	        int loginId = Integer.parseInt((String) params.get("loginId"));
	         row += materialDAO.updateRemainQuantity(materialIdx, quantity); //반환 하는 기자재가 있으니 기자재 테이블가서 업데이트 햇겠지?
	         // 업데이트가 됬으니까 조건걸고 거기에맞는 사원 idx 값을 borrow 테이블에 넣으면 알아서 반환 처리 되겠지?
	         if (row >0) {
	        	 int sow = materialDAO.updateHandlerEmp(borrowIdx,loginId);
	         }
		}
		
		Map<String, Object> response = new HashMap<String, Object>();
		response.put("msg", "반납 성공");
		return response;
	}
	
}

































