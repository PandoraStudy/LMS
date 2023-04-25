package com.pandora.lms.util.socket;

import org.json.JSONObject;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

public class SocketHandler extends TextWebSocketHandler {

    private final Set<WebSocketSession> sessions = ConcurrentHashMap.newKeySet();
    //session 객체를 컬렉션으로 관리함, 저장 모든 사용자에게 메시지 전달가능하게 함

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = "{ user : "+message.getPayload()+"}";
        JSONObject json = new JSONObject(payload);
        for (WebSocketSession s : sessions){
            s.sendMessage(new TextMessage("Hi"+json.get("user")+"! How may I Help you?"));
        }
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        sessions.add(session);
        System.out.println("세션 연결 성공했습니다.");
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessions.remove(session);
        System.out.println("세션이 종료 되었습니다.");
    }

}
