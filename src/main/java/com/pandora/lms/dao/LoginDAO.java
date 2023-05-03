package com.pandora.lms.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.pandora.lms.dto.AdminInfoDto;
import com.pandora.lms.dto.LoginDTO;
import com.pandora.lms.dto.UserInfoDto;
@Mapper
@Repository
public interface LoginDAO {

    LoginDTO login(LoginDTO loginInfo);

    String instrNo(int userNo);

    String applNo(int userNo);

	UserInfoDto findByUsername(String username);

	int getAPPL(int userNo);

	int getINSTR(int userNo);

	int save(UserInfoDto userInfoDto);

	AdminInfoDto findByAdminname(String username);
}
