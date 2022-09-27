//
//  EnemyProtocol.swift
//  BitFair
//
//  Created by Tanya Koldunova on 19.09.2022.
//

import SpriteKit

enum EnemyKillReward {
    case no
    case coins(Int)
    case stars(Int)
}

protocol EnemyProtocol: SKSpriteNode {
    var hp: Int {get set}
    var reward: EnemyKillReward! {get set}
    func setUpPhysics()
    func setUpAction()
    func setUpBitMasks()
    func setUpKillAction()
}

extension EnemyProtocol {
    func setUpBitMasks() {
        self.physicsBody?.categoryBitMask = PhysicsBitMask.enemy.bitMask
        self.physicsBody?.collisionBitMask = PhysicsBitMask.ground.bitMask | PhysicsBitMask.player.bitMask
        self.physicsBody?.contactTestBitMask = PhysicsBitMask.player.bitMask | PhysicsBitMask.weapon.bitMask
    }
    
    func setUpKillAction() {
        switch reward {
        case .no:
            return
        case .stars(let number):
            let star = StarNode()
            star.position = CGPoint(x: self.position.x - scene!.size.width/2, y: self.position.y - scene!.size.height/2)
            scene?.addChild(star)
            star.disaperar()
        case .coins(let number):
            let coins = CoinsNode()
            coins.position = CGPoint(x: self.position.x - scene!.size.width/2, y: self.position.y - scene!.size.height/2)
            scene?.addChild(coins)
            coins.disapear(count: number)
        case .none:
            return
        }
    }

}
