package com.best.emp;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {

    @Autowired
    LoginService loginService;
    Logger logger = LoggerFactory.getLogger(getClass());
    

    @RequestMapping(value = {"/", "/login.go"})
    public String login() {
        System.out.println("LoginController - /login.go reached");
        return "main/login";
    }

    @RequestMapping(value = "/login.do")
    public String memberLogin(Model model, HttpSession session, String id, String pw) {
        System.out.println("LoginController - /login.do reached with id: " + id);
        Map<String, Object> loginData = loginService.login(id, pw);

        if (loginData != null) {
            EmployeeDTO employee = (EmployeeDTO) loginData.get("employee");
            session.setAttribute("loginId", String.valueOf(employee.getEmp_idx()));
            session.setAttribute("loginName", employee.getName());
            session.setAttribute("employee", employee);
            
//            Object loginId = session.getAttribute("loginId");
//            logger.info("loginId의 클래스 타입: " + loginId.getClass().getName());
            return "redirect:/main.go";
        } else {
            return "redirect:/login.go?error=invalid";
        }
    }

    @RequestMapping(value = "/logout.do")
    public String memberLogout(HttpSession session) {
        System.out.println("LoginController - /logout.do reached");
        session.invalidate();
        return "redirect:/login.go?logout=success";
    }

    
    // 관리자 로그인페이지로 이동
    @RequestMapping(value = "/adminLogin.go")
    public String adminlogin() {
        System.out.println("LoginController - /login.go reached");
        return "main/adminLogin";
    }

    // 관리자 로그인
    @RequestMapping(value = "/adminLogin.do")
    public String adminLogin(String id, String pw, HttpSession session) {
        boolean isAuthenticated = loginService.authenticateAdmin(id, pw);
        if (isAuthenticated) {
            session.setAttribute("isAdmin", true);
            
            return "redirect:/main.go";
        } else {
            return "redirect:/adminLogin.go?error=invalid";
        }
    }
    
    
    
    
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
