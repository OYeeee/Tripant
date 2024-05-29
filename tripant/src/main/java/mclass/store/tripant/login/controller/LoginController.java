package mclass.store.tripant.login.controller;

import java.nio.charset.StandardCharsets;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import mclass.store.tripant.apikeys.KeysJaewon;
import mclass.store.tripant.member.domain.MemberEntity;

@RequiredArgsConstructor
@Controller
public class LoginController {
	
	private final KeysJaewon keysJaewon; 
	
	//로그인 페이지
	@GetMapping("/login")
	public String login(@RequestParam(value = "error", required = false)String error, 
						@RequestParam(value = "exception", required = false)String exception, 
						Model model) {
		String msg="";
		if(exception != null) {
			switch(exception) {
			case "BadCredentialsException":
				msg = "이메일 또는 비밀번호가 맞지 않습니다. 다시 확인해주세요.";
				break;
			case "InternalAuthenticationServiceException":
				msg = "시스템 문제로 인해 요청을 처리할 수 없습니다. 관리자에게 문의해주세요.";
				break;
			case "UsernameNotFoundException":
				msg = "계정이 존재하지 않습니다. 회원가입 진행 후 로그인 해주세요.";
				break;
			case "AuthenticationException":
				msg = "탈퇴 처리된 회원입니다. 관리자에게 문의해주세요.";
				break;
			default:
				msg = "알 수 없는 이유로 로그인에 실패하였습니다. 관리자에게 문의해주세요.";
				break;
			}
		}
		
		model.addAttribute("error", error);
		model.addAttribute("exception", msg);
		return "login/login";
	}
	
	//회원가입 페이지
	@GetMapping("/join")
	public String join() {
		return "login/join";
	}
	
	//회원가입
	@PostMapping("/join")
	@ResponseBody
	public void joinMember() {
	}
	
	//카카오 로그인
	@GetMapping("/login/kakao")
	public String kakaoLogin() {
		return "redirect:"+keysJaewon.getKakaoLoginUrl();
	}
	
	//네이버 로그인
	@GetMapping("/login/naver")
	public String naverLogin() {
		return "redirect:"+keysJaewon.getNaverLoginUrl();
	}
	
}
