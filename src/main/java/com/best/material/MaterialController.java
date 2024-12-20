package com.best.material;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MaterialController {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired MaterialService materialService;
	
	@RequestMapping(value="/material.go")
	public String materialGo() {
		return "material/materialInfo";
	}
	
	@PostMapping(value="/materialList.ajax")
	@ResponseBody
	public Map<String, Object> materialListAjax(int cnt, @RequestParam(value = "page", defaultValue = "1") int page){
		Map<String, Object> map = new HashMap<String, Object>();
			
		return materialService.materialList(cnt,page);
	}
	
	@PostMapping(value="/saveMaterialInfo.ajax")
	@ResponseBody
	public Map<String, Object> insertMaterialInfo(@RequestParam Map<String, Object> params){
		logger.info("params:{}",params);
		return materialService.insertMaterialInfo(params);
	}
	
	//기자재 수정
	@PostMapping(value="/saveUpdateMaterialInfo.ajax")
	@ResponseBody
	public Map<String, Object> updateMaterialInfo(@RequestParam Map<String, Object> params){
		logger.info("params:{}",params);
		return materialService.updateMaterialInfo(params);
	}
	
	@PostMapping(value="/delMaterial.ajax")
	@ResponseBody
	public Map<String, Object> delMaterial(@RequestParam Map<String, Object> params){
		logger.info("params:{}",params);
		return materialService.delMaterial(params);
	}
	
	@PostMapping(value="/borrowList.ajax")
	@ResponseBody
	public List<Map<String, Object>> borrowList(@RequestBody Map<String, Object> params){
		logger.info("params:종원 테스트 1:{}",params);
		return materialService.borrowList(params);
	}
}





























