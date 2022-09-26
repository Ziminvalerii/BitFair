//
//  CoinsNode.swift
//  BitFair
//
//  Created by Tanya Koldunova on 21.09.2022.
//

import SpriteKit

class CoinsNode: SKSpriteNode {
    var label: SKLabelNode?
    convenience init() {
        self.init(imageNamed: "coins")
        self.zPosition = 3
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsBitMask.coint.bitMask
        self.physicsBody?.contactTestBitMask = PhysicsBitMask.player.bitMask
    }
    
    func disapear(count: Int) {
        self.physicsBody = nil
        label = SKLabelNode(text: "+\(count)")
        label?.alpha = 0
        label?.fontColor = .red
        label?.fontSize = 18
        label?.fontName = "System Medium"
        label?.position = CGPoint(x: self.size.width/2 - label!.frame.width/2, y: self.position.y)
        self.scene!.addChild(label!)
        self.alpha = 0
        let move = SKAction.moveTo(y: self.position.y + 40, duration: 0.5)
        self.run(SKAction.sequence([SKAction.fadeIn(withDuration: 0.1), move, SKAction.fadeOut(withDuration: 0.1), SKAction.removeFromParent()]))
        label?.run(SKAction.sequence([SKAction.fadeIn(withDuration: 0.1), move, SKAction.fadeOut(withDuration: 0.1), SKAction.removeFromParent()]))
    }
}
