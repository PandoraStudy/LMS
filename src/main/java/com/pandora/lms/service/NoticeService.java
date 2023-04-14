package com.pandora.lms.service;

import com.pandora.lms.dao.NoticeDAO;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Map;

@AllArgsConstructor
@Service
public class NoticeService {

    private final NoticeDAO noticeDAO;

    public int noticeCount(Map<String, Object> pages) { return noticeDAO.noticeCount(pages); }
}
