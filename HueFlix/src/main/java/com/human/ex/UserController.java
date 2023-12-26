package com.human.ex;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.human.dto.UsersDto;
import com.human.service.UsersService;


@Controller
public class UserController {	
	@Autowired
	private UsersService uService;
	
	@Autowired
    PasswordEncoder pwEncoder;
	
	/* 회원 가입 */
	@RequestMapping(value = "register/process", method = RequestMethod.POST)
	public String join(UsersDto uDto, RedirectAttributes rttr) throws Exception {
		uService.insertUser(uDto);
		rttr.addFlashAttribute("msg","success");
		return "redirect:/login";
	}
	
	/* 이메일 중복 체크 (보안 상 post사용) */
	@RequestMapping(value = "register/process/checkEmail", method = RequestMethod.POST)
	@ResponseBody
	public int checkEmail(@RequestBody String userEmail) throws Exception {
		int count = uService.checkEmail(userEmail);
		return count;
	}
	
	/* 닉네임 중복 체크  (보안 상 post사용) */
	@RequestMapping(value = "register/process/checkNickname", method = RequestMethod.POST)
	@ResponseBody
	public int checkNickname(@RequestBody String nickname) throws Exception {
		int count = uService.checkNickname(nickname);
		return count;
	}
	
	/* 회원 정보 진입 전 비밀번호 입력창 */
	@RequestMapping(value = "/member", method = RequestMethod.GET)
	public String pwCheck(Model model) throws Exception {
		/* 헤더에 프로필을 표시하기 위해 인증정보 주입 */
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String userRole = authentication.getAuthorities().toString();
        boolean loggedIn = !authentication.getName().equals("anonymousUser");    
        String userEmail = authentication.getName();
        
        model.addAttribute("loggedIn", loggedIn);
        model.addAttribute("userRole", userRole);
        model.addAttribute("userEmail", userEmail);
        model.addAttribute("nickname", uService.getUserNick(userEmail));
        model.addAttribute("profile_img", uService.getUserProfile(userEmail));
        
		return "/member/pwCheck";
	}
	
	/* 입력한 비밀번호가 사용자의 비밀번호와 일치하는지 확인 */
    @RequestMapping(value = "/member/checkPassword", method = RequestMethod.POST)
    public String checkPassword (@RequestParam("pw") String password, 
                                @RequestParam("userEmail") String userEmail,
                                RedirectAttributes redirectAttributes) throws Exception {
        UsersDto user = uService.getUserByEmail(userEmail); // 데이터베이스에서 사용자 정보 가져오기

        // 입력한 비밀번호와 사용자의 저장된 비밀번호 비교
        if (user != null && pwEncoder.matches(password, user.getPw())) {
            // 비밀번호가 일치하면 수정 페이지로 리다이렉트
            return "redirect:/member/editMyInfo";
        } else {
            // 비밀번호가 일치하지 않으면 오류 메시지 추가 후 비밀번호 확인 페이지로 리다이렉트
            redirectAttributes.addFlashAttribute("error", "비밀번호가 일치하지 않습니다.");
            return "redirect:/member";
        }
    }
    
    /* 회원 정보 수정창 */
	@RequestMapping(value = "/member/editMyInfo", method = RequestMethod.GET)
	public String editUser(Model model) throws Exception {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String userRole = authentication.getAuthorities().toString();
        boolean loggedIn = !authentication.getName().equals("anonymousUser");    
        String userEmail = authentication.getName();
        
        UsersDto user = uService.getUserByEmail(userEmail);
        
        model.addAttribute("loggedIn", loggedIn);
        model.addAttribute("userRole", userRole);
        model.addAttribute("userEmail", userEmail);
        model.addAttribute("nickname", uService.getUserNick(userEmail));
        model.addAttribute("profile_img", uService.getUserProfile(userEmail));
        model.addAttribute("regdate", user.getRegdate());
        
		return "/member/editMyInfo";
	}
	
	@RequestMapping(value = "/member/editMyInfo", method = RequestMethod.POST)
	public String updateDB(UsersDto dto,RedirectAttributes rttr) throws Exception{
		uService.updateNickname(dto);
		uService.updatePw(dto);
		System.out.println(dto);
		rttr.addFlashAttribute("msg","success");
		return "redirect:/";
	}
}
