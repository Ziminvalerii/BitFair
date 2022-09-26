//
//  InstructionModel.swift
//  BitFair
//
//  Created by Tanya Koldunova on 22.09.2022.
//

import Foundation
import UIKit
import SpriteKit


enum InstructionModel: String, CaseIterable {
    case joistickTopic = "In the left sight of the screen and in the right side you have to josticks. By tapping on the left sight joistic you can move left or right. By tapping on the right sight jiistic you can jump or shoot"
    case heroTopic = "In the game there is 6 types of the characters. Each character has their own capabilities.For exmaple veru first characters cannot can shoot a certain number of times. So you better save your energy and use shooting when it is nessesary. Also characters have their own speed, amplitude and health points"
    case collectCoinsTopic = "You can collect game coins to get upgraded character or rescurret when you cannot complete level. Coins are scaterred around the world or can be hidden in the bonus obstacle also by killing enemy you cam get coins too"
    case enemyTypeTopic = "There are 3 types of enemies. One of them can bit you by using shooting, however he can bit you by the touch. Another type of enemy is flying and have capability to use the shooting. And another type can follow you until you will kill him"
    case gameGoalTopic = "The level will be complete when you will get to the flag"
    
    var images: [UIImage] {
        switch self {
        case .joistickTopic:
            return [UIImage(named: "joistickImage")!, UIImage(named: "upHitJoistickImage")!]
        case .heroTopic:
            return [UIImage(named: "character")!, UIImage(named: "character4")!, UIImage(named: "character6")!]
        case .collectCoinsTopic:
            return [UIImage(named: "coins")!, UIImage(named: "bonusGround")!]
        case .enemyTypeTopic:
            return [UIImage(named: "simpleEnemy")!, UIImage(named: "batEnemy")!, UIImage(named: "bigEnemy")!]
        case . gameGoalTopic:
            return [UIImage]()
        }
    }
    
}
