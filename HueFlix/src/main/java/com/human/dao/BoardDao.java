package com.human.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.human.dto.BoardDto;
import com.human.vo.PageMaker;

public interface BoardDao {
	// 게시판 등록
	public void insertBoard(BoardDto board) throws Exception;
	// 게시판 읽기
	public BoardDto readBoard(Integer bid) throws Exception;
	// 게시판 수정
	public void updateBoard(BoardDto board) throws Exception;
	// 게시판 삭제
	public void delete(Integer bid) throws Exception;
	// 게시판 목록
	public List<BoardDto> listAll() throws Exception;
	// 게시판 조회수
	public void bHit(int bid) throws Exception;
	// 게시판 목록검색(페이징)
	public List<BoardDto> listSearch(PageMaker pm) throws Exception;
	public int listSearchCount(PageMaker pm) throws Exception;
	
	// 카테고리별 검색
	public List<BoardDto> selectByGroupKind(@Param("bGroupKind")String bGroupKind) throws Exception;
}
