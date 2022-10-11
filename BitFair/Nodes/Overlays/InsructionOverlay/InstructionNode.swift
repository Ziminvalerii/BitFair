//
//  InstructionNode.swift
//  BitFair
//
//  Created by Tanya Koldunova on 22.09.2022.
//

import Foundation
import SpriteKit

class InstructionNode: SKSpriteNode, FrameNodeProtocol {
    var currentIndex: Int = 0
    var shouldAcceptTouches: Bool = true 
    
    var delegate: Dependable {
        guard let delegate = scene as? Dependable else {
            fatalError("ButtonNode may only be used within a `ButtonNodeResponderType` scene.")
        }
        return delegate
    }
    
    var model: InstructionModel.AllCases = InstructionModel.allCases
    
    var instructionNode: SKLabelNode = {
        let text =  NSAttributedString(string: InstructionModel.joistickTopic.rawValue, attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 17)!, .foregroundColor: UIColor.white])
        let label = SKLabelNode(attributedText: text)
       // label.frame.size = CGSize(width: 300, height: 500)
        label.preferredMaxLayoutWidth = 400
        label.numberOfLines = 6
        label.zPosition = 21
        label.name = "buy for coins label"
        return label
    }()
    
    lazy var leftArrow: SKSpriteNode = {
        let leftArrow = SKSpriteNode(imageNamed: "shopLeftArrow")
        leftArrow.size = NodesSize.shopArrow.size
        leftArrow.zPosition = 20
        leftArrow.name = "instruction left arrow"
        return leftArrow
    }()
    
    lazy var rigtArrow: SKSpriteNode = {
        let rightArrow = SKSpriteNode(imageNamed: "shopRightArrow")
        rightArrow.size = NodesSize.shopArrow.size
        rightArrow.zPosition = 20
        rightArrow.name = "instruction right arrow"
        return rightArrow
    }()
    
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
    
    
    
    convenience init() {
        self.init(imageNamed: "shopTexture")
        self.size = NodesSize.shopNode.size
        self.zPosition = 19
        self.name = "instructionNode"
        let leftArrowXpos = -self.size.width/2+leftArrow.size.width/2+110
        let rightArrowXpos = self.size.width/2-leftArrow.size.width/2-110
        instructionNode.position = CGPoint(x: 0, y: -instructionNode.frame.size.height/2)
        leftArrow.position = CGPoint(x: leftArrowXpos, y: 0)
        rigtArrow.position = CGPoint(x: rightArrowXpos, y: 0)
        backButton.position = CGPoint(x: 0, y: -self.size.height/2+backButton.size.height/2+64)
        self.addChild(instructionNode)
        self.addChild(leftArrow)
        self.addChild(rigtArrow)
        self.addChild(backButton)
    }
    
    private func setText(_ text: String) {
        let text =  NSAttributedString(string: text, attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 17)!, .foregroundColor: UIColor.white])
        instructionNode.attributedText = text
    }
}

extension InstructionNode {
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?) {
        guard let scene = scene else {return}
        if containsTouches(touches: touches, scene: scene, nodeNames: ["back", "back label"]) {
            self.delegate.switchState(state: .start)
            playSound(scene)
        } else if containsTouches(touches: touches, scene: scene, nodeName: "instruction left arrow") {
            currentIndex -= 1
            if currentIndex < 0 {
                currentIndex = model.count-1
            }
            setText(model[currentIndex].rawValue)
            playSound(scene)
        } else if containsTouches(touches: touches, scene: scene, nodeName: "instruction right arrow") {
            currentIndex += 1
            if currentIndex > model.count - 1 {
                currentIndex = 0
            }
            setText(model[currentIndex].rawValue)
            playSound(scene)
        }
       
    }
}

