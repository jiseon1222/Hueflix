package com.human.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.human.dto.CommentDto;
import com.human.vo.PageMaker;

public interface CommentService {
	public void insert(CommentDto comment) throws Exception;

	public void update(CommentDto comment) throws Exception;

	public void delete(Integer rId) throws Exception;

	public List<CommentDto> list(int rId) throws Exception;

	public List<CommentDto> listCommentPage(@Param("movieId") Integer movieId, @Param("pm") PageMaker pm)
			throws Exception;

	public int count(Integer movieId) throws Exception;
}
