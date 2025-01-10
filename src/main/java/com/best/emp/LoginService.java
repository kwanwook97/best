package com.best.emp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class LoginService {

	@Autowired
    private JavaMailSender mailSender;
    private final LoginDAO loginDAO;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public LoginService(LoginDAO loginDAO, PasswordEncoder passwordEncoder) {
        this.loginDAO = loginDAO;
        this.passwordEncoder = passwordEncoder;
    }

    /**
     * 로그인 처리 메서드
     */
    public Map<String, Object> login(String id, String pw) {
        // 사용자 정보 가져오기
        EmployeeDTO employee = loginDAO.login(id);

        // 암호화된 비밀번호 체크
        if (employee == null || !passwordEncoder.matches(pw, employee.getPassword())) {
            return null; // 인증 실패
        }

        // SecurityContext에 권한 정보 설정 (URL 권한은 DynamicAuthorizationService에서 처리)
        setAuthoritiesForEmployee(employee);

        // 결과 데이터를 Map에 담기
        Map<String, Object> result = new HashMap<>();
        result.put("employee", employee); // 직원 정보

        return result;
    }

    /**
     * SecurityContext에 권한 정보 설정
     */
    private void setAuthoritiesForEmployee(EmployeeDTO employee) {
        // 권한 추가 없이 SecurityContext에 사용자 정보만 설정
    	// 1. principal: 인증된 사용자에 대한 정보 예) EmployeeDTO
    	// 2. credentials: 사용자 자격증명.. 이미 인증된 상태이므로 null값세팅.
    	// 3. authorities: 사용자 권한목록.. DynamicAuthorization에서 권한정보를 세팅했기에 null세팅.
        Authentication auth = new UsernamePasswordAuthenticationToken(employee, null, null);
        SecurityContextHolder.getContext().setAuthentication(auth);
    }

    
    // 관리자 로그인
	public boolean authenticateAdmin(String id, String password) {
        AdminDTO admin = loginDAO.getAdminById(id);
        
        // 로그인 성공시
        if(passwordEncoder.matches(password, admin.getPassword())) {
        	// 권한 부여
            List<GrantedAuthority> authorities = List.of(new SimpleGrantedAuthority("ROLE_ADMIN"));
            Authentication auth = new UsernamePasswordAuthenticationToken(admin, null, authorities);
            SecurityContextHolder.getContext().setAuthentication(auth);
            return true;
        }
        
        return false;
	}


    
	@Async
	public void sendTemporaryPassword(String email, String temporaryPassword) {
	    try {
	        MimeMessage mimeMessage = mailSender.createMimeMessage();
	        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

	        // 이메일 수신자 설정
	        helper.setTo(email);
	        helper.setSubject("임시 비밀번호 안내");

	        // HTML 본문 작성
	        String htmlContent = "<div style='font-family: Arial, sans-serif; line-height: 1.6; color: #333;'>"
	                + "<h2 style='color: #4CAF50;'>임시 비밀번호 안내</h2>"
	                + "<p>안녕하세요,</p>"
	                + "<p>요청하신 임시 비밀번호는 아래와 같습니다:</p>"
	                + "<div style='background: #f9f9f9; border: 1px solid #ddd; padding: 10px; width: fit-content;'>"
	                + "<strong style='font-size: 18px;'>" + temporaryPassword + "</strong>"
	                + "</div>"
	                + "<p>로그인 후 반드시 비밀번호를 변경해주세요.</p>"
	                + "<p style='margin-top: 20px;'>감사합니다.</p>"
	                + "</div>";

	        helper.setText(htmlContent, true); // 두 번째 파라미터 `true`로 설정하여 HTML 형식으로 보냄

	        // 이메일 전송
	        mailSender.send(mimeMessage);
	        System.out.println("이메일 전송 성공!");
	    } catch (MessagingException e) {
	        System.err.println("이메일 전송 실패: " + e.getMessage());
	        e.printStackTrace();
	    }
	}

	public String resetPassword(String id, String email) {
	    try {
	        // 1. 임시 비밀번호 생성
	        String temporaryPassword = UUID.randomUUID().toString().substring(0, 8);

	        // 2. 암호화된 비밀번호 저장
	        String encryptedPassword = passwordEncoder.encode(temporaryPassword);
	        Map<String, String> params = new HashMap<>();
	        params.put("id", id);
	        params.put("pw", encryptedPassword);
	        loginDAO.updatePassword(params);

	        // 3. 이메일로 임시 비밀번호 전송
	        sendTemporaryPassword(email, temporaryPassword);

	        return "임시 비밀번호가 이메일로 전송되었습니다.";
	    } catch (Exception e) {
	        System.err.println("비밀번호 초기화 실패: " + e.getMessage());
	        e.printStackTrace();
	        throw new RuntimeException("비밀번호 초기화에 실패했습니다."); // 예외를 위로 전달
	    }
	}



	public boolean validateUser(String id, String email, String currentPassword) {
	    int empIdx = Integer.parseInt(id);

	    // DB에서 사용자 정보 조회
	    EmployeeDTO user = loginDAO.findByIdAndEmail(empIdx, email);

	    // 사용자 정보가 없거나 비밀번호가 일치하지 않으면 false 반환
	    if (user == null || !passwordEncoder.matches(currentPassword, user.getPassword())) {
	        return false;
	    }

	    return true; // 비밀번호가 일치하면 true 반환
	}

public boolean changePassword(String id, String newPassword) {
    int empIdx = Integer.parseInt(id);

    // 비밀번호 암호화
    String encodedPassword = passwordEncoder.encode(newPassword);

    // 암호화된 비밀번호를 데이터베이스에 업데이트
    int result = loginDAO.chagePassword(empIdx, encodedPassword);

    return result > 0; // 성공 여부 반환
}



}
    
    
    
    
    
    
    
    

