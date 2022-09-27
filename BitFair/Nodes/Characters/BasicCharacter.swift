//
//  SuperheroNode.swift
//  BitFair
//
//  Created by Tanya Koldunova on 13.09.2022.
//

import Foundation
import SpriteKit

enum BasicCharacterType {
    case simple
    case upgraded
    
    var imageNamed: String {
        switch self {
        case .simple:
            return "character"
        case .upgraded:
            return "character2"
        }
    }
    
    var size: CGSize {
        switch self {
        case .simple:
            return CGSize(width: 65, height: 105)
        case .upgraded:
            return CGSize(width: 70, height: 100)
        }
    }
    
    var walkTextures: [SKTexture] {
        switch self {
        case .simple:
            return [SKTexture(imageNamed: "characterWalk"),SKTexture(imageNamed: "character"),SKTexture(imageNamed: "characterWalk2")]
        case .upgraded:
            return [SKTexture(imageNamed: "character2Walk"),SKTexture(imageNamed: "character2"),SKTexture(imageNamed: "character2Walk2")]
        }
    }
}

class BasicCharacter: SKSpriteNode, CharacterProtocol  {
    //var hp:Int = 3
    var hp: Int = 3
    var mySpeed: CGFloat = 4.0
    var jump: CGFloat = 135
    var numberOfShoots: Int = 2
    var shootCount: Int = 0
    var walkTextures: [SKTexture] = [SKTexture]()
    convenience init(type: BasicCharacterType) {
        self.init(imageNamed: type.imageNamed)
       // self.init(color: .red, size: NodesSize.mainCharacter.size)
       // self.anchorPoint = 
        self.size = type.size
        self.zPosition = 10
        self.setUpPhysics()
        self.name = "superhero"
        walkTextures = type.walkTextures
    }
    
    func createWeaponeNode() -> HeroWeaponProtocol {
        let weapone = WeaponNode()
        return weapone
    }
   
}
