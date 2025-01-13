package com.best.board;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jsoup.Jsoup;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import com.best.alarm.AlarmDTO;
import com.best.alarm.AlarmService;


@Service
public class BoardService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired BoardDAO boardDao;
	@Autowired AlarmService alarmService;
	
	
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
	public String noticeWrite(Map<String, String> param, String emp_idx) {
		
		BoardDTO boardDTO = new BoardDTO();
	    boardDTO.setSubject(param.get("subject"));
	    boardDTO.setContent(param.get("content"));
	    boardDTO.setName(param.get("name"));
	    boardDTO.setEmp_idx(Integer.parseInt(emp_idx));
	    boardDTO.setBoard_category(1); // 고정 값 설정
	    boardDTO.setImportance("true".equals(param.get("importance")) ? 1 : 0);

	    boardDao.noticeWrite(boardDTO);
	    return String.valueOf(boardDTO.getBoard_idx());

	}

	
	// 공지 상세보기
	public ModelAndView noticeDetail(String idx, String page) {
	    ModelAndView mav = new ModelAndView();
	    Map<String, Object> map = boardDao.noticeDetail(idx);
	    mav.addObject("info", map);
	    mav.setViewName(page); 
	    return mav;
	}
	public void noticeViewCount(String idx) {
		boardDao.noticeViewCount(idx);
	}
	
	
	// 공지 수정
	public void noticeUpdate(Map<String, String> param) {
		logger.info("imporrr: {}",param.get("importance"));
		boardDao.noticeUpdate(param);
	}
	
	
	// 중요 공지 토글
	public boolean toggleImportant(String board_idx, int importance) {
		return boardDao.toggleImportant(board_idx, importance);
	}

	
	// 공지 삭제
	public void noticeDelete(String board_idx) {
		boardDao.noticeDelete(board_idx);
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
		
		List<?> importantNotices = boardDao.noticeSearch(1, importLimit, importoffset, searchText, searchOption);
		result.put("importantNotices", importantNotices);	
		result.put("generalNotices", boardDao.noticeSearch(0, generalLimit, generaloffset, searchText, searchOption));
        result.put("importTotalPages", importTotalPages);
        result.put("generalTotalPages", generalTotalPages);
        
        logger.info("dk ㄴㅇㅁ시럼 쳐 나와라: {}", importantNotices);
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

	
	// 자유 게시판 작성
	public String freeWrite(Map<String, String> param, String emp_idx) {
		
		BoardDTO boardDTO = new BoardDTO();
	    boardDTO.setSubject(param.get("subject"));
	    boardDTO.setContent(param.get("content"));
	    boardDTO.setName(param.get("name"));
	    boardDTO.setEmp_idx(Integer.parseInt(emp_idx));
	    boardDTO.setBoard_category(2);
	    boardDTO.setImportance(0);

	    boardDao.freeWrite(boardDTO);
	    return String.valueOf(boardDTO.getBoard_idx());	
	    
    }
  

	// 자유 게시판 상세보기
	public ModelAndView freeDetail(String idx, String page) {
		ModelAndView mav = new ModelAndView();
	    Map<String, Object> map = boardDao.freeDetail(idx);
	    mav.addObject("info", map);
	    mav.setViewName(page); 
	    return mav;
	}
	public void viewCount(String idx) {
		boardDao.viewCount(idx);	
	}
	
	
	// 자유 게시판 수정하기
	public void freeUpdate(Map<String, String> param) {
		boardDao.freeUpdate(param);
	}

	
	// 자유 게시판 게시글 삭제하기(상세보기)
	@Transactional
	public void freeDelete(String board_idx) {
		boardDao.commentDelete(board_idx);
		boardDao.freeDelete(board_idx);
	}

	
	// 자유 게시판 검색
	public Map<String, Object> freeSearch(int page, int cnt, String searchText, String searchOption) {
		int offset = (page-1) * cnt;
		
		int totalPages = boardDao.freeSearchCount(cnt, searchText, searchOption);		
	
		Map<String, Object> result = new HashMap<>();
		
		result.put("freeList", boardDao.freeSearchList(cnt, offset, searchText, searchOption));	
        result.put("totalPages", totalPages);
        
        return result;
	}

	// 자유 게시판 댓글 리스트
//	public Map<String, Object> commentList(String board_idx, int page, int cnt) {
//		int offset = (page - 1) * cnt;
//
//	    List<CommentDTO> rawComments = boardDao.commentList(board_idx, cnt, offset);
//
//	    Map<String, Object> result = new HashMap<>();
//	    result.put("comments", rawComments);
//	    result.put("totalPages", boardDao.commentCount(board_idx, cnt)); 
//
//	    return result;
//	}

	public Map<String, Object> commentList(String board_idx, int page, int cnt) {
	    int offset = (page - 1) * cnt;

	    // 원댓글 가져오기
	    List<Map<String, Object>> parentComments = boardDao.parentComments(board_idx, cnt, offset);

	    // 대댓글 가져오기
	    List<Map<String, Object>> childComments = boardDao.childComments(board_idx);

	    // 대댓글을 부모 댓글에 매핑
	    Map<Integer, List<Map<String, Object>>> childMap = new HashMap<>();
	    for (Map<String, Object> child : childComments) {
	        Integer parentIdx = (Integer) child.get("parent_idx");
	        childMap.computeIfAbsent(parentIdx, k -> new ArrayList<>()).add(child);
	    }

	    // 전체 댓글 개수 계산
	    int totalComments = boardDao.countParentComments(board_idx);
	    int totalPages = (int) Math.ceil((double) totalComments / cnt);

	    // 결과 반환
	    Map<String, Object> result = new HashMap<>();
	    result.put("parentComments", parentComments);
	    result.put("childMap", childMap);
	    result.put("totalPages", totalPages);

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

        int boardAuthor = Integer.parseInt(param.get("boardAuthor"));
        int commenterIdx = Integer.parseInt(param.get("emp_idx"));

        // 게시글 작성자에게 알림
        if (boardAuthor != commenterIdx) {
            alarmService.sendCommentNotification(boardAuthor, "게시글", comDTO.getContent(), commenterIdx, comDTO.getEmp_name(), comDTO.getBoard_idx());
        }
	}

	
	// 자유 게시판 대댓글 작성
	public void addReply(Map<String, String> param) {
		
		CommentDTO comDTO = new CommentDTO();
		comDTO.setBoard_idx(Integer.parseInt(param.get("board_idx")));
		comDTO.setContent(param.get("content"));
		comDTO.setEmp_idx(param.get("emp_idx"));
		comDTO.setEmp_name(param.get("emp_name"));
		comDTO.setParent_idx(Integer.parseInt(param.get("parent_idx")));
		
        boardDao.addReply(comDTO);

        
        int replyAuthorIdx = Integer.parseInt(param.get("emp_idx")); // 대댓글 작성자
        int parent_idx = Integer.parseInt(param.get("parent_idx")); // 부모 댓글 ID
        int taggedEmpIdx = Integer.parseInt(param.get("taggedEmpIdx")); // 언급된 사용자
        
        // 원댓글 작성자
        int parent_emp = boardDao.getParentEmp(parent_idx);

        if (parent_emp != taggedEmpIdx) {
            if (taggedEmpIdx != replyAuthorIdx) {
                alarmService.sendMentionNotification(taggedEmpIdx, comDTO.getContent(), replyAuthorIdx, comDTO.getEmp_name(), comDTO.getBoard_idx());
            }
        } else {
            if (parent_emp != replyAuthorIdx) { 
                alarmService.sendCommentNotification(parent_emp, "댓글", comDTO.getContent(), replyAuthorIdx, comDTO.getEmp_name(), comDTO.getBoard_idx());
            }
        }
        
	}

	// 자유 게시판 댓글 수정
	public void updateComment(int comment_idx, String content) {
		boardDao.updateComment(comment_idx, content);
	}
	
	
	// 자유 게시판 댓글 삭제
	@Transactional
	public void deleteComment(int comment_idx) {
		boardDao.deleteReplies(comment_idx);
		boardDao.deleteComment(comment_idx);
	}

	
	// 자유 게시판 대댓글 삭제
	public void deleteReply(int comment_idx) {
		boardDao.deleteComment(comment_idx);
	}

}