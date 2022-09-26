//
//  NewbieKnight.swift
//  BitFair
//
//  Created by Tanya Koldunova on 21.09.2022.
//

import SpriteKit
import UIKit

class NewbieKnight: SKSpriteNode, CharacterProtocol {
    var hp:Int = 3
    var mySpeed: CGFloat = 6.0
    var jump: CGFloat = 100
    var numberOfShoots: Int = 3
    var shootCount: Int = 0
    var walkTextures: [SKTexture] = [SKTexture(imageNamed: "character3Walk"),SKTexture(imageNamed: "character3"),SKTexture(imageNamed: "character3Walk2")]
    
    convenience init() {
        self.init(imageNamed: "character3")
        self.size = CGSize(width: 100, height: 130)
        self.zPosition = 10
        self.setUpPhysics()
        self.name = "superhero"
    }
    
    func createWeaponeNode() -> HeroWeaponProtocol {
        let weapone = WeaponNode()
        return weapone
    }
    
    
}
