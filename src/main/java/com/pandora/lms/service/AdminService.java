package com.pandora.lms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pandora.lms.dao.AdminDAO;
import com.pandora.lms.dto.AdminDTO;
import com.pandora.lms.dto.SearchDTO;

@Service
public class AdminService {
	
	@Autowired
	AdminDAO adminDAO;

	public List<AdminDTO> searchList(SearchDTO search) {
		return adminDAO.searchList(search);
	}
}
