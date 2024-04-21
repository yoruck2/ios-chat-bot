//
//  ChatBubbleView.swift
//  ChatBot
//
//  Created by nayeon  on 4/16/24.
//

import UIKit
import SnapKit
import Then

class ChatBubbleView: UIView {
    private let emptyWidth: CGFloat
    private let emptyHeight: CGFloat
    private let dotsSpacing: CGFloat
    private let bubbleLayer = CAShapeLayer()
    private let contentLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
    }
    
    private var startDirection: StartDirection
    
    init(emptyWidth: CGFloat, emptyHeight: CGFloat, dotsSpacing: CGFloat, frame: CGRect) {
        self.emptyWidth = emptyWidth
        self.emptyHeight = emptyHeight
        self.dotsSpacing = dotsSpacing
        self.startDirection = .right
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        layer.addSublayer(bubbleLayer)
        addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12.0),
            contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.0),
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = contentLabel.text == nil ? emptyWidth : bounds.size.width
        let height = contentLabel.text == nil ? emptyHeight : bounds.size.height
        
        let bezierPath = UIBezierPath()
        switch startDirection {
        case .left:
            drawLeftChatBubble(bezierPath: bezierPath, width: Double(width), height: Double(height))
            bubbleLayer.fillColor = UIColor.lightGray.cgColor
        case .right:
            drawRightChatBubble(bezierPath: bezierPath, width: Double(width), height: Double(height))
            bubbleLayer.fillColor = UIColor.systemBlue.cgColor
        }
        bezierPath.close()
        
        if contentLabel.text == nil {
            drawDots(bezierPath: bezierPath, size: 5, points: CGPoint(x: emptyWidth / 2, y: emptyHeight / 2),
                     CGPoint(x: emptyWidth / 2 - dotsSpacing, y: emptyHeight / 2),
                     CGPoint(x: emptyWidth / 2 + dotsSpacing, y: emptyHeight / 2))
        }
        
        bubbleLayer.path = bezierPath.cgPath
    }
    
    func setText(_ text: String?, direction: StartDirection) {
        contentLabel.text = text
        startDirection = direction
    }
    
    private func drawRightChatBubble(bezierPath: UIBezierPath, width: Double, height: Double) {
        bezierPath.move(to: CGPoint(x: width - 22, y: height))
        
        bezierPath.addLine(to: CGPoint(x: 17, y: height))
        bezierPath.addCurve(to: CGPoint(x: 0, y: height - 17), controlPoint1: CGPoint(x: 7.61, y: height), controlPoint2: CGPoint(x: 0, y: height - 7.61))
        
        bezierPath.addLine(to: CGPoint(x: 0, y: 17))
        bezierPath.addCurve(to: CGPoint(x: 17, y: 0), controlPoint1: CGPoint(x: 0, y: 7.61), controlPoint2: CGPoint(x: 7.61, y: 0))
        
        bezierPath.addLine(to: CGPoint(x: width - 21, y: 0))
        bezierPath.addCurve(to: CGPoint(x: width - 4, y: 17), controlPoint1: CGPoint(x: width - 11.61, y: 0), controlPoint2: CGPoint(x: width - 4, y: 7.61))
        
        bezierPath.addLine(to: CGPoint(x: width - 4, y: height - 11))
        bezierPath.addCurve(to: CGPoint(x: width, y: height), controlPoint1: CGPoint(x: width - 4, y: height - 1), controlPoint2: CGPoint(x: width, y: height))
        
        bezierPath.addLine(to: CGPoint(x: width + 0.05, y: height - 0.01))
        bezierPath.addCurve(to: CGPoint(x: width - 11.04, y: height - 4.04), controlPoint1: CGPoint(x: width - 4.07, y: height + 0.43), controlPoint2: CGPoint(x: width - 8.16, y: height - 1.06))
        bezierPath.addCurve(to: CGPoint(x: width - 22, y: height), controlPoint1: CGPoint(x: width - 16, y: height), controlPoint2: CGPoint(x: width - 19, y: height))
    }
    
    private func drawLeftChatBubble(bezierPath: UIBezierPath, width: Double, height: Double) {
        
        bezierPath.move(to: CGPoint(x: 22, y: height))
        
        bezierPath.addLine(to: CGPoint(x: width - 17, y: height))
        bezierPath.addCurve(to: CGPoint(x: width, y: height - 17), controlPoint1: CGPoint(x: width - 7.61, y: height), controlPoint2: CGPoint(x: width, y: height - 7.61))
        
        bezierPath.addLine(to: CGPoint(x: width, y: 17))
        bezierPath.addCurve(to: CGPoint(x: width - 17, y: 0), controlPoint1: CGPoint(x: width, y: 7.61), controlPoint2: CGPoint(x: width - 7.61, y: 0))
        
        bezierPath.addLine(to: CGPoint(x: 21, y: 0))
        bezierPath.addCurve(to: CGPoint(x: 4, y: 17), controlPoint1: CGPoint(x: 11.61, y: 0), controlPoint2: CGPoint(x: 4, y: 7.61))
        
        bezierPath.addLine(to: CGPoint(x: 4, y: height - 11))
        bezierPath.addCurve(to: CGPoint(x: 0, y: height), controlPoint1: CGPoint(x: 4, y: height - 1), controlPoint2: CGPoint(x: 0, y: height))
        
        bezierPath.addLine(to: CGPoint(x: -0.05, y: height - 0.01))
        bezierPath.addCurve(to: CGPoint(x: 11.04, y: height - 4.04), controlPoint1: CGPoint(x: 4.07, y: height + 0.43), controlPoint2: CGPoint(x: 8.16, y: height - 1.06))
        bezierPath.addCurve(to: CGPoint(x: 22, y: height), controlPoint1: CGPoint(x: 16, y: height), controlPoint2: CGPoint(x: 19, y: height))
    }
    
    private func drawDots(bezierPath: UIBezierPath, size: CGFloat, points: CGPoint...) {
        for point in points {
            bezierPath.move(to: CGPoint(x: point.x + size, y: point.y))
            bezierPath.addArc(withCenter: point, radius: size, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        }
    }
}

extension ChatBubbleView {
    enum StartDirection {
        case left
        case right
    }
}
