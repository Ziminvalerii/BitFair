//
//  ChooseBackgroundOverlay.swift
//  BitFair
//
//  Created by Tanya Koldunova on 22.09.2022.
//

import SpriteKit

protocol FrameNodeProtocol: SKSpriteNode, ButtonType {
    var currentIndex: Int {get set}
}

class ChooseBackground: SKSpriteNode {
    var frameNode: FrameNodeProtocol!
    convenience init(with size: CGSize, frameNode: FrameNodeProtocol) {
        self.init(imageNamed: "shopOverlay")
        self.size = size
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = 18
        self.frameNode = frameNode
        self.addChild(frameNode)
    }
    
    func apear() {
        self.run(SKAction.fadeIn(withDuration: 0.2))
    }
    
    func dissapear() {
        self.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.2), SKAction.removeFromParent()]))
    }
}
