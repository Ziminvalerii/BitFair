//
//  Shop+ConfigureButtons.swift
//  BitFair
//
//  Created by Tanya Koldunova on 26.09.2022.
//

import SpriteKit

extension ShopNode {
     func showBuyButton(_ model: StoreModel) {
        if model.buyForCoins ?? 0 != 0 {
            setBuyForCointsText("Buy for \(model.buyForCoins!)", enoughCoins: model.buyForCoins ?? 0.0 < UserDefaultsValues.cointsCount)
            if buyButton.parent == nil {
                buyButton.position = CGPoint(x: 0, y: character.position.y - character.size.height/2 - 40)
                self.addChild(buyButton)
            }
        } else {
            buyButton.removeFromParent()
        }
    }
    
     func showWatchAdButton(_ model: StoreModel) {
        if model.buyForWatchingAd  {
            watchAdButton.position = (buyButton.parent == nil) ? CGPoint(x: 0, y: character.position.y - character.size.height/2 - 40) : CGPoint(x: 0, y: buyButton.position.y - buyButton.size.height/2 - 32)
            if watchAdButton.parent == nil {
                self.addChild(watchAdButton)
            }
        } else {
            watchAdButton.removeFromParent()
        }
    }
    
     func showBuyForMoneyButton(_ model: StoreModel) {
        if model.purchaseIdentifier != nil {
            if let product = products?.first(where: {$0.subsctiption.rawValue == model.purchaseIdentifier!}) {
                setBuyForReallMoney("Buy for \(product.price ?? "$0.0")")
                buyForMoneyButton.position = (buyButton.parent == nil) ? CGPoint(x: 0, y: character.position.y - character.size.height/2 - 40) : CGPoint(x: 0, y: buyButton.position.y - buyButton.size.height/2 - 32)
                if buyForMoneyButton.parent == nil {
                    self.addChild(buyForMoneyButton)
                }
            } else {
                buyForMoneyButton.removeFromParent()
            }
        } else {
            buyForMoneyButton.removeFromParent()
        }
    }
}
