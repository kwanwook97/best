package com.best.mail;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class MailService {
	
	@Autowired MailDAO mailDao;
	Logger logger = LoggerFactory.getLogger(getClass());

	
	// 메일목록 불러오기
	public Map<String, Object> mailList(Map<String, String> map) {
		
		int status = Integer.parseInt(map.get("status"));
		int page = Integer.parseInt(map.get("page"));
		int cnt = Integer.parseInt(map.get("cnt"));
		int emp_idx = Integer.parseInt(map.get("emp_idx"));
		int category = Integer.parseInt(map.get("category"));
		int delete_flag = Integer.parseInt(map.get("delete_flag"));
		int receiver_type = Integer.parseInt(map.get("receiver_type"));
		
		String table = map.get("table");
		String searchFilter = map.get("searchFilter");
		String searchKeyword = "";
		
		// 검색 값이 있다면, 검색
		if(!map.get("searchKeyword").equals("")) {
			searchKeyword = map.get("searchKeyword");
		}
		
		logger.info("현재페이지 : "+page);
		logger.info("한페이지에 보여줄 갯수 : "+cnt);		
		int limit = cnt;
		int offset = (page-1) * cnt;
		
		// 검색 조건들을 담을 Map변수
		Map<String, Object> condition = new HashMap<String, Object>();
		condition.put("status", status);
		condition.put("page", page);
		condition.put("cnt", cnt);
		condition.put("limit", limit);
		condition.put("offset", offset);
		condition.put("searchFilter", searchFilter);
		condition.put("searchKeyword", searchKeyword);
		condition.put("emp_idx", emp_idx);
		condition.put("table", table);
		condition.put("category", category);
		condition.put("delete_flag", delete_flag);
		condition.put("receiver_type", receiver_type);
		
		int totalPages = mailDao.allCount(condition);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("totalPages", totalPages);
		result.put("currPage", page);
		result.put("list", mailDao.mailList(condition));		
		
		return result;
	}

	// 사원정보 가져오기(메일, 이름, idx) 
	public List<Map<String, Object>> empInfo(Map<String, Object> map) {
		
		int emp_idx;
		
		if(map.get("dataType").equals("emp_idx")) { // 데이터타입이 emp_idx인경우
			emp_idx = Integer.parseInt((String) map.get("emp_idx")); 
			map.put("emp_idx", emp_idx);
		}
		
		return mailDao.empInfo(map);
	}

	
	// 메일전송, 임시저장
	@Transactional
	public int mailWrite(MultipartFile[] files, Map<String, Object> map) {
	    // 성공 여부 체크
	    int row = 0;

	    // special_flag 값 처리
	    int specialFlag = 0; // 기본값 설정
	    if (map.get("special_flag") != null) {
	        try {
	            specialFlag = Integer.parseInt(map.get("special_flag").toString());
	        } catch (NumberFormatException e) {
	            logger.error("special_flag 값 변환 중 오류 발생: ", e);
	            throw new IllegalArgumentException("special_flag 값이 유효한 숫자가 아닙니다.");
	        }
	    }

	    // status 값 처리
	    int status = 1; // 기본값 설정
	    if (map.get("status") != null) {
	        try {
	            status = Integer.parseInt(map.get("status").toString());
	        } catch (NumberFormatException e) {
	            logger.error("status 값 변환 중 오류 발생: ", e);
	            throw new IllegalArgumentException("status 값이 유효한 숫자가 아닙니다.");
	        }
	    }

	    // sender 데이터 가공
	    MailSendDTO sendDto = new MailSendDTO();
	    sendDto.setSender_idx(Integer.parseInt(map.get("sender_idx").toString()));
	    sendDto.setSender_name((String) map.get("sender_name"));
	    sendDto.setSender_email((String) map.get("sender_email"));
	    sendDto.setSubject((String) map.get("subject"));
	    sendDto.setContent((String) map.get("content"));
	    sendDto.setSpecial_flag(specialFlag);
	    sendDto.setStatus(status);

	    // sender 데이터 저장
	    row = mailDao.mailSender(sendDto);

	    // 메일 idx 가져오기
	    int mailSendIdx = sendDto.getMail_send_idx();

	    // receiver_data 처리
	    if (row > 0) {
	        List<Map<String, String>> receiverData = new ArrayList<>();
	        String receiverDataJson = (String) map.get("receiver_data");
	        if (receiverDataJson != null && !receiverDataJson.isEmpty()) {
	            try {
	                ObjectMapper objectMapper = new ObjectMapper();
	                receiverData = objectMapper.readValue(
	                    receiverDataJson, new TypeReference<List<Map<String, String>>>() {}
	                );
	            } catch (Exception e) {
	                logger.error("JSON 파싱 중 오류 발생: ", e);
	                throw new RuntimeException("receiver_data 처리 중 문제가 발생했습니다.");
	            }
	        }

	        List<MailReceiveDTO> receiveList = new ArrayList<>();
	        for (Map<String, String> item : receiverData) {
	            MailReceiveDTO receiveDto = new MailReceiveDTO();
	            receiveDto.setMail_send_idx(mailSendIdx);
	            receiveDto.setReceiver_idx(Integer.parseInt(item.get("emp_idx")));
	            receiveDto.setReceiver_email(item.get("email"));
	            receiveDto.setReceiver_name(item.get("name"));
	            receiveDto.setReceiver_type(Integer.parseInt(item.get("type")));
	            receiveDto.setSpecial_flag(specialFlag);
	            receiveList.add(receiveDto);
	        }

	        // receiver 데이터 저장
	        if (!receiveList.isEmpty()) {
	            row = mailDao.mailReceiver(receiveList);
	        }
	    }

	    // 파일 처리
	    if (row > 0 && files != null) {
	        for (MultipartFile file : files) {
	            if (file == null || file.isEmpty()) {
	                logger.info("업로드할 파일이 없습니다.");
	                continue;
	            }

	            try {
	                String fileName = file.getOriginalFilename();
	                String ext = fileName.substring(fileName.lastIndexOf("."));
	                String newFileName = UUID.randomUUID().toString() + ext;

	                byte[] arr = file.getBytes();
	                Path path = Paths.get("C:/upload/" + newFileName);
	                Files.write(path, arr);

	                Map<String, Object> condition = new HashMap<>();
	                condition.put("idx_num", mailSendIdx);
	                condition.put("fileName", fileName);
	                condition.put("newFileName", newFileName);

	                row = mailDao.fileUpload(condition);
	            } catch (IOException e) {
	                logger.error("파일 처리 중 오류 발생: ", e);
	            }
	        }
	    }

	    return row;
	}





	
	
	
	
	
	
	
	
	
	
	
	
}
