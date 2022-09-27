//
//  RescurrentButton.swift
//  BitFair
//
//  Created by Tanya Koldunova on 16.09.2022.
//

import SpriteKit

enum RescurentButtonType {
    case withCoins
    case watchAdd
}

class RescurrrentButton:SKSpriteNode {
    var shouldAcceptTouches: Bool = true {
        didSet {
            self.isUserInteractionEnabled = shouldAcceptTouches
        }
    }
    
    lazy var label: SKLabelNode = {
        let text =  NSAttributedString(string: "Watch add", attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 24)!, .foregroundColor: UIColor.black])
        let label = SKLabelNode(attributedText: text)
        label.zPosition = 25
        label.position = CGPoint(x: 0, y: -label.frame.size.height/2)
        return label
    }()
    
    var delegate: Dependable {
        guard let delegate = scene as? Dependable else {
            fatalError("ButtonNode may only be used within a `ButtonNodeResponderType` scene.")
        }
        return delegate
    }
    
    var type: RescurentButtonType!
    
    convenience init(type: RescurentButtonType, level: LevelManager) {
        self.init(imageNamed: "buttonTexture")
        self.size = NodesSize.buyButtons.size
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = 24
        self.type = type
        setText(type == .withCoins ? "\(level.currentLevel.cointsForRescurent) coins" : "Watch add")
        self.addChild(label)
        self.position = CGPoint(x: 0, y: 0)
        self.name = "rescurent node \(type == .watchAdd ? "with add" : "with coins")"
        
    }
    
    private func setText(_ text:String) {
        let text =  NSAttributedString(string: text, attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 24)!, .foregroundColor: UIColor.black])
        label.attributedText = text
    }
}

extension RescurrrentButton: ButtonType {
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?) {
        guard let scene = scene else {return}
        if containsTouches(touches: touches, scene: scene, nodeName: "rescurent node \(type == .watchAdd ? "with add" : "with coins")") {
            if type == .watchAdd {
                stopPlaying()
                delegate.switchState(state: .watchAd)
            } else {
                delegate.switchState(state: .rescurentWithCoints)
            }
        }
    }
}
