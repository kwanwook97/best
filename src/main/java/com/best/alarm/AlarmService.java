package com.best.alarm;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.best.mail.MailReceiveDTO;
import com.best.mail.MailSendDTO;
import com.best.websocket.GlobalWebsocketHandler;

@Service
public class AlarmService {
	
	private MailSendDTO storedSender;
	private List<MailReceiveDTO> storedReceivers;

	@Autowired AlarmDAO alarmDAO;

	/* 알림 리스트 */
	public List<AlarmDTO> alarmList(int emp_idx, String type, Boolean flag, int offset, int limit) {
	    return alarmDAO.alarmList(emp_idx, type, flag, offset, limit);
	}
	/* 총 안읽은 알림 갯수 */
	public int getTotalAlarmCount(int emp_idx, String type, Boolean flag) {
	    return alarmDAO.getTotalAlarmCount(emp_idx, type, flag);
	}

	/* 발신자 데이터 */
	public void processSenderData(MailSendDTO sender) {
	    if (sender == null) {
	        throw new IllegalArgumentException("발신자 데이터가 유효하지 않습니다.");
	    }
	    this.storedSender = sender;
	    checkAndBroadcast();
	}

	/* 수신자 데이터 */
	public void processReceiverData(List<MailReceiveDTO> receivers) {
	    if (receivers == null || receivers.isEmpty()) {
	        throw new IllegalArgumentException("수신자 데이터가 유효하지 않습니다.");
	    }
	    this.storedReceivers = receivers;
	    checkAndBroadcast();
	}

	// 발신자와 수신자 데이터가 모두 준비되었을 때 알림 실행
	private void checkAndBroadcast() {
	    if (storedSender != null && storedReceivers != null) {
	        insertAlarmAndBroadcast(storedSender, storedReceivers);
	        clearStoredData(); // 저장된 데이터를 초기화
	    }
	}

	// 저장된 데이터 초기화
	private void clearStoredData() {
	    this.storedSender = null;
	    this.storedReceivers = null;
	}

	/* 메일 알림 브로드캐스트 */
	private void insertAlarmAndBroadcast(MailSendDTO sender, List<MailReceiveDTO> receivers) {
	    for (MailReceiveDTO receiver : receivers) {
	        AlarmDTO alarm = new AlarmDTO();
	        alarm.setEmp_idx(receiver.getReceiver_idx());
	        alarm.setType("mail");
	        alarm.setContent("<i class=\"bi bi-send\"></i> " + sender.getSender_name() + "님 으로부터 새로운 메일이 도착했습니다.");
	        alarm.setDate(new Date());

	        // 알림 저장
	        alarmDAO.insertAlarm(alarm);

	        // WebSocket 브로드캐스트 실행
	        GlobalWebsocketHandler.broadcastNewMail(
	            receiver.getReceiver_idx(),
	            alarm.getContent(),
	            alarm.getType() // type 전달
	        );
	    }
	}

    
    /* 결재건 alarmDTO 저장 */
    public void sendAlarms(List<AlarmDTO> alarms) {
        for (AlarmDTO alarm : alarms) {
            // 알림 저장
            alarmDAO.insertAlarm(alarm);

            // WebSocket 브로드캐스트
            GlobalWebsocketHandler.broadcastNewMail(
                alarm.getEmp_idx(),
                alarm.getContent(),
                alarm.getType() // type 전달
            );
        }
    }
    
    /* 회의실, 캘린더, 기자재 데이터 가져오기 */
    public void sendUpcomingEventAlarms() {
        // 회의실 예약 일정 가져오기
        List<Map<String, Object>> upcomingRoomEvents = alarmDAO.getUpcomingEvents();
        // 일반 캘린더 일정 가져오기
        List<Map<String, Object>> upcomingCalendarEvents = alarmDAO.getUpcomingCalendarEvents();
        // 기자재 대여 일정 가져오기
        List<Map<String, Object>> upcomingBorrowEvents = alarmDAO.getUpcomingBorrowEvents();

        // 회의실 예약 일정 알림 처리
        sendEventAlarms(upcomingRoomEvents, "reserve");

        // 일반 캘린더 일정 알림 처리
        sendEventAlarms(upcomingCalendarEvents, "calendar");

        // 기자재 대여 일정 알림 처리
        sendEventAlarms(upcomingBorrowEvents, "borrow");
    }

