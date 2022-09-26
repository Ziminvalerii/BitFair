//
//  ShopOverlay.swift
//  BitFair
//
//  Created by Tanya Koldunova on 21.09.2022.
//

import Foundation
import SpriteKit


class ShopOverlay: ChooseBackground {
    lazy var coinsLabel = CointsLabel(red: false)
    convenience init(with size: CGSize) {
        self.init(with: size, frameNode: ShopNode())
        if let shopNode = self.frameNode as? ShopNode {
            shopNode.updateLabelDelegate = self
        }
        coinsLabel.position = CGPoint(x: size.width/2 - coinsLabel.size.width/2 - 64, y: size.height/2 - coinsLabel.size.height/2 - 100)
        coinsLabel.setText(text: "Coins: \(UserDefaultsValues.cointsCount)")
        self.addChild(coinsLabel)
    }

}

extension ShopOverlay: Dependable {
    func receiveMessage<T>(with arguments: T) {
        if let arguments = arguments as? String {
            if arguments == "update label" {
                coinsLabel.setText(text: "Coins: \(UserDefaultsValues.cointsCount)")
            }
        }
    }
}
