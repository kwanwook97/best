package com.best.emp;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {
	
	@Autowired LoginService loginService;

	@RequestMapping(value = "/login.go")
	public String login() {
		return "main/login";
	}
	
	@RequestMapping(value = "/login.do")
	public String memberLogin(Model model, HttpSession session, String id, String pw) {
		String page="";
		EmployeeDTO employee = loginService.login(id, pw);
		if(employee != null) {
			session.setAttribute("loginId", id);
			session.setAttribute("loginName", employee.getName());
			page = "redirect:/main.go";
		}else {
			page = "redirect:/login.go";
		}
		return page;
	}
	
//	@RequestMapping(value = "/resetPassword.do")
//	@ResponseBody
//	public String resetPassword(@RequestParam String id, @RequestParam String email) {
//	    try {
//	        return loginService.resetPassword(id, email);
//	    } catch (Exception e) {
//	        return "비밀번호 초기화에 실패했습니다.";
//	    }
//	}
}
