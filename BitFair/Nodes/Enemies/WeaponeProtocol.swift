//
//  WeaponeProtocol.swift
//  BitFair
//
//  Created by Tanya Koldunova on 19.09.2022.
//

import SpriteKit

protocol WeaponeProtocol: SKSpriteNode {
    var damage: Int {get set}
    func addPhysics()
    func setUpBitMasks()
}

extension WeaponeProtocol {
    func addPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
       // self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.usesPreciseCollisionDetection = true
        setUpBitMasks()
    }
}

protocol HeroWeaponProtocol: WeaponeProtocol {
    func applyAction(scene: SKScene, heroPos: CGPoint)
    
}

extension HeroWeaponProtocol {
    func applyAction(scene: SKScene, heroPos: CGPoint) {
        let moveAction = SKAction.move(to: CGPoint(x: heroPos.x + scene.size.width/2 + self.size.width, y: heroPos.y), duration: 1.0)
        self.run(SKAction.sequence([moveAction, SKAction.run {
                self.removeFromParent()
        }]))
    }
    
    func setUpBitMasks() {
        self.physicsBody?.categoryBitMask = PhysicsBitMask.weapon.bitMask
        self.physicsBody?.contactTestBitMask = PhysicsBitMask.enemy.bitMask | PhysicsBitMask.ground.bitMask
    }
}

protocol EnemyWeaponProtocol: WeaponeProtocol {
    func applyAction(scene: SKScene, enemyPos: CGPoint, targetPos: CGPoint)
}

extension EnemyWeaponProtocol {
    func applyAction(scene: SKScene, enemyPos: CGPoint, targetPos: CGPoint) {
        let xPos: CGFloat
        if targetPos.x > enemyPos.x {
            xPos = targetPos.x - scene.size.width/2
        } else {
            xPos = targetPos.x + scene.size.width/2
        }
        let moveAction = SKAction.move(to: CGPoint(x: -scene.size.width/2, y: enemyPos.y), duration: 6.0)
        self.run(SKAction.sequence([moveAction, SKAction.run {
                self.removeFromParent()
        }]))
    }
    func setUpBitMasks() {
        self.physicsBody?.categoryBitMask = PhysicsBitMask.enemyWeapon.bitMask
        self.physicsBody?.contactTestBitMask = PhysicsBitMask.player.bitMask | PhysicsBitMask.ground.bitMask
        self.physicsBody?.collisionBitMask = PhysicsBitMask.ground.bitMask
    }
    
}

