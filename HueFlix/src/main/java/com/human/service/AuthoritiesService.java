package com.human.service;

import java.util.ArrayList;

import com.human.dto.AuthoritiesDto;

public interface AuthoritiesService {
	void insert(String userEmail) throws Exception;
	ArrayList<AuthoritiesDto> selectAll() throws Exception;
	String selectUser(String userEmail) throws Exception;
	void update(String newAuthority, String userEmail) throws Exception;
	void delete(String userEmail) throws Exception;
}
