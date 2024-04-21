//
//  MessageCell.swift
//  ChatBot
//
//  Created by nayeon  on 4/15/24.
//

import UIKit
import SnapKit
import Then

class MessageCell: UICollectionViewCell {
    static let reuseIdentifier = "MessageCell"
    
    private let bubbleView = ChatBubbleView(emptyWidth: 0, emptyHeight: 0, dotsSpacing: 0, frame: .zero).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bubbleView)
        
        NSLayoutConstraint.activate([
            bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with message: MessageDTO) {
        let direction: ChatBubbleView.StartDirection = message.role == .user ? .right : .left
        bubbleView.setText(message.content, direction: direction)
        
        switch direction {
        case .left:
            bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        case .right:
            bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        }
    }
}
