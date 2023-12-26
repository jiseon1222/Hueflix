package com.human.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.human.dao.AuthoritiesDao;
import com.human.dto.AuthoritiesDto;

@Service
public class AuthoritiesServiceImpl implements AuthoritiesService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	@Transactional
	public void insert(String userEmail) throws Exception {
		AuthoritiesDao dao = sqlSession.getMapper(AuthoritiesDao.class);
		dao.insert(userEmail);
	}

	@Override
	public ArrayList<AuthoritiesDto> selectAll() throws Exception {
		AuthoritiesDao dao = sqlSession.getMapper(AuthoritiesDao.class);
		return dao.selectAll();
	}

	@Override
	public String selectUser(String userEmail) throws Exception {
		AuthoritiesDao dao = sqlSession.getMapper(AuthoritiesDao.class);
		return dao.selectUser(userEmail);
	}
	
	@Override
	@Transactional
	public void update(String newAuthority, String userEmail) throws Exception {
		AuthoritiesDao dao = sqlSession.getMapper(AuthoritiesDao.class);
		dao.update(newAuthority, userEmail);
	}
	
	@Override
	@Transactional
	public void delete(String userEmail) throws Exception {
		AuthoritiesDao dao = sqlSession.getMapper(AuthoritiesDao.class);
		dao.delete(userEmail);
	}
}
