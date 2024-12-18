package com.best.board;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardDAO {

	// 공지 토탈 페이지
	int allCount(int importance, int cnt);
	// 공지 리스트
	List<BoardDTO> noticeList(int importance, int limit, int offset);

	// 공지 작성
	int noticeWrite(BoardDTO boardDTO);

	// 공지 상세보기
	Map<String, Object> noticeDetail(String idx);
	
	// 공지 수정
	int noticeUpdate(Map<String, String> param);
	
	// 검색 토탈 페이지
	int searchCount(int importance, int cnt, String searchText, String searchOption);
	// 검색 리스트
	List<BoardDTO> noticeSearch(int importance, int limit, int offset, String searchText, String searchOption);
	

}
