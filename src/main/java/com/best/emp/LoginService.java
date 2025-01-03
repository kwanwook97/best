package com.best.emp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class LoginService {

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

        if (employee == null || !passwordEncoder.matches(pw, employee.getPassword())) {
            return null; // 인증 실패
        }

        // 사용자가 접근 가능한 URL 목록 조회
        List<String> accessibleUrls = getAccessibleUrlsForUser(employee.getDepart_idx(), employee.getRank_idx());

        // 권한 정보를 Spring Security Context에 설정
        setAuthoritiesForEmployee(employee, accessibleUrls);

        // 결과 데이터를 Map에 담기
        Map<String, Object> result = new HashMap<>();
        result.put("employee", employee); // 직원 정보
        result.put("accessibleUrls", accessibleUrls); // 접근 가능한 URL

        return result;
    }

    /**
     * 모든 URL과 사용자 권한 기반으로 접근 가능한 URL 필터링
     */
    public List<String> getAccessibleUrlsForUser(int departIdx, int rankIdx) {
        List<String> allUrls = loginDAO.findAllUrls();
        List<String> accessibleUrls = new ArrayList<>();

        for (String url : allUrls) {
            if (loginDAO.hasAccessToUrl(url, departIdx, rankIdx) > 0) {
                // URL 앞에 "/"를 붙여줌 (이미 "/"로 시작한다면 그대로 유지)
                if (!url.startsWith("/")) {
                    url = "/" + url;
                }
                accessibleUrls.add(url);
            }
        }

        return accessibleUrls;
    }


    /**
     * SecurityContext에 권한 정보 설정
     */
    private void setAuthoritiesForEmployee(EmployeeDTO employee, List<String> accessibleUrls) {
        List<GrantedAuthority> authorities = new ArrayList<>();

        // URL 자체를 권한으로 설정
        for (String url : accessibleUrls) {
            authorities.add(new SimpleGrantedAuthority(url));
        }

        // SecurityContext에 Authentication 설정
        Authentication auth = new UsernamePasswordAuthenticationToken(employee, null, authorities);
        SecurityContextHolder.getContext().setAuthentication(auth);
    }
}


    
    
//	public boolean login(String id, String pw) {
//	// 1. id 를 만족하는 pw 를 DB 에서 가져와라
//	String pass = loginDAO.login(id);
//	
//	// 2. 받아온 pw(plain) 와 Db 에 저장된 pw(encode 가 같은지 비교
//	return encoder.matches(pw, pass);
//}
//public void sendTemporaryPassword(String email, String temporaryPassword) {
//    SimpleMailMessage message = new SimpleMailMessage();
//    message.setTo(email);
//    message.setSubject("임시 비밀번호 안내");
//    message.setText("임시 비밀번호는 다음과 같습니다: " + temporaryPassword + "\n로그인 후 반드시 비밀번호를 변경해주세요.");
//    mailSender.send(message);
//}
//public String resetPassword(String id, String email) {
//    // 1. 임시 비밀번호 생성
//    String temporaryPassword = UUID.randomUUID().toString().substring(0, 8);
//
//    // 2. 암호화된 비밀번호 저장
//    String encryptedPassword = encoder.encode(temporaryPassword);
//    Map<String, String> params = new HashMap<>();
//    params.put("id", id);
//    params.put("pw", encryptedPassword);
//    loginDAO.updatePassword(params);
//
//    // 3. 이메일로 임시 비밀번호 전송
//    sendTemporaryPassword(email, temporaryPassword);
//
//    return "임시 비밀번호가 이메일로 전송되었습니다.";
//}


    
    
    
    
    
    
    
    
    

