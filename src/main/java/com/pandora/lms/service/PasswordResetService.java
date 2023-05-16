package com.pandora.lms.service;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pandora.lms.dto.UserDTO;
import com.pandora.lms.dto.UserInfoDto;

@Service
public class PasswordResetService {
    
    @Autowired
    private LoginService userService;
    
    
    public void sendPasswordResetEmail(String newpwrd , String ID) {
        // 사용자 이메일로 사용자 정보를 조회합니다.
        UserInfoDto user = userService.updatePwrd(ID, newpwrd);
        
    }

}
