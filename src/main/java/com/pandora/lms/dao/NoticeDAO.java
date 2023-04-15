package com.pandora.lms.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Mapper
@Repository
public interface NoticeDAO {

    int noticeCount(Map<String, Object> pages);
}
