//
//  InstructionButton.swift
//  BitFair
//
//  Created by Tanya Koldunova on 22.09.2022.
//

import SpriteKit

class InstructionButtonNode:SKSpriteNode{
    
    var shouldAcceptTouches: Bool = true {
        didSet {
            self.isUserInteractionEnabled = shouldAcceptTouches
        }
    }
    
    var delegate: Dependable {
        guard let delegate = scene as? Dependable else {
            fatalError("ButtonNode may only be used within a `ButtonNodeResponderType` scene.")
        }
        return delegate
    }
    
    convenience init(at sceneSize:CGSize) {
        self.init(imageNamed: "detailButtonTexture")
        self.size = NodesSize.redButtons.size
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = 19
        self.position = CGPoint(x: (sceneSize.width/2-self.size.width/2 - 90), y: (sceneSize.height/2-self.size.height-100))
        self.name = "instruction button"
        
    }
    
}

extension InstructionButtonNode: ButtonType {
   
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?) {        guard let scene = scene else {return}
        if containsTouches(touches: touches, scene: scene, nodeName: "instruction button") {
        delegate.switchState(state: .goToInstruction)
        }
        playSound(scene)
    }
}
