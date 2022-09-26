//
//  NodesSize.swift
//  BitFair
//
//  Created by Tanya Koldunova on 15.09.2022.
//

import SpriteKit

enum NodesSize {
    case tipGround //= CGSize(width: 200, height: 50)
    case mainCharacter
    case flyEnemy
    case simpleEnemy
    case coint
    case obstacle
    case heart
    case bonusGround
    case orangeButton
    case redButtons
    case shopNode
    case shopArrow
    case buyButtons
    case levelGround
    case playButton
    case cointsLabel
    
    var size: CGSize {
        switch self {
        case .tipGround:
            return CGSize(width: 200, height: 50)
        case .mainCharacter:
            return CGSize(width: 76, height: 132)
        case .flyEnemy:
            return CGSize(width: 48, height: 64)
        case .simpleEnemy:
            return CGSize(width: 77, height: 100)
        case .coint:
            return CGSize(width: 40, height: 40)
        case .obstacle:
            return CGSize(width: 80, height: 93)
        case .heart:
            return CGSize(width: 30, height: 30)
        case .bonusGround:
            return CGSize(width: 40, height: 40)
        case .orangeButton:
            return CGSize(width: 300, height: 150)
        case .redButtons:
            return CGSize(width: 325, height: 125)
        case .shopNode:
            return CGSize(width: 742, height: 450)
        case .shopArrow:
            return CGSize(width: 36, height: 46)
        case .buyButtons:
            return CGSize(width: 157, height: 50)
        case .playButton:
            return CGSize(width: 278, height: 60)
        case .levelGround:
            return CGSize(width: 270, height: 150)
        case .cointsLabel:
            return CGSize(width: 250, height: 50)
        }
    }
}
