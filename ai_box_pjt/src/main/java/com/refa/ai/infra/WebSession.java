package com.refa.ai.infra;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.refa.ai.service.WebSocketService;

@Component
public class WebSession {

	private List<WebSocketSession> sessionUsers = Collections.synchronizedList(new ArrayList<WebSocketSession>());

	public List<WebSocketSession> getSessioin() {
		return sessionUsers;
	}
	
    public void insertSession(WebSocketSession session) {
    	sessionUsers.add(session);

		System.out.println("client is now connected...");
    }

    public void deleteSession(WebSocketSession session) {
    	sessionUsers.remove(session);

		System.out.println("client is now disconnected...");
    }
    
    public void sendMessage(TextMessage message, WebSocketService webSocketService) {
//    	System.out.println("sendMessage 메시지 = " + message.getPayload());
    	
    	sessionUsers.forEach(session -> webSocketService.sendMessage(session, message));
    }
    
    public void sendEqualMessage(TextMessage message, WebSocketService webSocketService, WebSocketSession userSession) {
//    	System.out.println("sendEqualMessage 메시지 = " + message.getPayload());
    	
    	sessionUsers.forEach(session -> webSocketService.sendEqualMessage(session, message, userSession));
    }
    
    public void sendDifferentMessage(TextMessage message, WebSocketService webSocketService, WebSocketSession userSession) {
//    	System.out.println("sendDifferentMessage 메시지 = " + message.getPayload());
    	
    	sessionUsers.forEach(session -> webSocketService.sendDifferentMessage(session, message, userSession));
    }
}
