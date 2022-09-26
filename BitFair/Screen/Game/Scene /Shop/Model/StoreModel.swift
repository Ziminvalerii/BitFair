//
//  CharacterModel.swift
//  BitFair
//
//  Created by Tanya Koldunova on 21.09.2022.
//

import UIKit
import SpriteKit

enum StoreModel: String, CaseIterable {
    case simpleCharacter = "com.simpleCharacter.key"
    case upgratedSimpleCharacter = "com.upgratedSimpleCharacter.key"
    case newbieKnightCharacter = "com.newbieKnightCharacter.key"
    case knightCharacter = "com.knightCharacter.key"
    case upgratedKnightCaracter = "com.upgratedKnightCaracter.key"
    case hundredCoins = "com.hundredCoins.key"
    case twoHundredCoins = "com.twoHundredCoins.key"
    
    var purchaseIdentifier: String? {
        switch self {
        case .simpleCharacter:
            return nil
        case .upgratedSimpleCharacter:
            return nil
        case .newbieKnightCharacter:
            return "com.newbieKnight.character"
        case .knightCharacter:
            return "com.knight.character"
        case .upgratedKnightCaracter:
            return "com.upgratedKnight.character"
        case .hundredCoins:
            return "com.hundred.coins"
        case .twoHundredCoins:
            return "com.twoHundred.coins"
        }
    }
    
    var node: CharacterProtocol? {
        switch self {
        case .simpleCharacter:
            return BasicCharacter(type: .simple)
        case .upgratedSimpleCharacter:
            return BasicCharacter(type: .upgraded)
        case .newbieKnightCharacter:
            return NewbieKnight()
        case .knightCharacter:
            return KnightCharacter(type: .simple)
        case .upgratedKnightCaracter:
            return KnightCharacter(type: .upgraded)
        case .hundredCoins:
            return nil
        case .twoHundredCoins:
            return nil
        }
    }
    
    var size: CGSize {
        switch self {
        case .simpleCharacter:
            return BasicCharacterType.simple.size
        case .upgratedSimpleCharacter:
            return BasicCharacterType.upgraded.size
        case .newbieKnightCharacter:
            return CGSize(width: 100, height: 130)
        case .knightCharacter:
            return KnightCharacterType.simple.size
        case .upgratedKnightCaracter:
            return KnightCharacterType.upgraded.size
        case .hundredCoins:
            return CGSize(width: 140, height: 140)
        case .twoHundredCoins:
            return CGSize(width: 140, height: 140)
        }
    }
    
    var texture: SKTexture {
        switch self {
        case .simpleCharacter:
            return SKTexture(imageNamed: "character")
        case .upgratedSimpleCharacter:
            return SKTexture(imageNamed: "character2")
        case .newbieKnightCharacter:
            return SKTexture(imageNamed: "character3")
        case .knightCharacter:
            return SKTexture(imageNamed: "character4")
        case .upgratedKnightCaracter:
            return SKTexture(imageNamed: "character5")
        case .hundredCoins:
            return SKTexture(imageNamed: "hundredCoins")
        case .twoHundredCoins:
            return SKTexture(imageNamed: "twoHundredCoins")
        }
    }
    
    var value: Float {
        switch self {
        case .simpleCharacter:
            return 0
        case .upgratedSimpleCharacter:
            return 0
        case .newbieKnightCharacter:
            return 0
        case .knightCharacter:
            return 0
        case .upgratedKnightCaracter:
            return 0
        case .hundredCoins:
            return 100
        case .twoHundredCoins:
            return 200
        }
    }
    
    var buyForCoins: Float? {
        switch self {
        case .simpleCharacter:
            return 0
        case .upgratedSimpleCharacter:
            return nil
        case .newbieKnightCharacter:
            return 50
        case .knightCharacter:
            return 100
        case .upgratedKnightCaracter:
            return 120
        case .hundredCoins:
            return 0
        case .twoHundredCoins:
            return 0
        }
    }
    
    var buyInApPurch: Bool {
        switch self {
        case .simpleCharacter:
            return false
        case .upgratedSimpleCharacter:
            return false
        case .newbieKnightCharacter:
            return true
        case .knightCharacter:
            return true
        case .upgratedKnightCaracter:
            return true
        case .hundredCoins:
            return true
        case .twoHundredCoins:
            return true
        }
    }
    
    var buyForWatchingAd: Bool {
        switch self {
        case .simpleCharacter:
            return false
        case .upgratedSimpleCharacter:
            return true
        case .newbieKnightCharacter:
            return false
        case .knightCharacter:
            return false
        case .upgratedKnightCaracter:
            return false
        case .hundredCoins:
            return false
        case .twoHundredCoins:
            return false
        }
    }
    
}
