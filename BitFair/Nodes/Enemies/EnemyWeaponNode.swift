//
//  EnemyWeaponNode.swift
//  BitFair
//
//  Created by Tanya Koldunova on 19.09.2022.
//

import SpriteKit

class EnemyWeaponNode: SKSpriteNode, EnemyWeaponProtocol {
    var damage: Int = 1
    
    
    convenience init() {
        self.init(imageNamed: "enemyWeapon")
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = 11
        //self.size = CGSize(width: 40, height: 40)
        addPhysics()
        setUpBitMasks()
        self.name = "batWeapone"
    }
 
    
}
