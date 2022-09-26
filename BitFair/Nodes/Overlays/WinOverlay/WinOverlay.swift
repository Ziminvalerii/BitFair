//
//  WinOverlay.swift
//  BitFair
//
//  Created by Tanya Koldunova on 22.09.2022.
//

import SpriteKit

class WinOverlay: SKSpriteNode {
    
    var shouldAcceptTouches: Bool = true {
        didSet {
            self.isUserInteractionEnabled = shouldAcceptTouches
        }
    }
    
    var delegate: Dependable {
        guard let delegate = scene as? Dependable else {
            fatalError("ButtonNode may only be used within a `ButtonNodeResponderType` scene.")
        }
        return delegate
    }
    
    lazy var okButton: SKSpriteNode = {
        let button = SKSpriteNode(imageNamed: "buyButtonContainer")
        button.size = NodesSize.orangeButton.size
        button.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        button.zPosition = 24
        let text =  NSAttributedString(string: "Ok", attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 24)!, .foregroundColor: UIColor.white])
        let label = SKLabelNode(attributedText: text)
        label.zPosition = 25
        label.position = CGPoint(x: 0, y: -label.frame.size.height/2)
        button.addChild(label)
        button.name = "ok button"
        return button
    }()
    
    lazy var watchAdButton: SKSpriteNode = {
        let button = SKSpriteNode(imageNamed: "buyButtonContainer")
        button.size = NodesSize.orangeButton.size
        button.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        button.zPosition = 24
        let text =  NSAttributedString(string: "Watch ad", attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 24)!, .foregroundColor: UIColor.white])
        let label = SKLabelNode(attributedText: text)
        label.zPosition = 25
        label.position = CGPoint(x: 0, y: -label.frame.size.height/2)
        button.addChild(label)
        button.name = "Watch ad button"
        return button
    }()
    
    convenience init(at size: CGSize) {
        self.init(imageNamed: "winOverlay")
        self.size = size
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = 22
        okButton.position = CGPoint(x: 0, y: 0)
        watchAdButton.position = CGPoint(x: 0, y: okButton.position.y + watchAdButton.size.height/2 + 32)
        self.name = "win overlay"
        self.addChild(okButton)
    }
    
    func apear() {
        self.run(SKAction.fadeIn(withDuration: 0.2))
    }
    
    func dissapear() {
        self.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.2), SKAction.removeFromParent()]))
    }
}

extension WinOverlay: ButtonType {
  
    
    
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?) {
        guard let scene = scene else {return}
        if containsTouches(touches: touches, scene: scene, nodeName: "ok button") {
            delegate.switchState(state: .goToMap)
        } else if containsTouches(touches: touches, scene: scene, nodeName: "Watch ad button") {
            return
        }
    }
}
