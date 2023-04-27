package com.pandora.lms.util.socket;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

public class AlarmHandler extends TextWebSocketHandler {

    private final Set<WebSocketSession> sessions = ConcurrentHashMap.newKeySet();
    //session 객체를 set 컬렉션으로 관리함, 저장 모든 사용자에게 메시지 전달가능하게 함

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        System.out.println(message.getPayload());
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        sessions.add(session);
        System.err.println("추가 세션 : "+session);
        System.err.println("현재 세션들 : "+sessions);
        System.out.println("공지알람 세션이 연결되었습니다.");
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessions.remove(session);
        System.out.println("공지알람 세션이 종료되었습니다.");
    }
    public void sendNotification(String notification) throws IOException{
        for (WebSocketSession session : sessions) {
            session.sendMessage(new TextMessage(notification));
        }
    }
    public void sendMessage(String message) throws IOException{
        for (WebSocketSession session : sessions) {
            session.sendMessage(new TextMessage(message));
        }
    }


}