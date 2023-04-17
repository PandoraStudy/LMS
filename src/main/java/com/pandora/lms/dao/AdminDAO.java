package com.pandora.lms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.pandora.lms.dto.AdminDTO;
import com.pandora.lms.dto.SearchDTO;

@Repository
@Mapper
public interface AdminDAO {
	
	public List<AdminDTO> searchList(SearchDTO search);

}
