package com.pandora.lms.service;

import com.pandora.lms.dto.ZoomDTO;
import org.springframework.stereotype.Service;

import java.io.IOException;

@Service
public interface ZoomService {


    String meeting(String accessToken) throws IOException;

    ZoomDTO authority(ZoomDTO zoomDTO);


    void join_url(ZoomDTO zoomDTO);

    void meeting_msg(ZoomDTO zoomDTO);
}