package com.human.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.human.dto.BoardDto;
import com.human.vo.PageMaker;

public interface BoardService {
public void insertBoard(BoardDto board) throws Exception;
	
	public BoardDto readBoard(Integer bId) throws Exception;
	
	public void updateBoard(BoardDto board) throws Exception;
	
	public void delete(Integer bId) throws Exception;
	
	public List<BoardDto> listAll() throws Exception;
	
	public void bHit(int bId) throws Exception;
	
	public List<BoardDto> listSearchCriteria(PageMaker pm) throws Exception;
	
	public List<BoardDto> listSearch(PageMaker pm) throws Exception;
	
	public int listSearchCount(PageMaker pm) throws Exception;
	
	public List<BoardDto> selectByGroupKind(@Param("bGroupKind")String bGroupKind) throws Exception;
}
