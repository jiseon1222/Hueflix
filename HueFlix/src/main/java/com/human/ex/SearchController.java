package com.human.ex;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.human.service.UsersService;

@Controller
public class SearchController {
	
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
	
    @RequestMapping(value = "/searchpage", method = RequestMethod.GET)
    public String showSearchPage() {
        return "searchpage";
    }

    @RequestMapping(value = "/movie.do", method = RequestMethod.GET)
    public String movie(@RequestParam(required = false) String command) {
        if ("searchpage".equals(command)) {
            return "redirect:/searchpage.jsp";
        } else {
            return "error"; 
        }
    }
    
    @RequestMapping(value = "/movieDetail", method = RequestMethod.GET)
    public String movieDetail(@RequestParam("movieId") int movieId, Model model) {
		model.addAttribute("movieId", movieId);
        return "movieDetail";
    }
}