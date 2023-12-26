package com.human.dao;

import org.apache.ibatis.annotations.Param;

import com.human.dto.UsersDto;

public interface UsersDao {
	void insertUser(UsersDto dto) throws Exception;
	UsersDto getUserByEmail(String userEmail) throws Exception;
	String getUserNick(String userEmail) throws Exception;
	String getUserProfile(String userEmail) throws Exception;
	int checkEmail(String userEmail) throws Exception;
	int checkNickname(String nickname) throws Exception;
	void updatePw(UsersDto dto) throws Exception;
	void updateNickname(UsersDto dto) throws Exception;
	void deleteUser(@Param("userEmail") String userEmail, @Param("pw") String pw) throws Exception;
	
}
