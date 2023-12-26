package com.human.ex;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.human.service.AuthoritiesService;
import com.human.service.UsersService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	private UsersService uService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) throws Exception {
		// 현재 인증된 사용자의 정보 가져오기
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        // 인증된 사용자의 권한 가져오기
        String userRole = authentication.getAuthorities().toString();
        // 로그인 여부 확인
        boolean loggedIn = !authentication.getName().equals("anonymousUser");
        // 로그인한 유저 아이디
        String userEmail = authentication.getName();
       
        // 모델에 추가
        model.addAttribute("loggedIn", loggedIn);
        model.addAttribute("userRole", userRole);
        model.addAttribute("userEmail", userEmail);
        model.addAttribute("nickname", uService.getUserNick(userEmail));
        model.addAttribute("profile_img", uService.getUserProfile(userEmail));
        
		return "main/main";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(Model model) {
		return "/login/login";
	}

}
