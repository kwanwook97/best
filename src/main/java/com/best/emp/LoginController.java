package com.best.emp;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

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
    public String memberLogin(Model model, HttpSession session, String id, String pw) throws JsonProcessingException {
        System.out.println("LoginController - /login.do reached with id: " + id);
        Map<String, Object> loginData = loginService.login(id, pw);
        
        //logger.info("loginData 테스트1:{}",loginData );

        if (loginData != null) {
            EmployeeDTO employee = (EmployeeDTO) loginData.get("employee");
            session.setAttribute("loginId", String.valueOf(employee.getEmp_idx()));
            session.setAttribute("loginName", employee.getName());
            session.setAttribute("employee", employee);
           
            
            ObjectMapper objectMapper = new ObjectMapper();
            String employeeJson = objectMapper.writeValueAsString(employee);
            logger.info("employee정보보기: {}", employeeJson);
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
            return "redirect:/accessManage.go";
        } else {
        	return "redirect:/adminLogin.go?error=invalid";
        }
    }
    
    
    

	
	
	
	
    @PostMapping(value = "/resetPassword.ajax")
    @ResponseBody
    public Map<String, String> resetPassword(@RequestParam String id, @RequestParam String email) {
        Map<String, String> response = new HashMap<>();
        try {
            String message = loginService.resetPassword(id, email);
            response.put("status", "success"); // 성공 상태
            response.put("message", message); // 성공 메시지
        } catch (Exception e) {
            response.put("status", "error"); // 실패 상태
            response.put("message", "비밀번호 초기화에 실패했습니다. 관리자에게 문의하세요."); // 실패 메시지
        }
        return response;
    }

	
    @PostMapping(value="/changePw.ajax")
    @ResponseBody
    public Map<String, String> changePassword(
            @RequestParam String id,
            @RequestParam String email,
            @RequestParam String pw,
            @RequestParam String changePw) {
        Map<String, String> response = new HashMap<>();
        try {
            // 사용자 인증
            boolean isValidUser = loginService.validateUser(id, email, pw);
            if (!isValidUser) {
                response.put("status", "error");
                response.put("message", "현재 비밀번호가 일치하지 않습니다.");
                return response;
            }

            // 비밀번호 변경
            boolean isPasswordChanged = loginService.changePassword(id, changePw);
            if (!isPasswordChanged) {
                response.put("status", "error");
                response.put("message", "비밀번호 변경에 실패했습니다.");
                return response;
            }

            // 성공 메시지 반환
            response.put("status", "success");
            response.put("message", "비밀번호가 성공적으로 변경되었습니다.");
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "비밀번호 변경 중 오류가 발생했습니다. 다시 시도해주세요.");
        }
        return response;
    }



}