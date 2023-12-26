package com.human.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.dao.CommentDao;
import com.human.dto.CommentDto;
import com.human.vo.PageMaker;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(CommentDto comment) throws Exception {
		CommentDao dao = sqlSession.getMapper(CommentDao.class);
		dao.insert(comment);
	}

	@Override
	public void update(CommentDto comment) throws Exception {
		CommentDao dao = sqlSession.getMapper(CommentDao.class);
		dao.update(comment);
	}

	@Override
	public void delete(Integer rId) throws Exception {
		CommentDao dao = sqlSession.getMapper(CommentDao.class);
		dao.delete(rId);
	}

	@Override
	public List<CommentDto> list(int movieId) throws Exception {
		CommentDao dao = sqlSession.getMapper(CommentDao.class);
		return dao.list(movieId);
	}

	@Override
	public List<CommentDto> listCommentPage(Integer movieId, PageMaker pm) throws Exception {
		CommentDao dao = sqlSession.getMapper(CommentDao.class);
		return dao.listCommentPage(movieId, pm);
	}

	@Override
	public int count(Integer movieId) throws Exception {
		CommentDao dao = sqlSession.getMapper(CommentDao.class);
		return dao.count(movieId);
	}

}
