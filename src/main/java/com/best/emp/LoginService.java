package com.best.emp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class LoginService {

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


    
    
//	public boolean login(String id, String pw) {
//	// 1. id 를 만족하는 pw 를 DB 에서 가져와라
//	String pass = loginDAO.login(id);
//	
//	// 2. 받아온 pw(plain) 와 Db 에 저장된 pw(encode 가 같은지 비교
//	return encoder.matches(pw, pass);
//}
public void sendTemporaryPassword(String email, String temporaryPassword) {
    SimpleMailMessage message = new SimpleMailMessage();
    message.setTo(email);
    message.setSubject("임시 비밀번호 안내");
    message.setText("임시 비밀번호는 다음과 같습니다: " + temporaryPassword + "\n로그인 후 반드시 비밀번호를 변경해주세요.");
    mailSender.send(message);
}
public String resetPassword(String id, String email) {
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
}

public boolean validateUser(String id, String email, String currentPassword) {
	int empIdx = Integer.parseInt(id);
    EmployeeDTO user = loginDAO.findByIdAndEmail(empIdx, email);
    if (user != null && user.getPassword().equals(currentPassword)) {
        return true;
    }
    return false;
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
    
    
    
    
    
    
    
    

