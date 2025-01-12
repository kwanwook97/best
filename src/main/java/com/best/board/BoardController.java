package com.best.board;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public ModelAndView noticeWrite(@RequestParam Map<String, String> param, HttpSession session) {
		String emp_idx = (String) session.getAttribute("loginId");
		String board_idx = boardService.noticeWrite(param, emp_idx);
		
		return new ModelAndView("redirect:/noticeDetail.go?idx="+board_idx);
	}
	
	
	// 공지 상세보기
	@GetMapping(value="/noticeDetail.go")
	public ModelAndView noticeDetail(HttpSession session, String idx) {
		@SuppressWarnings("unchecked")
	    List<String> viewedPosts = (List<String>) session.getAttribute("viewedPosts");
		
		if (viewedPosts == null) {
	        viewedPosts = new ArrayList<String>();
	    }
	    if (!viewedPosts.contains(idx)) {
	    	boardService.noticeViewCount(idx);
	        viewedPosts.add(idx);
	        session.setAttribute("viewedPosts", viewedPosts);
	    }
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
	
	
	// 중요공지 토글
	@PostMapping(value="/toggleImportant.ajax")
	public ResponseEntity<Map<String, Object>> toggleImportant(String board_idx, int importance) {
		
		Map<String, Object> response = new HashMap<>();
		boolean success = boardService.toggleImportant(board_idx, importance);
		if (success) {
            response.put("success", 1);
        } else {
            response.put("success", 0);
            response.put("message", "문서 상태 업데이트 실패");
        }
		return ResponseEntity.ok(response);
	}
	
	
	// 공지 삭제하기
	@GetMapping(value="/noticeDelete.do")
	public String noticeDelete(String idx, RedirectAttributes redirectAttributes) {
        try {
            boardService.noticeDelete(idx);
            redirectAttributes.addFlashAttribute("message", "게시글이 삭제되었습니다.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "게시글 삭제 중 오류가 발생했습니다.");
            e.printStackTrace();
        }

        return "redirect:/noticeBoard.go";
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
	
	
	// 자유 게시판 작성
	@RequestMapping(value="/freeWrite.go")
	public String freeWrite() {
		return "board/freeWrite";
	}
	@PostMapping(value="/freeWrite.do")
	public ModelAndView freeWrite(@RequestParam Map<String, String> param, HttpSession session) {
		String emp_idx = (String) session.getAttribute("loginId");
		String board_idx = boardService.freeWrite(param, emp_idx);
		
		return new ModelAndView("redirect:/freeDetail.go?idx="+board_idx);
	}
	
	// 자유 게시판 상세보기
	@GetMapping(value="/freeDetail.go")
	public ModelAndView freeDetail(HttpSession session, String idx) {
	    @SuppressWarnings("unchecked")
	    List<String> viewedPosts = (List<String>) session.getAttribute("viewedPosts");

	    if (viewedPosts == null) {
	        viewedPosts = new ArrayList<String>();
	    }
	    if (!viewedPosts.contains(idx)) {
	        boardService.viewCount(idx);
	        viewedPosts.add(idx);
	        session.setAttribute("viewedPosts", viewedPosts);
	    }

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
	
	
	// 자유 게시판 게시글 삭제하기(리스트)
	// 자유 게시판 게시글 삭제하기(상세보기)
	@GetMapping(value="/freeDelete.go")
	public String freeDelete(String board_idx, RedirectAttributes redirectAttributes) {
        try {
            boardService.freeDelete(board_idx);
            redirectAttributes.addFlashAttribute("message", "게시글이 삭제되었습니다.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "게시글 삭제 중 오류가 발생했습니다.");
            e.printStackTrace();
        }

        return "redirect:/freeBoard.go";
    }
	
	
	// 자유 게시판 검색
	@GetMapping(value="/freeSearch.ajax")
	@ResponseBody
	public Map<String, Object> freeSearch(@RequestParam Map<String, String> param) {
		int page_ = Integer.parseInt(param.get("page"));
		int cnt_ = Integer.parseInt(param.get("cnt"));
		String searchText = param.get("searchText");
		String searchOption = param.get("searchOption");
		
		return boardService.freeSearch(page_, cnt_,searchText,searchOption);
	}
	
	
	// 자유 게시판 댓글 리스트
	@GetMapping(value = "/commentList.ajax")
	@ResponseBody
	public Map<String, Object> commentList(@RequestParam String board_idx, @RequestParam(required = false, defaultValue = "1") String page, @RequestParam(required = false, defaultValue = "10") String cnt) {
	    int page_ = Integer.parseInt(page);
	    int cnt_ = Integer.parseInt(cnt);

	    return boardService.commentList(board_idx, page_, cnt_);
	}
	
	
	// 자유 게시판 댓글 작성
	@PostMapping(value="/addComment.ajax")
	public ResponseEntity<String> addComment(@RequestParam Map<String, String> param) {
		boardService.addComment(param);
		
        return ResponseEntity.ok("댓글이 작성되었습니다.");
    }
	
	
	// 자유 게시판 대댓글 작성
	@PostMapping(value="/addReply.ajax")
	public ResponseEntity<String> addReply(@RequestParam Map<String, String> param) {
		boardService.addReply(param);
		
		return ResponseEntity.ok("댓글이 작성되었습니다.");
	}
	
	
	// 자유 게시판 댓글 수정
	@PostMapping(value="/updateComment.ajax")
	public ResponseEntity<String> updateComment(@RequestParam int comment_idx, @RequestParam String content) {
        boardService.updateComment(comment_idx, content);
        return ResponseEntity.ok("댓글이 성공적으로 삭제되었습니다.");
	}
	@PostMapping(value="/updateReply.ajax")
	public ResponseEntity<String> updateReply(@RequestParam int comment_idx, @RequestParam String content) {
		boardService.updateComment(comment_idx, content);
		return ResponseEntity.ok("댓글이 성공적으로 삭제되었습니다.");
	}
	
	
	// 자유 게시판 댓글 삭제
	@PostMapping("/deleteComment.ajax")
	public ResponseEntity<String> deleteComment(@RequestParam int comment_idx) {
	        boardService.deleteComment(comment_idx);
	        return ResponseEntity.ok("댓글이 성공적으로 삭제되었습니다.");
	}
	
	
	// 자유 게시판 대댓글 삭제
	@PostMapping(value="deleteReply.ajax")
	public ResponseEntity<String> deleteReply(@RequestParam int comment_idx) {
	        boardService.deleteReply(comment_idx);
	        return ResponseEntity.ok("댓글이 성공적으로 삭제되었습니다.");
	}
	
	
	
	
}
