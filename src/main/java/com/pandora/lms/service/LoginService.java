package com.pandora.lms.service;

import com.pandora.lms.dao.LoginDAO;
import com.pandora.lms.dto.LoginDTO;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
@AllArgsConstructor
@Service
public class LoginService {

    private final LoginDAO loginDAO;
    public LoginDTO login(LoginDTO loginInfo) {
        return loginDAO.login(loginInfo);
    }

    public String instrNo(int userNo) { return loginDAO.instrNo(userNo); }
}
