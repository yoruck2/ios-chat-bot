//
//  ChatViewModel.swift
//  ChatBot
//
//  Created by nayeon  on 4/15/24.
//

class ChatViewModel {
    
    private let chatService: ChatServiceProtocol
    typealias MessageUpdateHandler = () -> Void
    
    init(chatService: ChatServiceProtocol) {
        self.chatService = chatService
    }
    
    var messages: [MessageDTO] = []
    var messageUpdateHandler: MessageUpdateHandler?

    func sendMessage(_ message: String) {
        // 사용자가 보낸 메시지를 배열에 추가
        let userMessage = MessageDTO(role: .user, content: message)
        self.messages.append(userMessage)
        
        // 메시지 업데이트 핸들러를 호출하여 UI를 업데이트
        self.messageUpdateHandler?()
        
        // ChatService를 사용하여 응답 메시지를 가져옴
        chatService.sendChatRequest(message: message) { [weak self] result in
            switch result {
            case .success(let response):
                // ChatService의 응답에 따라 메시지 배열 업데이트
                for choice in response.choices {
                    // ChoiceDTO에서 MessageDTO를 가져와서 배열에 추가
                    let answerMessage = choice.message
                    self?.messages.append(answerMessage)
                }
                
                // 메시지 업데이트 핸들러를 호출하여 UI를 업데이트
                self?.messageUpdateHandler?()
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
