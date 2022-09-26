//
//  GoToStartButton.swift
//  BitFair
//
//  Created by Tanya Koldunova on 16.09.2022.
//

import SpriteKit

class GoToStartButton:SKSpriteNode{
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
    
    var label: SKLabelNode = {
        let text =  NSAttributedString(string: "Get it", attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 24)!, .foregroundColor: UIColor.black])
        let label = SKLabelNode(attributedText: text)
        label.zPosition = 25
        label.position = CGPoint(x: 0, y: -label.frame.size.height/2)
        return label
    }()
    convenience init() {
        self.init(imageNamed: "buttonTexture")
        self.size = NodesSize.buyButtons.size
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = 24
        self.name = "go to start"
        self.addChild(label)
    }
    
}

extension GoToStartButton: ButtonType {
    
    
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?) {
        if let touch = touches.first {
            guard let scene = scene else {return}
            if containsTouches(touches: touches, scene: scene, nodeName: "go to start") {
                delegate.switchState(state: .goToMap)
            }
            playSound(scene)
        }
    }
}
