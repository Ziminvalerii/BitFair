//
//  ShopOverlay.swift
//  BitFair
//
//  Created by Tanya Koldunova on 21.09.2022.
//

import Foundation
import SpriteKit


class ShopOverlay: ChooseBackground {
    var shouldAcceptTouches: Bool = true
    
    lazy var coinsLabel = CointsLabel(red: false)
    lazy var backButton: SKSpriteNode = {
        let backNode = SKSpriteNode(imageNamed: "buyButtonContainer")
        backNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backNode.size = NodesSize.cointsLabel.size
        backNode.zPosition = 20
        backNode.name = "back"
        let text =  NSAttributedString(string: "back", attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 17)!, .foregroundColor: UIColor.white])
        let label = SKLabelNode(attributedText: text)
        label.position = CGPoint(x: 0, y: -label.frame.size.height/2)
        label.zPosition = 21
        label.name = "back label"
        backNode.addChild(label)
        return backNode
    }()
    
    var delegate: Dependable {
        guard let delegate = scene as? Dependable else {
            fatalError("ButtonNode may only be used within a `ButtonNodeResponderType` scene.")
        }
        return delegate
    }
    
    
    convenience init(with size: CGSize) {
        self.init(with: size, frameNode: ShopNode())
        if let shopNode = self.frameNode as? ShopNode {
            shopNode.updateLabelDelegate = self
        }
        backButton.position = CGPoint(x: size.width/2 - coinsLabel.size.width/2 - 64, y: size.height/2 - coinsLabel.size.height/2 - 100)
        coinsLabel.position = CGPoint(x: -size.width/2 + coinsLabel.size.width/2 + 64, y: size.height/2 - coinsLabel.size.height/2 - 100)
        coinsLabel.setText(text: "Coins: \(UserDefaultsValues.cointsCount)")
        self.addChild(coinsLabel)
        self.addChild(backButton)
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

extension ShopOverlay: ButtonType {
   
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?) {
        guard let scene = scene else {return}
        if containsTouches(touches: touches, scene: scene, nodeNames: ["back", "back label"]) {
            playSound(scene)
            self.delegate.switchState(state: .start)
        }
    }
}
