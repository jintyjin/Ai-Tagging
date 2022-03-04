package com.refa.ai.service;

import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.refa.ai.dto.websocket.RfStartUpDto;
import com.refa.ai.infra.AES256Util;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class WebSocketService {
	
	private final AES256Util aES256Util;

    public void sendMessage(WebSocketSession session, TextMessage message) {
        try {
            session.sendMessage(message);
        } catch (IOException e) {
        	System.out.println(e.getMessage());
        }
    }

    public void sendEqualMessage(WebSocketSession session, TextMessage message, WebSocketSession userSession) {
		if (session.getId().contains(userSession.getId())) {
			// 리스트에 있는 세션과 메시지를 보낸 세션이 같으면 메시지 송신할 필요없다.
			try {				
				// 리스트에 있는 모든 세션(메시지 보낸 유저 제외)에 메시지를 보낸다. (형식: 유저명 => 메시지)
				//session.getBasicRemote().sendText(username + " => " + msg);
		    	session.sendMessage(message);

			} catch (IOException e) {				
				// 에러가 발생하면 콘솔에 표시한다.
				System.out.println("sendEqualMessage Error");
			}
		}
    }

    public void sendDifferentMessage(WebSocketSession session, TextMessage message, WebSocketSession userSession) {
		if (!session.getId().contains(userSession.getId())) {
			// 리스트에 있는 세션과 메시지를 보낸 세션이 같으면 메시지 송신할 필요없다.
			try {				
				// 리스트에 있는 모든 세션(메시지 보낸 유저 제외)에 메시지를 보낸다. (형식: 유저명 => 메시지)
				//session.getBasicRemote().sendText(username + " => " + msg);
		    	session.sendMessage(message);

			} catch (IOException e) {				
				// 에러가 발생하면 콘솔에 표시한다.
				System.out.println("sendDifferentMessage Error");		
			}
		}
    }

	public RfStartUpDto getAes256Lkey() {
		// TODO Auto-generated method stub

		RfStartUpDto rfStartUpDto = new RfStartUpDto();
		
		String lkey = "";
		String aes256Key = aES256Util.getKeyString() + aES256Util.getIvString();
		for (String key : aes256Key.split("")) {
			lkey += "00" + key;
		}
		
		rfStartUpDto.setCommand("RF_STARTUP");
		rfStartUpDto.setSender("web");
		rfStartUpDto.setVer("2.1");
		rfStartUpDto.setLkey(lkey);
		rfStartUpDto.setStatus("success");
		
		return rfStartUpDto;
		
	}
}
