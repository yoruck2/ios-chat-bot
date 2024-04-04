//
//  ViewController.swift
//  ChatBot
//
//  Created by Tacocat on 1/1/24.
//

import UIKit

class ViewController: UIViewController {
    let chatService = ChatService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendTestMessage("안녕 만나서 반가워")
    }

    func sendTestMessage(_ message: String) {
        chatService.sendChatRequest(message: message) { result in
            switch result {
            case .success(let response):
                print("Response: \(response)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
