package com.human.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.human.dao.UsersDao;
import com.human.dto.UsersDto;


@Service
public class UsersServiceImpl implements UsersService {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
    PasswordEncoder pwEncoder;
	
	@Autowired
	private AuthoritiesService aService;

	@Override
	@Transactional
	public void insertUser(UsersDto uDto) throws Exception {
		UsersDao uDao = sqlSession.getMapper(UsersDao.class);
		String encPw = pwEncoder.encode(uDto.getPw());
		uDto.setPw(encPw);
		uDao.insertUser(uDto);
		aService.insert(uDto.getUserEmail());
	}

	@Override
	@Transactional
	public UsersDto getUserByEmail(String userEmail) throws Exception {
		UsersDao uDao = sqlSession.getMapper(UsersDao.class);
		return uDao.getUserByEmail(userEmail);
	}
	
	@Override
	@Transactional
	public int checkEmail(String userEmail) throws Exception {
		UsersDao uDao = sqlSession.getMapper(UsersDao.class);
		return uDao.checkEmail(userEmail);
	}
	
	@Override
	@Transactional
	public int checkNickname(String nickname) throws Exception {
		UsersDao uDao = sqlSession.getMapper(UsersDao.class);
		return uDao.checkNickname(nickname);
	}
	
	@Override
	@Transactional
	public String getUserNick(String userEmail) throws Exception {
		UsersDao uDao = sqlSession.getMapper(UsersDao.class);
		return uDao.getUserNick(userEmail);
	}
	
	@Override
	@Transactional
	public String getUserProfile(String userEmail) throws Exception {
		UsersDao uDao = sqlSession.getMapper(UsersDao.class);
		return uDao.getUserProfile(userEmail);
	}
	
	@Override
	@Transactional
	public void updatePw(UsersDto dto) throws Exception {
		UsersDao uDao = sqlSession.getMapper(UsersDao.class);
		String encPw = pwEncoder.encode(dto.getPw());
		dto.setPw(encPw);
		uDao.updatePw(dto);
	}
	
	@Override
	@Transactional
	public void updateNickname(UsersDto dto) throws Exception {
		UsersDao uDao = sqlSession.getMapper(UsersDao.class);
		uDao.updateNickname(dto);
	}
	
	@Override
	@Transactional
	public void deleteUser(String userEmail, String pw) throws Exception {
		UsersDao uDao = sqlSession.getMapper(UsersDao.class);
		uDao.deleteUser(userEmail, pw);
	}
}
