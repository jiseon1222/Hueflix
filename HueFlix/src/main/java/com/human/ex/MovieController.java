package com.human.ex;

import java.util.List;

import javax.inject.Inject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.human.service.UsersService;

// 컨트롤러 역할
// 이 어노테이션이 붙은 클래스를 검색하여 빈으로 등록하고 웹 요청에 대한 처리 담당하는 컨트롤러
@Controller
// 특정 URL에 대한 요청을 처리하는 메서드 지정
// 주로 HTTP 요청 메소드(GET, POST) 등 경로 지정하여 요청 처리할지 정의

public class MovieController {
	@Autowired
	private UsersService uService;
	
	@ModelAttribute
    public void setUserInfoInModel(Model model) throws Exception {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String userRole = authentication.getAuthorities().toString();
        boolean loggedIn = !authentication.getName().equals("anonymousUser");
        String userEmail = authentication.getName();

        model.addAttribute("loggedIn", loggedIn);
        model.addAttribute("userRole", userRole);
        model.addAttribute("userEmail", userEmail);
        model.addAttribute("nickname", uService.getUserNick(userEmail));
        model.addAttribute("profile_img", uService.getUserProfile(userEmail));

    }
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main() {
		return "/main";
	}

	@RequestMapping(value = "/board/nowPlaying", method = RequestMethod.GET)
	public String nowPlaying() {
		return "/board/nowPlaying";
	}

	@RequestMapping(value = "/board/upComming", method = RequestMethod.GET)
	public String upComing() {
		return "/board/upComming";
	}

	@RequestMapping(value = "/include/subHeader", method = RequestMethod.GET)
	public String subHeader(@RequestParam("movieId") int movieId, Model model) {
		model.addAttribute("movieId", movieId);
		return "/include/subHeader";
	}

	@RequestMapping(value = "/board/movieDetail/info", method = RequestMethod.GET)
	public String info(@RequestParam("movieId") int movieId, Model model) {
		model.addAttribute("movieId", movieId);
		return "/board/movieDetail/info";
	}

	@RequestMapping(value = "/board/movieDetail/cast", method = RequestMethod.GET)
	public String cast(@RequestParam("movieId") int movieId, Model model) {
		model.addAttribute("movieId", movieId);
		return "/board/movieDetail/cast";
	}

	@RequestMapping(value = "/board/movieDetail/video_photo", method = RequestMethod.GET)
	public String video_photo(@RequestParam("movieId") int movieId, Model model) {
		model.addAttribute("movieId", movieId);
		return "/board/movieDetail/video_photo";
	}

	@RequestMapping(value = "/board/movieDetail/reply", method = RequestMethod.GET)
	public String reply(@RequestParam("movieId") int movieId, Model model) {
		model.addAttribute("movieId", movieId);
		return "/board/movieDetail/reply";
	}

}