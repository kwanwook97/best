package com.best.board;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BoardController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired BoardService boardService;
	
	// 공지 게시판 리스트
	@GetMapping(value="/noticeBoard.go")
	public String noticeBoard() {
		return "board/noticeBoard";
	}
	@GetMapping (value="/noticeList.ajax")
	@ResponseBody
	public Map<String, Object> noticeList(String page, String cnt) {
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);
		
		return boardService.noticeList(page_, cnt_);
	}
		
	
	// 공지 작성
	@RequestMapping(value="/noticeWrite.go")
	public String noticeWrite() {
		return "board/noticeWrite";
	}
	@PostMapping(value="/noticeWrite.do")
	public ModelAndView noticeWrite(@RequestParam Map<String, String> param) {
		int emp_idx = 1;
		String board_idx = boardService.noticeWrite(param, emp_idx);
		
		return new ModelAndView("redirect:/noticeDetail.go?idx="+board_idx);
	}
	
	// 공지 상세보기
	@GetMapping(value="/noticeDetail.go")
	public ModelAndView noticeDetail(String idx) {
		return boardService.noticeDetail(idx, "board/noticeDetail");
	}
	
	
	// 공지 수정하기
	@GetMapping(value="/noticeUpdate.go")
	public ModelAndView noticeUpdate(String idx) {
		return boardService.noticeDetail(idx,"board/noticeUpdate");
	}
	@PostMapping(value="/noticeUpdate.do")
	public ModelAndView noticeUpdate(@RequestParam Map<String, String> param) {
		boardService.noticeUpdate(param);
		return new ModelAndView("redirect:/noticeDetail.go?idx="+param.get("board_idx"));
	}
	
	
	// 공지 검색
	@GetMapping(value="/noticeSearch.ajax")
	@ResponseBody
	public Map<String, Object> noticeSearch(@RequestParam Map<String, String> param) {
		int page_ = Integer.parseInt(param.get("page"));
		int cnt_ = Integer.parseInt(param.get("cnt"));
		String searchText = param.get("searchText");
		String searchOption = param.get("searchOption");
		
		return boardService.noticeSearch(page_, cnt_,searchText,searchOption);
	}
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	
	// 자유 게시판 리스트
	@GetMapping(value="/freeBoard.go")
	public String freeBoard() {
		return "board/freeBoard";
	}
	@GetMapping(value="/freeBoardList.ajax")
	@ResponseBody
	public Map<String, Object> freeBoardList(String page, String cnt) {
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);
		
		return boardService.freeBoardList(page_, cnt_);
	}
	
	
	// 자유 게시판 상세보기
	@GetMapping(value="/freeDetail.go")
	public ModelAndView freeDetail(String idx) {
		return boardService.freeDetail(idx, "board/freeDetail");
	}
	
	
	// 자유 게시판 수정하기
	@GetMapping(value="/freeUpdate.go")
	public ModelAndView freeUpdate(String idx) {
		return boardService.freeDetail(idx,"board/freeUpdate");
	}
	@PostMapping(value="/freeUpdate.do")
	public ModelAndView freeUpdate(@RequestParam Map<String, String> param) {
		boardService.freeUpdate(param);
		return new ModelAndView("redirect:/freeDetail.go?idx="+param.get("board_idx"));
	}
	
	
	// 자유 게시판 댓글 리스트
	@GetMapping(value = "/commentList.ajax")
	@ResponseBody
	public Map<String, Object> commentList(String board_idx, String page, String cnt) {
	    int page_ = (page != null) ? Integer.parseInt(page) : 1;
	    int cnt_ = (cnt != null) ? Integer.parseInt(cnt) : 10;

	    return boardService.commentList(board_idx, page_, cnt_);
	}
	
	
	// 자유 게시판 댓글 작성
	@PostMapping(value="/addComment.ajax")
	@ResponseBody
	public ResponseEntity<String> addComment(@RequestParam Map<String, String> param) {
		boardService.addComment(param);
        return ResponseEntity.ok("댓글이 작성되었습니다.");
    }
	
	
	
}
