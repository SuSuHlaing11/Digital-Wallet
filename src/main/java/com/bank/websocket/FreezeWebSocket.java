package com.bank.websocket;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;

@ServerEndpoint("/freezeStatus")
public class FreezeWebSocket {

    // A map to hold the connected sessions (users)
    private static final ConcurrentHashMap<String, Session> sessions = new ConcurrentHashMap<>();
    
    @OnOpen
    public void onOpen(Session session) {
        String query = session.getQueryString();

        if (query != null && query.startsWith("userId=")) {
            String userId = query.substring(7); 
            sessions.put(userId, session); 
            System.out.println("New connection: userId=" + userId);
        } else {
            System.out.println("Invalid WebSocket connection attempt.");
        }
    }

    @OnClose
    public void onClose(Session session) {
        // Remove the session when the connection is closed
        sessions.values().remove(session);
        System.out.println("Connection closed.");
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        // Optionally handle incoming messages here (not used in this case)
    }

    public static void notifyUser(String userId, String status) {
        Session session = sessions.get(userId); // Get the session for the user
        if (session != null && session.isOpen()) {
            try {
                System.out.println("Sending message to user: " + userId + " - " + status);
                session.getBasicRemote().sendText(status); // Send the status ("frozen" or "unfrozen")
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("User " + userId + " is not connected or session is closed.");
        }
    }

}
