//
//  UpgratedWeaponeNode.swift
//  BitFair
//
//  Created by Tanya Koldunova on 23.09.2022.
//

import SpriteKit

class UpgratedWeaponNode: SKSpriteNode, HeroWeaponProtocol {
    var damage: Int = 2
    convenience init() {
        self.init(imageNamed: "upgratedWeapon")
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = 11
        self.addPhysics()
    }
}
