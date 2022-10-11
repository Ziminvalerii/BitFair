//
//  CointsLabel.swift
//  BitFair
//
//  Created by Tanya Koldunova on 16.09.2022.
//

import SpriteKit

class CointsLabel: SKSpriteNode {
    
    lazy var label: SKLabelNode = {
        let text =  NSAttributedString(string: "Coins amount: 0", attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 24)!, .foregroundColor: UIColor.white])
        let label = SKLabelNode(attributedText: text)
        label.zPosition = 11
        label.position = CGPoint(x: 0, y: -label.frame.height/2)
        return label
    }()
    var startPos:CGPoint = CGPoint(x: 0, y: 0)
    
    convenience init(red: Bool) {
        self.init(imageNamed: red ? "buttonTexture" : "buyButtonContainer")
        self.size = NodesSize.cointsLabel.size
        self.zPosition = 10
        self.addChild(label)
    }
    
    func setUpPosition(position: CGPoint) {
        self.position = position
        startPos = position
    }
    
    func setText(text: String) {
        let attributedText = NSAttributedString(string: text, attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 24)!, .foregroundColor: UIColor.white])
        label.attributedText = attributedText
    }
}

extension CointsLabel:Updatable {
    func update() {
        guard let camera = scene?.camera else {return}
        self.position.x = camera.position.x + startPos.x

    }
}
