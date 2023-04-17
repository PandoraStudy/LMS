package com.pandora.lms.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pandora.lms.dto.UserDTO;

@Repository
public class loginDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public UserDTO checkID(String user_name) {
		
		return sqlSession.selectOne("checkID" , user_name);
		}

	public int signup(UserDTO userdto) {
		return sqlSession.insert("signup", userdto);
		
	}

}
