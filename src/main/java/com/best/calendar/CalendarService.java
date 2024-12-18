package com.best.calendar;

import java.io.File;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
public class CalendarService {
	@Autowired CalendarDAO calendarDAO;
	@Value("${upload.path}") private String bpath;
	Logger logger = LoggerFactory.getLogger(getClass());
	

	public Map<String, Object> saveCalendar(Map<String, Object> params) {
	    String date = (String) params.get("date");
	    String startTime = (String) params.get("startTime");
	    String endTime = (String) params.get("endTime");

	    // 날짜와 시간을 조합
	    String startDatetime = date + " " + startTime;
	    String endDatetime = date + " " + endTime;
	    params.put("startDateTime",startDatetime);
	    params.put("endDateTime",endDatetime);
	    
		int row = calendarDAO.saveCalendar(params);
		Map<String, Object> map = new HashMap<String, Object>();
		if (row >0) {
			map.put("msg", "회의가 성공적으로 저장되었습니다!");
		}
		
		
		
		return map;
	}

	public List<Map<String, Object>> getEvents(LocalDate startDate, LocalDate endDate) {
        // DAO를 통해 데이터베이스에서 이벤트를 가져옵니다.
        return calendarDAO.getEvents(startDate, endDate);
	}

	public List<RoomDTO> getRoomList() {
		return calendarDAO.getRoomList() ;
	}

	public Map<String, Object> myReserveList(int page, int cnt, int loginId) {
		int limit = cnt;
		int offset = (page - 1) * cnt;
		
	    List<Map<String, Object>> list = calendarDAO.myReserveList(limit, offset,loginId);
	    // 총 페이지 수 계산
	    int totalPages = calendarDAO.getTotalPages(limit, loginId);

	    // 결과 반환
	    Map<String, Object> response = new HashMap<>();
	    response.put("totalPages", totalPages);
	    response.put("currentPage", page);
	    response.put("list", list);
		 
		return response;
	}

	public Map<String, Object> myReserveUpdate(Map<String, Object> params) {
	    String date = (String) params.get("date");
	    String startTime = (String) params.get("startTime");
	    String endTime = (String) params.get("endTime");

	    // 날짜와 시간을 조합
	    String startDatetime = date + " " + startTime;
	    String endDatetime = date + " " + endTime;
	    params.put("startDateTime",startDatetime);
	    params.put("endDateTime",endDatetime);
	    
	    int row = calendarDAO.myReserveUpdate(params);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("msg", "업데이트 성공");
		return map;
	}

	public Map<String, Object> cancelReserve(Map<String, Object> params) {
	    int row = calendarDAO.cancelReserve(params);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("msg", "삭제 성공");
		return map;
	}

	public List<Map<String, Object>> getAllMaterials() {
		return calendarDAO.getAllMaterials();
	}


	public List<Map<String, Object>> allRoomList() {
		return calendarDAO.allRoomList();
	}

	// 회의실 저장
    @Transactional
	public Map<String, Object> saveRoomInfo(String roomName, MultipartFile photo, int maxCapacity, List<Integer> materialIdxList, List<Integer> quantityList) {
        String savedFileName = savePhoto(photo);
        Map<String, Object> params = new HashMap<>();
        params.put("name", roomName);
        params.put("photo", savedFileName);
        params.put("maxCapacity", maxCapacity);

        int row =0;
        if (!photo.isEmpty()) {
			params.put("response", "사진이 없습니다.");
			row = calendarDAO.insertRoomInfo(params);
		}
		if (row > 0) {
	        int roomIdx = ((BigInteger) params.get("roomIdx")).intValue();
	        saveRoomMaterials(roomIdx,materialIdxList,quantityList);
			params.put("response", "저장완료");
		}
		
		return params;
	}


	private String savePhoto(MultipartFile photo) {
		String newPhoto = "";
        if (photo != null && !photo.isEmpty()) {
            try {
                String ori = photo.getOriginalFilename();
                int ext = ori.lastIndexOf(".");
                if (ext >0) {
					String extt = ori.substring(ext);
					newPhoto = UUID.randomUUID()+extt;
					Path path = Paths.get(bpath,newPhoto);
					byte[] arr = photo.getBytes();
					Files.write(path, arr);
				}
            } catch (Exception e) {
                e.printStackTrace();
                throw new RuntimeException("파일 저장 실패");
            }
        }
        return newPhoto; // 파일이 없으면 null 반환
	}
	
	private void saveRoomMaterials(int roomIdx, List<Integer> materialIdxList, List<Integer> quantityList) {
        for (int i = 0; i < materialIdxList.size(); i++) {
            Map<String, Object> params = new HashMap<>();
            params.put("roomIdx", roomIdx);
            params.put("materialIdx", materialIdxList.get(i));
            params.put("quantity", quantityList.get(i));

            calendarDAO.insertRoomMaterial(params);
            int updatedRows = calendarDAO.updateMaterial(params);
            if (updatedRows == 0) {
                throw new IllegalArgumentException("재고 부족: materialIdx = " + materialIdxList.get(i));
            }
        }		
	}

    @Transactional
	public Map<String, Object> delRoomInfo(int roomIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<ReserveDTO> reserve = calendarDAO.selectReserveData(roomIdx);
		int row = 0;
		int dow = 0;
		if (reserve.isEmpty()) {
			row = calendarDAO.delRoomInfo(roomIdx);
			dow = calendarDAO.updateMaterialBecauseRoomInfo(roomIdx);
			map.put("response", "해당하는 회의실을 삭제 완료 되었습니다.");
				
		}else {
			map.put("response","해당 회의실 에는 예약 일정이 있습니다 예약 일정이 없는 회의실에만 삭제할 수 있습니다." );
		}
		return map;
	}

	public Map<String, Object> getRoomMaterialList(int roomIdx) {
		
		
		
		return null;
	}
	
	
	
	

}



