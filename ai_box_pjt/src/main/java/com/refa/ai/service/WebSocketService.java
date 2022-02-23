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
			// ����Ʈ�� �ִ� ���ǰ� �޽����� ���� ������ ������ �޽��� �۽��� �ʿ����.
			try {				
				// ����Ʈ�� �ִ� ��� ����(�޽��� ���� ���� ����)�� �޽����� ������. (����: ������ => �޽���)
				//session.getBasicRemote().sendText(username + " => " + msg);
		    	session.sendMessage(message);

			} catch (IOException e) {				
				// ������ �߻��ϸ� �ֿܼ� ǥ���Ѵ�.
				e.printStackTrace();				
			}
		}
    }

    public void sendDifferentMessage(WebSocketSession session, TextMessage message, WebSocketSession userSession) {
		if (!session.getId().contains(userSession.getId())) {
			// ����Ʈ�� �ִ� ���ǰ� �޽����� ���� ������ ������ �޽��� �۽��� �ʿ����.
			try {				
				// ����Ʈ�� �ִ� ��� ����(�޽��� ���� ���� ����)�� �޽����� ������. (����: ������ => �޽���)
				//session.getBasicRemote().sendText(username + " => " + msg);
		    	session.sendMessage(message);

			} catch (IOException e) {				
				// ������ �߻��ϸ� �ֿܼ� ǥ���Ѵ�.
				e.printStackTrace();				
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
