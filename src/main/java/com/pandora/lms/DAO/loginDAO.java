package com.pandora.lms.DAO;

import java.util.HashMap;
import java.util.Map;

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

	public int CheckStudent(String user_id, String user_pass) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("param1", user_id);
		params.put("param2", user_pass);
		System.out.println("DAO part = " + user_id + user_pass);
		return sqlSession.selectOne("CheckStudent", params);
	}

}
