//
//  WeaponNode.swift
//  BitFair
//
//  Created by Tanya Koldunova on 14.09.2022.
//

import SpriteKit

class WeaponNode: SKSpriteNode, HeroWeaponProtocol {
    var damage: Int = 1
    convenience init() {
        self.init(imageNamed: "weapon")
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = 11
        self.addPhysics()
    }
}
