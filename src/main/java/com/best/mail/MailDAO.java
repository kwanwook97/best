package com.best.mail;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MailDAO {
	
	// 지정된 사원 목록조회
	List<Map<String, Object>> mailList(Map<String, Object> condition);

	// 전체 페이지 수 계산
	int allCount(Map<String, Object> condition);

	// 사원정보 가져오기(메일, 이름, idx) 
	List<Map<String, Object>> empInfo(Map<String, Object> map);

	// 메일전송자 정보저장하기
	int mailSender(MailSendDTO sendDto);

	// 메일수신자 정보저장하기
	int mailReceiver(List<MailReceiveDTO> receiveList);

	// 메일 첨부파일업로드
	int fileUpload(Map<String, Object> condition);

	// 메일 읽음여부 업데이트
	int updateReadStatus(Map<String, Object> map);

	// 중요여부 업데이트
	int updateSpecialStatus(Map<String, Object> map);

	// 메일 휴지통이동, 복구, 완전삭제 
	int moveToTrash(Map<String, Object> map);
	
	
}
