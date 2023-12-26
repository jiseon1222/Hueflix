package com.human.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.human.dto.AuthoritiesDto;

public interface AuthoritiesDao {
	void insert(String userEmail) throws Exception;
	ArrayList<AuthoritiesDto> selectAll() throws Exception;
	String selectUser(String userEmail) throws Exception;
	void update(@Param("newAuthority") String newAuthority, @Param("userEmail") String userEmail) throws Exception;
	void delete(String userEmail) throws Exception;
}
