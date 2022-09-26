//
//  Shop+Texts.swift
//  BitFair
//
//  Created by Tanya Koldunova on 26.09.2022.
//

import SpriteKit
import UIKit

extension ShopNode {
     func setBuyForCointsText(_ text: String, enoughCoins: Bool) {
        let text =  NSAttributedString(string: text, attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 17)!, .foregroundColor: enoughCoins ? UIColor.white : UIColor.red])
        if let label = buyButton.childNode(withName: "buy for coins label") as? SKLabelNode {
            label.attributedText = text
        }
    }
     func setWatchAdext(_ text: String) {
        let text =  NSAttributedString(string: text, attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 17)!, .foregroundColor: UIColor.white])
        if let label = watchAdButton.childNode(withName: "watch ad label") as? SKLabelNode {
            label.attributedText = text
        }
    }
    
     func setBuyForReallMoney(_ text: String) {
        let text =  NSAttributedString(string: text, attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 17)!, .foregroundColor: UIColor.white])
        if let label = buyForMoneyButton.childNode(withName: "buy for real money label") as? SKLabelNode {
            label.attributedText = text
        }
    }
    
     func setTextForAvailableCharacters(current: Bool) {
        let text =  NSAttributedString(string: current ? "Current" : "Get character", attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 17)!, .foregroundColor: current ? UIColor.gray : UIColor.white])
        if let label = getCharacterButton.childNode(withName: "get character label") as? SKLabelNode {
            label.attributedText = text
        }
    }
}
