package com.pandora.lms.dao;

import com.pandora.lms.dto.LoginDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
@Mapper
@Repository
public interface LoginDAO {

    LoginDTO login(LoginDTO loginInfo);

    String instrNo(int userNo);

    String applNo(int userNo);
}
