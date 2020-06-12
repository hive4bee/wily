package org.coffee.websocket;

import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import org.springframework.util.StringUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class ReplyEchoHandler extends TextWebSocketHandler {
	//List<WebSocketSession> sessions = new ArrayList<>();
	Map<String, WebSocketSession> userSessions = new HashMap();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//서버에 접속이 시도될 때마다 
		System.out.println("afterConnectionEstablished.... : " + session);
		//sessions.add(session);
		String senderId = getId(session);
		userSessions.put(senderId, session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		//소켓에 메시지를 보낼 때마다
		System.out.println("handleTextMessage : " + session + " : " + message);
		//String senderId = session.getId();
		//for(WebSocketSession sess: sessions) {
		//	sess.sendMessage(new TextMessage(senderId + " : " + message.getPayload()));
		//}
		//String senderId = getId(session);
		//예) protocol : cmd, 댓글 작성자, 게시글 작성자, bno (reply, user2, user1, 10)
		String msg = message.getPayload();
		if(!StringUtils.isEmpty(msg)) {
			StringTokenizer token = new StringTokenizer(msg,"|");
			String protocol = token.nextToken();
			if(protocol != null && protocol.equals("admin")) {
				System.out.println("아니 뭔데 : " + protocol);
				WebSocketSession adminSession = userSessions.get(protocol);
				TextMessage tmp = new TextMessage("100|"+token.nextToken());
				adminSession.sendMessage(tmp);
			}
			if(protocol != null && protocol.equals("200")) {
				String userId = token.nextToken();
				String onum = token.nextToken();
				WebSocketSession userSession = userSessions.get(userId);
				TextMessage tmp = new TextMessage("300|"+onum);
				userSession.sendMessage(tmp);
			}
		}
		
		
//		String[] strs=msg.split(",");
//		for(int i = 0; i<strs.length; i++) {
//			System.out.println("=============="+strs[i]);
//		}
//		if(!StringUtils.isEmpty(msg)) {
//			if(strs!=null && strs[0].equals("admin")) {
//				WebSocketSession admin = userSessions.get(strs[0]);
//				TextMessage tmp = new TextMessage("100|"+strs[1]);
//				admin.sendMessage(tmp);
//			}
//			if(strs!=null && strs[0].equals("200")) {
//				if(userSessions.containsKey(strs[1])) {
//					WebSocketSession mid = userSessions.get(strs[1]);
//					TextMessage tmp = new TextMessage("300|"+strs[2]);
//					mid.sendMessage(tmp);
//				}
//			}
//		}
		
		//아래의 set ~ while은 접속한 모든 유저에게 메시지를 전송한다.
//		Set users = userSessions.keySet();
//		Iterator it = users.iterator();
//		while(it.hasNext()) {
//			String user = (String)it.next();
//			System.out.println("////////////////user : " + user);
//			userSessions.get(user).sendMessage(new TextMessage(user+" : " + msg));
//		}
		
		//참고용
//		if(!StringUtils.isEmpty(msg)) {
//			String[] strs = msg.split(",");
//			if(strs != null && strs.length==4) {
//				String cmd = strs[0];
//				String replyWriter = strs[1];
//				String boardWriter = strs[2];
//				String bno = strs[3];
//				
//				WebSocketSession boardWriterSession = userSessions.get(boardWriter);
//				if("reply".contentEquals(cmd) && boardWriterSession != null) {
//					TextMessage tmpMsg = new TextMessage(replyWriter+"님이 " + bno + "번 게시글에 댓글을 달았습니다.");
//					boardWriterSession.sendMessage(tmpMsg);
//				}
//			}
//		}
	}
	private String getId(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();//모두 실어서 맵으로 뿌려줌
		String loginUser = (String)httpSession.get("mid");
		if(loginUser == null) {
			return session.getId();
		}else {
			return loginUser;
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		//종료되었을 때마다
		System.out.println("afeterConnectionClosed : " + session + " : " + status);
		String senderId = getId(session);
		userSessions.remove(senderId);
	}
}
