package com.best.alarm;

import java.util.ArrayList;
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
	        alarm.setSource_idx(sender.getMail_send_idx());

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
	
	
    /* 알림 삽입 및 브로드캐스트 */
    public void sendAlarms(List<AlarmDTO> alarms) {
        for (AlarmDTO alarm : alarms) {
            alarmDAO.insertAlarm(alarm);

            // WebSocket 브로드캐스트
            GlobalWebsocketHandler.broadcastNewMail(
                alarm.getEmp_idx(),
                alarm.getContent(),
                alarm.getType()
            );
        }
    }

    
    /* 회의실, 캘린더, 기자재 알림 처리 */
    public void sendUpcomingEventAlarms() {
        // 회의실 예약 일정 가져오기 및 처리
        List<Map<String, Object>> upcomingRoomEvents = alarmDAO.getUpcomingEvents();
        List<AlarmDTO> roomAlarms = createEventAlarms(upcomingRoomEvents, "reserve");

        // 일반 캘린더 일정 가져오기 및 처리
        List<Map<String, Object>> upcomingCalendarEvents = alarmDAO.getUpcomingCalendarEvents();
        List<AlarmDTO> calendarAlarms = createEventAlarms(upcomingCalendarEvents, "calendar");

        // 기자재 대여 일정 가져오기 및 처리
        List<Map<String, Object>> upcomingBorrowEvents = alarmDAO.getUpcomingBorrowEvents();
        List<AlarmDTO> borrowAlarms = createEventAlarms(upcomingBorrowEvents, "borrow");

        // 모든 알림 삽입 및 브로드캐스트
        List<AlarmDTO> allAlarms = new ArrayList<>();
        allAlarms.addAll(roomAlarms);
        allAlarms.addAll(calendarAlarms);
        allAlarms.addAll(borrowAlarms);

        sendAlarms(allAlarms);
    }

    /* 공통된 알림 생성 로직 */
    private List<AlarmDTO> createEventAlarms(List<Map<String, Object>> events, String eventType) {
        List<AlarmDTO> alarms = new ArrayList<>();
        for (Map<String, Object> event : events) {
            int empIdx = (int) event.get("employeeId");
            String subject = (String) event.get("subject");
            int sourceIdx;

            // 이벤트 종류에 따라 sourceIdx 설정
            switch (eventType.toLowerCase()) {
                case "reserve":
                    sourceIdx = (int) event.get("reserveId"); // 회의실 예약 ID
                    break;
                case "calendar":
                    sourceIdx = (int) event.get("scheduleId"); // 캘린더 일정 ID
                    break;
                case "borrow":
                    sourceIdx = (int) event.get("borrowId"); // 기자재 대여 ID
                    break;
                default:
                    throw new IllegalArgumentException("지원되지 않는 이벤트 타입: " + eventType);
            }

            String content = "";
            if ("calendar".equals(eventType.toLowerCase())) {
                String visibility = (String) event.get("visibility");
                String prefix = getVisibilityPrefix(visibility);
                content = "<i class=\"fa-regular fa-calendar-check\"></i> " + prefix + subject + " 10분 전입니다. <i class=\"bi bi-alarm\"></i>";
            } else if ("reserve".equals(eventType.toLowerCase())) {
                content = "<i class=\"bi bi-calendar-range\"></i> 회의실 예약 " + subject + " 10분 전입니다. <i class=\"bi bi-alarm\"></i>";
            } else if ("borrow".equals(eventType.toLowerCase())) {
                content = "<i class=\"bi bi-box\"></i> 대여하신 " + subject + " 반납 시간 10분 지났습니다. <i class=\"bi bi-alarm\"></i>";
            }

            alarms.add(createAlarm(empIdx, eventType.toLowerCase(), content, sourceIdx));
        }
        return alarms;
    }



    /* visibility prefix 생성 */
    private String getVisibilityPrefix(String visibility) {
        if (visibility == null) return "";
        switch (visibility.toLowerCase()) {
            case "all":
                return "[전체] ";
            case "private":
                return "[개인] ";
            case "public":
                return "[부서] ";
            default:
                return "";
        }
    }

    /* AlarmDTO 생성 로직 */
    private AlarmDTO createAlarm(int empIdx, String type, String content, int sourceIdx) {
        AlarmDTO alarm = new AlarmDTO();
        alarm.setEmp_idx(empIdx);
        alarm.setType(type);
        alarm.setContent(content);
        alarm.setSource_idx(sourceIdx); // source_idx 추가
        return alarm;
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
