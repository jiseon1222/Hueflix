package com.human.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.dao.BoardDao;
import com.human.dto.BoardDto;
import com.human.vo.PageMaker;
@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertBoard(BoardDto board) throws Exception {
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		dao.insertBoard(board);
	}

	@Override
	public BoardDto readBoard(Integer bId) throws Exception {
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		return dao.readBoard(bId);
	}

	@Override
	public void updateBoard(BoardDto board) throws Exception {
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		dao.updateBoard(board);
	}

	@Override
	public void delete(Integer bId) throws Exception {
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		dao.delete(bId);
	}

	@Override
	public List<BoardDto> listAll() throws Exception {
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		return dao.listAll();
	}

	@Override
	public void bHit(int bId) throws Exception {
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		dao.bHit(bId);
	}

	@Override
	public List<BoardDto> listSearch(PageMaker pm) throws Exception {
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		return dao.listSearch(pm);
	}

	@Override
	public int listSearchCount(PageMaker pm) throws Exception {
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		return dao.listSearchCount(pm);
	}

	@Override
	public List<BoardDto> listSearchCriteria(PageMaker pm) throws Exception {
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		return dao.listSearch(pm);
	}

	@Override
	public List<BoardDto> selectByGroupKind(String bGroupKind) throws Exception {
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		return dao.selectByGroupKind(bGroupKind);
	}
	
	
}
