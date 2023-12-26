package com.human.ex;

import java.util.List;

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

import com.human.dto.BoardDto;
import com.human.service.BoardService;
import com.human.service.UsersService;
import com.human.vo.PageMaker;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
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
        System.out.println(uService.getUserNick(userEmail));
        model.addAttribute("profile_img", uService.getUserProfile(userEmail));

    }
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private BoardService bs;
	
	@RequestMapping(value="/BoardWrite", method = RequestMethod.GET)
	public void insertGET(BoardDto board, Model model) throws Exception {
		// 로그 메시지 출력
		logger.info("insert get....");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userEmail = authentication.getName();
		model.addAttribute("userEmail", userEmail);
	    model.addAttribute("nickname", uService.getUserNick(userEmail));
		System.out.println(uService.getUserNick(userEmail));
	}
	
	@RequestMapping(value="/BoardWrite", method = RequestMethod.POST)
	public String insertPOST(BoardDto board, Model model, RedirectAttributes rttr) throws Exception {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userEmail = authentication.getName();
		System.out.println(uService.getUserNick(userEmail));
		model.addAttribute("userEmail", userEmail);
	    model.addAttribute("nickname", uService.getUserNick(userEmail));
		logger.info("insert post....");
		logger.info(board.toString());
		bs.insertBoard(board);
		
		// 리다이렉트 후 메시지 전달
		rttr.addFlashAttribute("msg", "success");
		return "redirect:/board/notice";
	}
	
	@RequestMapping(value = "/notice", method = RequestMethod.GET)
	public void notice(@RequestParam(value="bGroupKind", required=false) String bGroupKind, PageMaker pm, Model model) throws Exception {
		logger.info("show list by groupkind: " + bGroupKind);
		
		if(bGroupKind == null) {
			List<BoardDto> searchList = bs.listSearchCriteria(pm);
			model.addAttribute("list", searchList);
		} else {
			model.addAttribute("list", bs.selectByGroupKind(bGroupKind));
			List<BoardDto> searchList = bs.listSearchCriteria(pm);
			model.addAttribute("list", searchList);
		}
		
		
		// 페이징된 게시판 목록 정보 추가
		pm.setTotalCount(bs.listSearchCount(pm));
		// 뷰 데이터 목록 출력
		model.addAttribute("bGroupKind", pm.getbGroupKind());
		model.addAttribute("page", pm.getPage());
		model.addAttribute("perPageNum", pm.getPerPageNum());
		model.addAttribute("searchType", pm.getSearchType());
		model.addAttribute("keyword", pm.getKeyword());
		model.addAttribute("categoryType", pm.getCategoryType());
		
		
	}
	//게시글 읽기정보
	@RequestMapping(value="/BoardRead", method = RequestMethod.GET)
	public void read(@RequestParam("bid")int bid, Model model) throws Exception {
		logger.info("read............." + bid);
		BoardDto board = bs.readBoard(bid);
		bs.bHit(bid);
		model.addAttribute(bs.readBoard(bid));
	}
	
	@RequestMapping(value="/BoardMod", method = RequestMethod.GET)
	public void updateGET(@RequestParam("bid") int bid,Model model) throws Exception {
		model.addAttribute(bs.readBoard(bid));
	}
	
	@RequestMapping(value="/BoardMod", method = RequestMethod.POST)
	public String updatePOST(BoardDto board,RedirectAttributes rttr) throws Exception {
		logger.info("modify post.....");
		bs.updateBoard(board);
		rttr.addFlashAttribute("msg", "success");
		return "redirect:/board/notice";
	}
	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public String remove(@RequestParam("bid") int bid, RedirectAttributes rttr) throws Exception {
		bs.delete(bid);
		rttr.addFlashAttribute("msg", "success");
		return "redirect:/board/notice";
		
	}
	@RequestMapping(value = "/bHitUpdate", method = RequestMethod.GET)
	public String bHitUpdate(@RequestParam("bid") int bid, RedirectAttributes rttr) throws Exception {
		bs.bHit(bid);
		rttr.addFlashAttribute("msg", "success");
		return "redirect:/board/notice";
	}
}