    /* 회의실, 캘린더, 기자재 알림 브로드캐스트 */
    private void sendEventAlarms(List<Map<String, Object>> events, String eventType) {
        for (Map<String, Object> event : events) {
            int empIdx = (int) event.get("employeeId");
            String subject = (String) event.get("subject");
            String visibility = (String) event.get("visibility"); // visibility 가져오기

            // visibility에 따라 접두사 결정
            String prefix = "";
            if ("calendar".equals(eventType.toLowerCase())) { // calendar일 때만 prefix 추가
                switch (visibility.toLowerCase()) {
                    case "all":
                        prefix = "[전체] ";
                        break;
                    case "private":
                        prefix = "[개인] ";
                        break;
                    case "public":
                        prefix = "[부서] ";
                        break;
                }
            }

            // 알림 생성 및 저장
            String content = null;
            switch (eventType.toLowerCase()) {
                case "reserve":
                    content = "<i class=\"bi bi-calendar-range\"></i> 회의실 예약 " + subject + " 10분 전입니다. <i class=\"bi bi-alarm\"></i>";
                    break;
                case "calendar":
                    content = "<i class=\"fa-regular fa-calendar-check\"></i>  "+ prefix + subject + " 10분 전입니다. <i class=\"bi bi-alarm\"></i>";
                    break;
                case "borrow":
                    content = "<i class=\"bi bi-box\"></i> 대여하신 " + subject + " 반납 시간 10분 지났습니다. <i class=\"bi bi-alarm\"></i>";
                    break;
            }
            AlarmDTO alarm = new AlarmDTO();
            alarm.setEmp_idx(empIdx);
            alarm.setType(eventType.toLowerCase());
            alarm.setContent(content);
            alarm.setDate(new Date());
            alarmDAO.insertAlarm(alarm);

            // WebSocket 브로드캐스트
            GlobalWebsocketHandler.broadcastNewMail(empIdx, content, eventType.toLowerCase());
        }
    }

    /* 알림 읽음 처리 */
    public void updateAlarmFlag(int alarm_idx, int flag) {
        alarmDAO.updateAlarmFlag(alarm_idx, flag);
    }
    /* 헤더 안읽음 알림 5개 */
	public List<Map<String, Object>> unreadAlarm(int emp_idx) {
		return alarmDAO.unreadAlarm(emp_idx);
	}
	
	/* 안읽은 알림 브로드캐스트 */
	public int getUnreadAlarmCount(int empIdx) {
        int unreadCount = alarmDAO.getUnreadAlarmCount(empIdx);
        GlobalWebsocketHandler.broadcastUnreadAlarm(empIdx, unreadCount);
        return unreadCount;
    }
	
	/* 게시글 작성자 / 원댓글 작성자 알림 */
	public void sendCommentNotification(int empIdx, String targetType, String content, int senderIdx, String senderName, int boardIdx) {
	    String message = String.format(
	        "<a href='freeDetail.go?idx=%d'><i class=\"bi bi-chat\"></i> %s님이 회원님의 %s에 댓글을 작성했습니다: \"%s\"</a>",
	        boardIdx, senderName, targetType, content.length() > 20 ? content.substring(0, 20) + "..." : content
	    );

	    sendNotification(empIdx, message, "comment");
	}
	
	/* @태그 알림 */
	public void sendMentionNotification(int empIdx, String content, int senderIdx, String senderName, int boardIdx) {
	    String message = String.format(
	        "<a href='freeDetail.go?idx=%d'><i class=\"bi bi-at\"></i> %s님이 댓글에서 회원님을 언급했습니다: \"%s\"</a>",
	        boardIdx, senderName, content.length() > 20 ? content.substring(0, 20) + "..." : content
	    );

	    sendNotification(empIdx, message, "comment");
	}

	/* 게시글 알림 브로드캐스트 */
	public void sendNotification(int empIdx, String content, String type) {
	    AlarmDTO alarm = new AlarmDTO();
	    alarm.setEmp_idx(empIdx);
	    alarm.setType(type);
	    alarm.setContent(content);
	    alarm.setDate(new Date());

	    alarmDAO.insertAlarm(alarm); // 알림 저장
	    GlobalWebsocketHandler.broadcastNewMail(empIdx, content, type); // WebSocket 브로드캐스트
	}

	
	

}
