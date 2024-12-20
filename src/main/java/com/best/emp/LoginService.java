package com.best.emp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService {
	//@Autowired PasswordEncoder encoder;
	@Autowired
    //private JavaMailSender mailSender;
	private final LoginDAO loginDAO;
	
	public LoginService(LoginDAO loginDAO) {
		this.loginDAO = loginDAO;
	}

	public boolean login(String id, String pw) {
		boolean suc = false;
		if(loginDAO.login(id, pw)) {
			suc = true;
		}
		return suc;
	}

//	public boolean login(String id, String pw) {
//		// 1. id 를 만족하는 pw 를 DB 에서 가져와라
//		String pass = loginDAO.login(id);
//		
//		// 2. 받아온 pw(plain) 와 Db 에 저장된 pw(encode 가 같은지 비교
//		return encoder.matches(pw, pass);
//	}
//	public void sendTemporaryPassword(String email, String temporaryPassword) {
//        SimpleMailMessage message = new SimpleMailMessage();
//        message.setTo(email);
//        message.setSubject("임시 비밀번호 안내");
//        message.setText("임시 비밀번호는 다음과 같습니다: " + temporaryPassword + "\n로그인 후 반드시 비밀번호를 변경해주세요.");
//        mailSender.send(message);
//    }
//	public String resetPassword(String id, String email) {
//        // 1. 임시 비밀번호 생성
//        String temporaryPassword = UUID.randomUUID().toString().substring(0, 8);
//
//        // 2. 암호화된 비밀번호 저장
//        String encryptedPassword = encoder.encode(temporaryPassword);
//        Map<String, String> params = new HashMap<>();
//        params.put("id", id);
//        params.put("pw", encryptedPassword);
//        loginDAO.updatePassword(params);
//
//        // 3. 이메일로 임시 비밀번호 전송
//        sendTemporaryPassword(email, temporaryPassword);
//
//        return "임시 비밀번호가 이메일로 전송되었습니다.";
//    }
}
