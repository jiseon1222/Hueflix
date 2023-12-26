package com.human.service;

import com.human.dto.UsersDto;

public interface UsersService {
	void insertUser(UsersDto dto) throws Exception;
	UsersDto getUserByEmail(String userEmail) throws Exception;
	String getUserNick(String userEmail) throws Exception;
	String getUserProfile(String userEmail) throws Exception;
	void updatePw(UsersDto dto) throws Exception;
	void updateNickname(UsersDto dto) throws Exception;
	void deleteUser(String userEmail, String pw) throws Exception;
	int checkEmail(String userEmail) throws Exception;
	int checkNickname(String nickname) throws Exception;
}
