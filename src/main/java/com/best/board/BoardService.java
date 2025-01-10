package com.best.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service
public class BoardService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired BoardDAO boardDao;
	
	
	// 공지 게시판 ----------------------------------------------------------------------------------------------------------
	// 중요, 일반 공지 페이징
    public Map<String, Object> noticeList(int page, int cnt) {

    	int importLimit = cnt;
    	int generalLimit = cnt+7;
		int importoffset = (page-1) * importLimit;
		int generaloffset = (page-1) * generalLimit;
		
		int importTotalPages = boardDao.allCount(1, importLimit); // 중요 공지 토탈		
		int generalTotalPages = boardDao.allCount(0, generalLimit); // 일반 공지 토탈
		
		Map<String, Object> result = new HashMap<>();
		
	    result.put("importantNotices", boardDao.noticeList(1, importLimit, importoffset)); // 중요 게시판 리스트
        result.put("generalNotices", boardDao.noticeList(0, generalLimit, generaloffset)); // 일반 게시판 리스트
        result.put("importTotalPages", importTotalPages); // 중요 게시판 총 페이지 수
        result.put("generalTotalPages", generalTotalPages); // 일반 게시판 총 페이지 수

        return result;
		
    }

    
    // 공지 작성
	public String noticeWrite(Map<String, String> param, int emp_idx) {
		
		BoardDTO boardDTO = new BoardDTO();
	    boardDTO.setSubject(param.get("subject"));
	    boardDTO.setContent(param.get("content"));
	    boardDTO.setName(param.get("name"));
	    boardDTO.setEmp_idx(emp_idx);
	    boardDTO.setBoard_category(1); // 고정 값 설정
	    boardDTO.setImportance("true".equals(param.get("importance")) ? 1 : 0);

	    boardDao.noticeWrite(boardDTO); // DTO 전달
	    return String.valueOf(boardDTO.getBoard_idx()); // 생성된 키 반환

	}

	
	// 공지 상세보기
	public ModelAndView noticeDetail(String idx, String page) {
	    ModelAndView mav = new ModelAndView();
	    Map<String, Object> map = boardDao.noticeDetail(idx);
	    mav.addObject("info", map);
	    mav.setViewName(page); 
	    return mav;
	}

	
	// 공지 수정
	public void noticeUpdate(Map<String, String> param) {
		logger.info("imporrr: {}",param.get("importance"));
		boardDao.noticeUpdate(param);
	}
	
	
	// 검색
	public Map<String, Object> noticeSearch(int page, int cnt, String searchText, String searchOption) {
		int importLimit = cnt;
    	int generalLimit = cnt+7;
		int importoffset = (page-1) * importLimit;
		int generaloffset = (page-1) * generalLimit;
		
		int importTotalPages = boardDao.searchCount(1, importLimit, searchText, searchOption); // 중요 공지 토탈		
		int generalTotalPages = boardDao.searchCount(0, generalLimit, searchText, searchOption); // 일반 공지 토탈
		
		Map<String, Object> result = new HashMap<>();
		
		result.put("importantNotices", boardDao.noticeSearch(1, importLimit, importoffset, searchText, searchOption));	
		result.put("generalNotices", boardDao.noticeSearch(0, generalLimit, generaloffset, searchText, searchOption));
        result.put("importTotalPages", importTotalPages);
        result.put("generalTotalPages", generalTotalPages);
		return result;
	}


	// 자유 게시판 ----------------------------------------------------------------------------------------------------------	
	// 자유 게시판 리스트
	public Map<String, Object> freeBoardList(int page, int cnt) {

		int offset = (page-1) * cnt;
		
		Map<String, Object> result = new HashMap<>();
		
		int totalPages = boardDao.freeBoardCount(cnt);	
	
        result.put("totalPages", totalPages);
        result.put("freeList", boardDao.freeBoardList(cnt, offset));

        return result;
	}


	// 자유 게시판 상세보기
	public ModelAndView freeDetail(String idx, String page) {
		ModelAndView mav = new ModelAndView();
	    Map<String, Object> map = boardDao.freeDetail(idx);
	    mav.addObject("info", map);
	    mav.setViewName(page); 
	    return mav;
	}
	
	
	// 자유 게시판 수정하기
	public void freeUpdate(Map<String, String> param) {
		boardDao.freeUpdate(param);
	}


	// 자유 게시판 댓글 리스트
	public Map<String, Object> commentList(String board_idx, int page, int cnt) {
	    int offset = (page - 1) * cnt;

	    // 쿼리 결과를 List<Map<String, Object>>로 받음
	    List<CommentDTO> rawComments = boardDao.commentList(board_idx, cnt, offset);
	    
	    List<CommentDTO> comments = new ArrayList<CommentDTO>();
	    Map<Integer, CommentDTO> commentMap = new HashMap<>();

	    // 댓글과 대댓글을 분리하여 계층 구조 생성
	    for (Map<String, Object> row : rawComments) {
	        Integer commentIdx = (Integer) row.get("comment_idx");
	        Integer parentIdx = (Integer) row.get("parent_idx");

	        if (parentIdx == null) {
	            // 댓글 추가
	            CommentDTO comment = new CommentDTO();
	            comment.setComment_idx(commentIdx);
	            comment.setContent((String) row.get("content"));
	            comment.setEmp_name((String) row.get("emp_name"));
	            comment.setCom_date((String) row.get("com_date"));
	            comment.setChildren(new ArrayList<>()); // 대댓글 리스트 초기화
	            comments.add(comment);
	            commentMap.put(commentIdx, comment);
	        } else {
	            // 대댓글 추가
	            CommentDTO reply = new CommentDTO();
	            reply.setComment_idx(commentIdx);
	            reply.setContent((String) row.get("content"));
	            reply.setEmp_name((String) row.get("emp_name"));
	            reply.setCom_date((String) row.get("com_date"));

	            // 부모 댓글의 children 리스트에 추가
	            if (commentMap.containsKey(parentIdx)) {
	                commentMap.get(parentIdx).getChildren().add(reply);
	            }
	        }
	    }

	    // 결과 반환
	    Map<String, Object> result = new HashMap<>();
	    result.put("comments", comments);
	    result.put("totalPages", boardDao.commentCount(board_idx, cnt));

	    return result;
	}

	
	
	// 자유 게시판 댓글 작성
	public void addComment(Map<String, String> param) {
		
		CommentDTO comDTO = new CommentDTO();
		comDTO.setBoard_idx(Integer.parseInt(param.get("board_idx")));
		comDTO.setContent(param.get("content"));
		comDTO.setEmp_idx(param.get("emp_idx"));
		comDTO.setEmp_name(param.get("emp_name"));
		
        boardDao.addComment(comDTO);
	}






	


}
