package com.best.board;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.http.ResponseEntity;

@Mapper
public interface BoardDAO {

	// 공지 게시판 ------------------------------------------------------------------------------------------------------------------------
	// 공지 토탈 페이지
	int allCount(int importance, int cnt);
	// 공지 리스트
	List<BoardDTO> noticeList(int importance, int limit, int offset);

	// 공지 작성
	int noticeWrite(BoardDTO boardDTO);

	// 공지 상세보기
	Map<String, Object> noticeDetail(String board_idx);
	int noticeViewCount(String board_idx);
	
	// 공지 수정
	int noticeUpdate(Map<String, String> param);
	
	// 중요 공지 토글
	boolean toggleImportant(String board_idx, int importance);
	
	// 공지 삭제
	int noticeDelete(String board_idx);
	
	// 공지 검색 토탈 페이지
	int searchCount(int importance, int cnt, String searchText, String searchOption);
	// 공지 검색 리스트
	List<BoardDTO> noticeSearch(int importance, int limit, int offset, String searchText, String searchOption);
	
	
	// 자유 게시판 ------------------------------------------------------------------------------------------------------------------------
	// 자유 게시판 토탈 페이지
	int freeBoardCount(int cnt);
	// 자유 게시판 리스트
	List<BoardDTO> freeBoardList(int cnt, int offset);
	
	// 자유 게시판 작성
	int freeWrite(BoardDTO boardDTO);
	
	// 자유 게시판 상세보기
	Map<String, Object> freeDetail(String board_idx);
	int viewCount(String board_idx);
	
	// 자유 게시판 수정하기
	int freeUpdate(Map<String, String> param);
	
	// 자유 게시판 게시글 지우기(상세보기)
	int commentDelete(String board_idx);
	int freeDelete(String board_idx);
	
	// 자유 게시판 검색 토탈 페이지
	int freeSearchCount(int cnt, String searchText, String searchOption);
	// 자유 게시판 검색 리스트
	List<BoardDTO> freeSearchList(int cnt, int offset, String searchText, String searchOption);

	
	// 자유 게시판 댓글 토탈 페이지
//	int commentCount(String board_idx, int cnt);
	// 자유 게시판 댓글 리스트
//	List<CommentDTO> commentList(String board_idx, int cnt, int offset);
	
	int countParentComments(String board_idx); // 원댓글 개수
	List<Map<String, Object>> parentComments(String board_idx, int cnt, int offset); // 원댓글 리스트
	List<Map<String, Object>> childComments(String board_idx); // 대댓글 리스트
	
	
	// 자유 게시판 댓글 작성
	int addComment(CommentDTO comDTO);
	
	// 자유 게시판 대댓글 작성
	int addReply(CommentDTO comDTO);
	

	int getParentEmp(int parent_idx);

	// 자유 게시판 댓글 수정
	int updateComment(int comment_idx, String content);
	
	// 자유 게시판 댓글 삭제
	int deleteReplies(int parent_idx);
	int deleteComment(int comment_idx);

	
	

}
