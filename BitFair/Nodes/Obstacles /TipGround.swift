//
//  TipGround.swift
//  BitFair
//
//  Created by Tanya Koldunova on 15.09.2022.
//

import SpriteKit

enum GroundState {
    case upDown
    case leftRight
    case stop
}

class TipGround: SKSpriteNode{
    
    var state: GroundState!
    var initPos: CGPoint?
    convenience init(state: GroundState) {
        self.init(imageNamed: "tipGround")
        self.size = NodesSize.tipGround.size
        self.zPosition = 2
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
      //  self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsBitMask.ground.bitMask
        self.physicsBody?.collisionBitMask = PhysicsBitMask.player.bitMask 
        if state == .leftRight {
            self.physicsBody?.contactTestBitMask = PhysicsBitMask.player.bitMask | PhysicsBitMask.enemyWeapon.bitMask | PhysicsBitMask.weapon.bitMask
        } else {
            self.physicsBody?.contactTestBitMask = PhysicsBitMask.enemyWeapon.bitMask | PhysicsBitMask.weapon.bitMask
        }
     //   self.physicsBody?.usesPreciseCollisionDetection = true
        self.name = "tip ground node"
        self.state = state
    }
    
    func setAction() {
        initPos = self.position
        switch state {
        case .leftRight:
            let sequence = SKAction.sequence([SKAction.moveTo(x: initPos!.x + 200, duration: 1.5),
                                              SKAction.moveTo(x: initPos!.x - 200, duration: 1.5)
                                             ])
            self.run(SKAction.repeatForever(sequence))
        case .upDown:
            let sequence = SKAction.sequence([SKAction.moveTo(y: initPos!.y + 75, duration: 0.6),
                                              SKAction.moveTo(y: initPos!.y - 50, duration: 0.6)
                                             ])
            self.run(SKAction.repeatForever(sequence))
        case .stop:
            return
        case .none:
            return
        }
    }
}
