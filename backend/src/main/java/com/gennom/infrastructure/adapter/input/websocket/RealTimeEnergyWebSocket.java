package com.gennom.infrastructure.adapter.input.websocket;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class RealTimeEnergyWebSocket {

    @MessageMapping("/live")
    @SendTo("/topic/energy")
    public String sendEnergyData(String message) {
        // AquÃ­ se podrÃ­a transmitir la Ãºltima mediciÃ³n
        return message;
    }
}