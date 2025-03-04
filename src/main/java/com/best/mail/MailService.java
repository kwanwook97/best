package com.best.mail;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.best.alarm.AlarmDAO;
import com.best.alarm.AlarmDTO;
import com.best.alarm.AlarmService;
import com.best.alarm.AlarmTemplateDTO;
import com.best.websocket.GlobalWebsocketHandler;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class MailService {
	
	@Autowired MailDAO mailDao;
	@Autowired AlarmService alarmService;
	@Value("${upload.path}") private String bpath;
	Logger logger = LoggerFactory.getLogger(getClass());

	
	// 메일목록 불러오기
	@Transactional
	public Map<String, Object> mailList(Map<String, String> map) {
		
		
		int totalPages = 0;
		int status = Integer.parseInt(map.get("status"));
		int page = Integer.parseInt(map.get("page"));
		int cnt = Integer.parseInt(map.get("cnt"));
		int emp_idx = Integer.parseInt(map.get("emp_idx"));
		int delete_flag = Integer.parseInt(map.get("delete_flag"));
		
		int mailFilter = Integer.parseInt(map.get("mailFilter")); // 0: 필터X, 1: 중요필터, 2:읽음필터
		int special_flag = 0;
		int read_flag = 0;
		
		
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
		condition.put("delete_flag", delete_flag);
		
		
		// 필터여부
		switch (mailFilter) {
		case 0:
			break;
		case 1:
			special_flag = Integer.parseInt(map.get("special_flag")); 
			condition.put("special_flag", special_flag);
			condition.put("mailFilter", 1);
			break;
		case 2:
			read_flag = Integer.parseInt(map.get("read_flag")); 
			condition.put("read_flag", read_flag);
			condition.put("mailFilter", 2);
			break;
		}
		
		
		List<Map<String, Object>> list = new ArrayList<>();
		
		int totalCnt = 0;
		
		// 휴지통 목록인경우 mail_send, mail_receive 테이블을 둘다 뒤져야함. 
	    if (table.equals("mail_trash")) {
	        // mail_trash 테이블일 경우, 두 테이블의 데이터를 합산
	        condition.put("table", "mail_send");
	        // status 0:임시저장, 1:발송 상관없이 모두 조회하기 위해 임의의 999값세팅
	        condition.put("status", 999);
	        
	        totalPages = mailDao.allCount(condition);
	        
	        condition.put("cnt", 1);
	        totalCnt = mailDao.allCount(condition);
	        logger.info("총 항목 수: " + totalCnt);
	        
	        list.addAll(mailDao.mailList(condition));
	        

	        condition.put("table", "mail_receive");
	        list.addAll(mailDao.mailList(condition));
	        
	        totalCnt += mailDao.allCount(condition);
	        logger.info("총 항목 수: " + totalCnt);
	    } else {
	        // 일반 테이블 조회
	        condition.put("table", table);
	        totalPages = mailDao.allCount(condition);
	        list.addAll(mailDao.mailList(condition));
	        
	        condition.put("cnt", 1);
	        totalCnt = mailDao.allCount(condition);
	        logger.info("총 항목 수: " + totalCnt);
	    }

	    // 결과 데이터 구성
	    Map<String, Object> result = new HashMap<>();
	    result.put("totalPages", totalPages);
	    result.put("currPage", page);
	    result.put("list", list);

	    
	    
	    // 조건에 맞는 전체 리스트 개수 가져오기.
	    // No.를 부여하기위함.
	    result.put("totalCnt", totalCnt);

	    
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

	
	// 메일전송, 임시저장 메일작성
	// 메일전송, 임시저장 메일작성
	@Transactional
	public int mailWrite(MultipartFile[] files, Map<String, Object> map) {
	    // 성공 여부 체크
	    int row = 0;

	    // mail_send_idx 확인
	    Integer mailSendIdx = map.get("mail_send_idx") != null
	            ? Integer.parseInt(map.get("mail_send_idx").toString())
	            : null;
	    
	    // special_flag와 status 값 처리
	    int specialFlag = map.get("special_flag") != null ? Integer.parseInt(map.get("special_flag").toString()) : 0;
	    int status = map.get("status") != null ? Integer.parseInt(map.get("status").toString()) : 1;

	    // sender 데이터 가공
	    MailSendDTO sendDto = new MailSendDTO();
	    sendDto.setSender_idx(Integer.parseInt(map.get("sender_idx").toString()));
	    sendDto.setSender_name((String) map.get("sender_name"));
	    sendDto.setSender_email((String) map.get("sender_email"));
	    sendDto.setSubject((String) map.get("subject"));
	    sendDto.setContent((String) map.get("content"));
	    sendDto.setSpecial_flag(specialFlag);
	    sendDto.setStatus(status);

	    if (mailSendIdx != null) {
	        // 기존 데이터 삭제
	        deleteExistingMailData(mailSendIdx);

	        // INSERT 새로 추가 (보내는 사람)
	        row = mailDao.mailSender(sendDto);
	        mailSendIdx = sendDto.getMail_send_idx();
	    } else {
	        // INSERT 새로 추가
	        row = mailDao.mailSender(sendDto);
	        mailSendIdx = sendDto.getMail_send_idx();
	    }

	    // 수신자 및 파일 처리
	    if (row > 0) {
	    	alarmService.processSenderData(sendDto);
	        processReceiversAndFiles(mailSendIdx, map, files, specialFlag);
	    }

	    return row;
	}

	// 기존 데이터 삭제
	@Transactional
	private void deleteExistingMailData(int mailSendIdx) {
	    // 수신자 삭제
	    mailDao.deleteMailReceiver(mailSendIdx);

	    // 첨부파일 삭제
	    mailDao.deleteAttach(mailSendIdx);

	    // 발신자 데이터 삭제
	    mailDao.deleteMailSender(mailSendIdx);
	}

	// 수신자 정보 및 파일 처리
	@Transactional
	private void processReceiversAndFiles(int mailSendIdx, Map<String, Object> map, MultipartFile[] files, int specialFlag) {
	    // 수신자 데이터 처리
	    String receiverDataJson = (String) map.get("receiver_data");
	    if (receiverDataJson == null || receiverDataJson.isEmpty()) {
	        throw new IllegalArgumentException("receiver_data가 비어있습니다.");
	    }
	    // JSON 파싱
	    List<Map<String, Object>> receiverData = new ArrayList<>();
	    try {
	        ObjectMapper objectMapper = new ObjectMapper();
	        receiverData = objectMapper.readValue(
	            receiverDataJson, new TypeReference<List<Map<String, Object>>>() {}
	        );
	    } catch (Exception e) {
	        logger.error("JSON 파싱 중 오류 발생: {}", receiverDataJson, e);
	        throw new RuntimeException("receiver_data 처리 중 문제가 발생했습니다.", e);
	    }
	    
	    // JSON 데이터가 비어있는 경우 처리
	    if (receiverData.isEmpty()) {
	        throw new IllegalArgumentException("receiver_data에 유효한 데이터가 없습니다.");
	    }
	    

	    List<MailReceiveDTO> receiveList = new ArrayList<>();
	    for (Map<String, Object> item : receiverData) {
	        if (!item.containsKey("name") || !item.containsKey("email") || !item.containsKey("emp_idx")) {
	            throw new IllegalArgumentException("JSON 데이터에 필요한 키가 없습니다: " + item);
	        }
	        // 값 가져오기
	        String name = (String) item.get("name");
	        String email = (String) item.get("email");
	        int empIdx = Integer.parseInt(item.get("emp_idx").toString());
	        int type = item.containsKey("type") ? Integer.parseInt(item.get("type").toString()) : 0;

	        // DTO 설정
	        MailReceiveDTO receiveDto = new MailReceiveDTO();
	        receiveDto.setMail_send_idx(mailSendIdx);
	        receiveDto.setReceiver_idx(empIdx);
	        receiveDto.setReceiver_email(email);
	        receiveDto.setReceiver_name(name);
	        receiveDto.setReceiver_type(type);
	        receiveDto.setSpecial_flag(specialFlag);
	        receiveList.add(receiveDto);
	    }


	    // 수신자 데이터 저장
	    if (!receiveList.isEmpty()) {
	        mailDao.mailReceiver(receiveList);
			alarmService.processReceiverData(receiveList);
	    }

	    
	    // 파일 처리
	    if (files != null) {
	        for (MultipartFile file : files) {
	            if (file == null || file.isEmpty()) continue;

	            try {
	                String fileName = file.getOriginalFilename();
	                String ext = fileName.substring(fileName.lastIndexOf("."));
	                String newFileName = UUID.randomUUID().toString() + ext;

	                byte[] arr = file.getBytes();
	                Path path = Paths.get(bpath + newFileName);
	                Files.write(path, arr);

	                Map<String, Object> condition = new HashMap<>();
	                condition.put("idx_num", mailSendIdx);
	                condition.put("fileName", fileName);
	                condition.put("newFileName", newFileName);

	                mailDao.fileUpload(condition);
	            } catch (IOException e) {
	                logger.error("파일 처리 중 오류 발생: ", e);
	            }
	        }
	    }
	}




	
	// 메일 읽음여부 업데이트
	public int updateReadStatus(Map<String, Object> map) {
		
		int mail_idx = Integer.parseInt((String) map.get("mailIdx"));
		map.put("mail_idx", mail_idx);
		
		
		return mailDao.updateReadStatus(map);
	}

	// 중요여부 업데이트
	public int updateSpecialStatus(Map<String, Object> map) {
		
		int mail_idx = Integer.parseInt((String) map.get("mailIdx"));
		map.put("mail_idx", mail_idx);
		
		return mailDao.updateSpecialStatus(map);
	}

	// 메일 휴지통이동, 복구, 완전삭제 
	public int updateDeleteStatus(Map<String, Object> map) {
		
		int mail_idx = Integer.parseInt((String) map.get("mailIdx"));
		int delete_flag = Integer.parseInt((String) map.get("delete_flag"));
		map.put("mail_idx", mail_idx);
		map.put("delete_flag", delete_flag);
		
		return mailDao.updateDeleteStatus(map);
	}

	
	// 메일상세보기
	@Transactional
	public Map<String, Object> mailDetail(String idx) {
		
		Map<String, Object> map = new HashMap<String, Object>();
	    
	    int mailSendIdx = Integer.parseInt(idx);
	    
	    // 작성자 데이터 가져오기
	    MailSendDTO senderDto = mailDao.senderDetail(mailSendIdx);
	    map.put("senderDto", senderDto);
	    
	    // 첨부파일 가져오기
	    List<Map<String, Object>> empAttach = mailDao.mailAttach(mailSendIdx);
		if(empAttach != null) 
			map.put("fileList", empAttach);
	    
	    
	    // 수신자 데이터 가져오기
	    List<MailReceiveDTO> receiverList = mailDao.receiverDetail(mailSendIdx);
	    map.put("receiverList", receiverList);
		
	    
	    return map;
	}

	// 첨부파일 다운로드
	public ResponseEntity<Resource> download(String newfile_name, String orifile_name) {
		//body
		Resource res = new FileSystemResource(bpath+newfile_name);
		
		//header
		HttpHeaders header = new HttpHeaders();		
		header.add("content-type", "application/octet-stream");
		try {
			String filename = URLEncoder.encode(orifile_name, "UTF-8");
			header.add("Content-Disposition", "attachment; filename=\""+filename+"\"");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}	
		
		//body, header, status
		return new ResponseEntity<Resource>(res, header, HttpStatus.OK);
	}
	




	
	
	
	

	
	
	
	
	
	
	
	
}
