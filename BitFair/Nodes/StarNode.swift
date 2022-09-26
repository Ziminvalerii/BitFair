//
//  File.swift
//  BitFair
//
//  Created by Tanya Koldunova on 21.09.2022.
//

import SpriteKit

class StarNode: SKSpriteNode {
    
    convenience init() {
        self.init(imageNamed: "stars")
        self.zPosition = 2
        self.size = NodesSize.coint.size
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsBitMask.starts.bitMask
        self.physicsBody?.contactTestBitMask = PhysicsBitMask.player.bitMask
    }
    
    func disaperar() {
        self.physicsBody = nil
        self.alpha = 0
        let move = SKAction.moveTo(y: self.position.y + 40, duration: 0.5)
        self.run(SKAction.sequence([SKAction.fadeIn(withDuration: 0.1), move, SKAction.fadeOut(withDuration: 0.1), SKAction.removeFromParent()]))
    }
}
