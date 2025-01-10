package com.best.chat;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.best.emp.EmployeeDTO;

@Mapper
public interface ChatDAO {

	void insertChat(ChatDTO chatDTO);

	void insertParty(PartyDTO loginPartyDTO);

	void message(MessageDTO message);

	List<Map<String, Object>> getMessagesByChatIdx(int chatIdx, int empIdx);

	String getEmployeeName(int emp_idx);

	int checkEnterMessageExists(int chat_idx, String content);

	void insertParty(int chat_idx, int emp_idx);

	void insertEnterMessage(MessageDTO messageDTO);

	int checkPartyExists(int chat_idx, int emp_idx);

	List<Integer> getAllChatIdx();

	List<String> getParticipantNames(Integer chat_idx, Integer emp_idx);

	List<Map<String, Object>> getChatParticipants(int chat_idx);

	int removeParticipant(int chat_idx, int emp_idx);

	int checkMessageExistsForToday(int chat_idx, String today);

	int getUnreadUserCount(int msgIdx);

	void insertDefaultMsgRead(Map<String, Object> params);

	int checkConnectionStatusExists(int chatIdx, int empIdx);

	void markMessagesAsRead(int chatIdx, int empIdx, LocalDateTime currentTime);

	void insertConnectionStatus(int chatIdx, int empIdx, LocalDateTime startTime);

	void updateConnectionTime(int chatIdx, int empIdx, LocalDateTime time, String action);

	void markMessageAsRead(int msgIdx, int empIdx);

	List<Integer> getMsgIdxListByChatIdx(int chatIdx);

	List<Map<String, Object>> chatListWithUnread(Integer emp_idx, String keyword);

	List<Map<String, Object>> getEmployeeList(String keyword);

	Map<String, Object> profile(int empIdx);

	int updateChatSubject(ChatDTO chatDTO);

	void updateChatNotice(int chatIdx, String noticeContent);

	String getChatNotice(int chat_idx);

	Map<String, Object> senderInfo(Integer empIdx);

	int unreadTotal(int emp_idx);

	List<Map<String, Object>> msgAlarm(Integer empIdx);

	Integer findSingleChatRoom(int emp_idx1, int emp_idx2);

	List<Map<String, Object>> chatParty(String keyword, int chatIdx);

}
