//
//  ReplyButton.swift
//  BitFair
//
//  Created by Tanya Koldunova on 16.09.2022.
//

import SpriteKit

class ReplayButtonNode:SKSpriteNode {
    var shouldAcceptTouches: Bool = true 
    
    var delegate: Dependable {
        guard let delegate = scene as? Dependable else {
            fatalError("ButtonNode may only be used within a `ButtonNodeResponderType` scene.")
        }
        return delegate
    }
    
    convenience init() {
        self.init(imageNamed: "restartButtonTexture")
        self.size = NodesSize.buyButtons.size
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = 24
        self.name = "replay"
    }
    
}


extension ReplayButtonNode: ButtonType {
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?) {
        guard let scene = scene else {return}
        if containsTouches(touches: touches, scene: scene, nodeName: "replay") {
            self.delegate.switchState(state: .playing)
            playSound(scene)
            return
        }
    }
    
    
}
