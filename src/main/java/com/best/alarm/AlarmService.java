package com.best.alarm;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.best.mail.MailReceiveDTO;
import com.best.mail.MailSendDTO;
import com.best.websocket.GlobalWebsocketHandler;

@Service
public class AlarmService {
	
	@Autowired AlarmDAO alarmDAO;

	public List<AlarmDTO> alarmList(int emp_idx, String type, Integer flag) {
	    return alarmDAO.alarmList(emp_idx, type, flag);
	}
	
	
	public void insertAlarmAndBroadcast(int mailSendIdx, List<MailReceiveDTO> receiveList, MailSendDTO sender) {
	    // 알림 생성
	    for (MailReceiveDTO receiver : receiveList) {
	        AlarmDTO alarm = new AlarmDTO();
	        alarm.setEmp_idx(receiver.getReceiver_idx());
	        alarm.setType("mail"); // 알림 유형
	        alarm.setContent(sender.getSender_name() + "님 으로부터 새로운 메일이 도착했습니다.");
	        alarm.setDate(new Date());

	        // 알림 저장
	        alarmDAO.insertAlarm(alarm);

	        // WebSocket 브로드캐스트 실행
	        GlobalWebsocketHandler.broadcastNewMail(
	                receiver.getReceiver_idx(),
	                sender.getSender_name(), // 발신자의 이름 전달
	                alarm.getContent() // 알림 내용 전달
            );
	    }
	}

}
