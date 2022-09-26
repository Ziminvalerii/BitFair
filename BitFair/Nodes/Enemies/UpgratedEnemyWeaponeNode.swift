//
//  UpgratedEnemyWeaponeNode.swift
//  BitFair
//
//  Created by Tanya Koldunova on 23.09.2022.
//

import SpriteKit

class UpgratedEnemyWeaponNode: SKSpriteNode, EnemyWeaponProtocol {
    var damage: Int = 2
    convenience init() {
        self.init(imageNamed: "upgratedEnemyWeapon")
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = 11
        self.size = CGSize(width: 40, height: 40)
        addPhysics()
        self.name = "batWeapone"
    }
}
