package com.pandora.lms.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface CheckDAO {

	List<Map<String, Object>> AjaxStudent(Map<String, Object> paramMap);

	

}