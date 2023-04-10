package com.pandora.lms.DAO;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class loginDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public int checkID(String user_name) {
		
		return sqlSession.selectOne("checkID" , user_name);
		}

}
