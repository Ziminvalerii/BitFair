//
//  StartNode.swift
//  BitFair
//
//  Created by Tanya Koldunova on 13.09.2022.
//

import Foundation
import SpriteKit

class StartNode: SKSpriteNode {
    
    lazy var startButton = PlayButtonNode()
    var shopButton: ShopButtonNode!
    var settingsButton: SettingsButtonNode!
    var instructionButton: InstructionButtonNode!
    
    convenience init(with size: CGSize) {
        self.init(imageNamed: "startOverlay")
        self.size = size
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = 18
        self.addChild(startButton)
        shopButton = ShopButtonNode(at: size)
        self.addChild(shopButton)
        settingsButton = SettingsButtonNode(at: size)
        self.addChild(settingsButton)
        instructionButton = InstructionButtonNode(at: size)
        self.addChild(instructionButton)
    }
    
    func applyAction() {
        self.run( SKAction.sequence([SKAction.fadeOut(withDuration: 0.2), SKAction.removeFromParent()]) )
    }
}
