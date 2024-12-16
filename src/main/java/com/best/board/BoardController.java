package com.best.board;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
	@Autowired BoardService board_service;
	
	// 공지 게시판 리스트
	@GetMapping(value="/noticeBoard.go")
	public String main() {
		return "board/noticeBoard";
	}
	@GetMapping (value="/noticeList.ajax")
	@ResponseBody
	public Map<String, Object> noticeList(String page, String cnt) {
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);
		
		return board_service.noticeList(page_, cnt_);
	}
	
	
	// 공지 작성
	@RequestMapping(value="/noticeWrite.go")
	public String noticeWrite() {
		return "board/noticeWrite";
	}
	@PostMapping(value="/noticeWrite.do")
	public ModelAndView noticeWrite(@RequestParam Map<String, String> param) {
		int emp_idx = 1;
		String board_idx = board_service.noticeWrite(param, emp_idx);
		
		return new ModelAndView("redirect:/noticeDetail.go?idx="+board_idx);
	}
	
	// 공지 상세보기
	@GetMapping(value="/noticeDetail.go")
	public ModelAndView noticeDetail(String idx) {
		return board_service.noticeDetail(idx, "board/noticeDetail");
	}
	
	
	// 공지 수정하기
	@GetMapping(value="/noticeUpdate.go")
	public ModelAndView noticeUpdate(String idx) {
		return board_service.noticeDetail(idx,"board/noticeUpdate");
	}
	@PostMapping(value="/noticeUpdate.do")
	public ModelAndView noticeUpdate(@RequestParam Map<String, String> param) {
		board_service.noticeUpdate(param);
		return new ModelAndView("redirect:/noticeDetail.go?idx="+param.get("board_idx"));
	}
	
	
	// 검색
	@GetMapping(value="/noticeSearch.ajax")
	@ResponseBody
	public Map<String, Object> noticeSearch(@RequestParam Map<String, String> param) {
		int page_ = Integer.parseInt(param.get("page"));
		int cnt_ = Integer.parseInt(param.get("cnt"));
		String searchText = param.get("searchText");
		String searchOption = param.get("searchOption");
		
		return board_service.noticeSearch(page_, cnt_,searchText,searchOption);
	}
	
}
