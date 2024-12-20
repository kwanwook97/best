package com.best.chat;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChatDAO {

	void insertChat(ChatDTO chatDTO);

	void insertParty(PartyDTO partyDTO);

	List<ChatDTO> chatList(Integer emp_idx);

	void message(MessageDTO message);

}
