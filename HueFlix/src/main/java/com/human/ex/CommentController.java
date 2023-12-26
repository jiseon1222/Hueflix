package com.human.ex;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.human.dto.CommentDto;
import com.human.service.CommentService;
import com.human.vo.PageMaker;

@RestController
@RequestMapping("/comment")
public class CommentController {
	private static final Logger logger = LoggerFactory.getLogger(CommentController.class);

	@Autowired
	private CommentService cs;

	// 평점/댓글 출력
	@RequestMapping(value = "/{movieId}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> CommentList(@PathVariable("movieId") int movieId,
			@PathVariable("page") int page) {
		ResponseEntity<Map<String, Object>> entity = null;

		try {
			PageMaker pm = new PageMaker();
			pm.setPage(page);

			Map<String, Object> map = new HashMap<String, Object>();
			List<CommentDto> commentList = cs.listCommentPage(movieId, pm);

			map.put("list", commentList);

			int commentCount = cs.count(movieId);
			pm.setTotalCount(commentCount);
			map.put("pageMaker", pm);

			System.out.println("---list pm " + pm);

			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	// 평점/댓글 입력
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> register(@RequestBody CommentDto comment) {
		ResponseEntity<String> entity = null;
		
		try {
			cs.insert(comment);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			System.out.println(comment);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	// 평점/댓글 삭제
	@RequestMapping(value = "/{rid}", method = RequestMethod.DELETE)
	public ResponseEntity<String> remove(@PathVariable("rid") int rid) {
		ResponseEntity<String> entity = null;

		try {
			cs.delete(rid);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
