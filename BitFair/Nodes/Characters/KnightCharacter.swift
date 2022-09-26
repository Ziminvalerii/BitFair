//
//  KnightCharacter.swift
//  BitFair
//
//  Created by Tanya Koldunova on 21.09.2022.
//

import Foundation
import SpriteKit

enum KnightCharacterType {
    case simple
    case upgraded
    
    var imageNamed: String {
        switch self {
        case .simple:
            return "character4"
        case .upgraded:
            return "character5"
        }
    }
    
    var walkTextures: [SKTexture] {
        switch self {
        case .simple:
            return [SKTexture(imageNamed: "character4"), SKTexture(imageNamed: "character4Walk")]
        case .upgraded:
            return [SKTexture(imageNamed: "character5"), SKTexture(imageNamed: "character5Walk")]
        }
    }
    
    var size: CGSize {
        switch self {
        case .simple:
            return CGSize(width: 110, height: 138)
        case .upgraded:
            return CGSize(width: 116, height: 132)
        }
    }
    
}

class KnightCharacter: SKSpriteNode, CharacterProtocol {
    var hp: Int = 4
    var mySpeed: CGFloat = 6.0
    var jump: CGFloat = 120
    var numberOfShoots: Int = 5
    var shootCount: Int = 0
    var walkTextures: [SKTexture] = [SKTexture]()
    convenience init(type: KnightCharacterType) {
        self.init(imageNamed: type.imageNamed)
        self.size = type.size
        self.zPosition = 10
        self.setUpPhysics()
        self.name = "superhero"
        walkTextures = type.walkTextures
    }
    
    func createWeaponeNode() -> HeroWeaponProtocol {
        let weapone = UpgratedWeaponNode()
        return weapone
    }
}
