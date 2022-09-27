//
//  SimpleEnemy.swift
//  BitFair
//
//  Created by Tanya Koldunova on 15.09.2022.
//

import SpriteKit

class SimpleEnemy: SKSpriteNode, EnemyProtocol {
    var hp: Int = 1
    var reward: EnemyKillReward!
    
    func setUpAction() {
        let moveBack = SKAction.moveTo(x: self.position.x - 10, duration: 1)
        let moveNext = SKAction.moveTo(x: self.position.x + 10, duration: 1)
        let sequence = SKAction.sequence([moveBack, moveNext, moveBack])
        self.run(SKAction.repeatForever(sequence))
    }
    
    
    convenience init(reward: EnemyKillReward!) {
        self.init(imageNamed: "simpleEnemy")
        self.size = NodesSize.simpleEnemy.size
        self.zPosition = 10
        self.setUpPhysics()
        self.reward = reward
    }

    
    func setUpPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        //self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
        setUpBitMasks()
        //self.physicsBody?.pinned = true
        
    }
}
