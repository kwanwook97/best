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
	
	
	public List<Map<String, Object>> borrowList(Map<String, Object> params) {
	    Object returnStatus = params.get("returnStatus");
	    logger.info("params{}서비스 테스트:",params);
	    if ("전체".equals(returnStatus)) {
	        return materialDAO.getBorrowList(params);
	    } else if ("미반납".equals(returnStatus)) {
	        return materialDAO.getBorrowListFlagFalse(params);
	    } else if ("반납완료".equals(returnStatus)) {
	        return materialDAO.getBorrowListFlagTrue(params);
	    } else {
	        throw new IllegalArgumentException("잘못된 returnStatus 값: " + returnStatus);
	    }
	}
	
}

































