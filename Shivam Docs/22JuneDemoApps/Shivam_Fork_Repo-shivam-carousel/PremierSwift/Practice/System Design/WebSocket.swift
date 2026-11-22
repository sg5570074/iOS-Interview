//
//  WebSocket.swift
//  PremierSwift
//
//  Created by Shivam Gupta on 31/12/25.
//  Copyright © 2025 Deliveroo. All rights reserved.
//

import Foundation

// https://chatgpt.com/c/6943e272-1134-8331-a11f-46eff6b19b9b

class WebSocketManager {
    private var webSocketTask: URLSessionWebSocketTask?
    private let urlSession: URLSession
    private let url: URL
    private var isConnected = false

    init(url: URL) {
        self.url = url
        self.urlSession = URLSession(configuration: .default)
    }

    func connect() {
        webSocketTask = urlSession.webSocketTask(with: url)
        webSocketTask?.resume()
        isConnected = true
        listenForMessages()
        print("🔌 WebSocket connected.")
    }

    func disconnect() {
        isConnected = false
        webSocketTask?.cancel(with: .goingAway, reason: nil)
        print("❌ WebSocket disconnected.")
    }

    func send(message: String) {
        let msg = URLSessionWebSocketTask.Message.string(message)
        webSocketTask?.send(msg) { error in
            if let error = error {
                print("❗️Failed to send message: \(error)")
            }
        }
    }

    private func listenForMessages() {
        webSocketTask?.receive { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let message):
                switch message {
                case .string(let text):
                    print("📩 Received: \(text)")
                case .data(let data):
                    print("📦 Received binary data: \(data)")
                @unknown default:
                    print("⚠️ Unknown message type")
                }
                // Keep listening
                if self.isConnected {
                    self.listenForMessages()
                }
            case .failure(let error):
                print("❗️Failed to receive message: \(error)")
                self.reconnect()
            }
        }
    }

    private func reconnect() {
        // Simple retry logic
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            print("🔄 Reconnecting...")
            self.connect()
        }
    }
}


//MARK: Usage

let webSocketURL = URL(string: "wss://example.com/live/delivery/123")!
let socketManager = WebSocketManager(url: webSocketURL)

class WebSockUsage {

    init() {
        socketManager.connect()
    }

    func sendMessage() {
        // To send:
        socketManager.send(message: "{\"lat\":23.0,\"lng\":77.0}")
    }

    func disconnect() {
        // To disconnect:
        socketManager.disconnect()
    }
}



//Notification
let payload = """
{
    "aps": {
        "alert": {
              "title": "Order Update",
              "body": "Your order is out for delivery"
            },
        "badge": 5,
        "sound": "default"
    },
    "type": "ORDER_STATUS",
    "entityId": "ORD123",
    "deeplink": "myapp://order/ORD123"
}
"""

//8️⃣ Silent Notification (Background Sync)
let silentPayload = """
{
  "aps": {
    "content-available": 1
  },
  "type": "SYNC"
}
"""
