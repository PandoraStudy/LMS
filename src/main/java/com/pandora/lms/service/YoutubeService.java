package com.pandora.lms.service;

import com.google.api.client.auth.oauth2.Credential;
import org.springframework.web.multipart.MultipartFile;

public interface YoutubeService {
    void uploadVideo(Credential accessToken, MultipartFile videoFile);
}
