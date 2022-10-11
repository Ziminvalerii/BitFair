//
//  BackButton.swift
//  BitFair
//
//  Created by Tanya Koldunova on 11.10.2022.
//

import SpriteKit

class BackButtonNode: SKSpriteNode {
    var shouldAcceptTouches: Bool = true
    lazy var image : SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "backArrow")
        node.zPosition = 1
        node.size = CGSize(width: 20, height: 28)
        node.name = "back icon node"
        return node
    }()
    private var startPos = CGPoint.zero
    var delegate: Dependable {
        guard let delegate = scene as? Dependable else {
            fatalError("ButtonNode may only be used within a `ButtonNodeResponderType` scene.")
        }
        return delegate
    }
    
    
    convenience init() {
        self.init(imageNamed: "smallButtonTexture")
        self.size = NodesSize.smallButtonTexture.size
        self.name = "back button node"
        self.zPosition = 19
        self.addChild(image)
    }
    
    func setUpPos(pos: CGPoint) {
        self.position = pos
        self.startPos = position
    }
    
    func setUpXpos(x: CGFloat) {
        self.position.x = x
        startPos = position
    }
}

extension BackButtonNode: ButtonType {
    
    
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?) {
        guard let scene = scene else {return}
        if containsTouches(touches: touches, scene: scene, nodeNames: ["back icon node", "back button node"]) {
            delegate.switchState(state: .goToMap)
            playSound(scene)
        }
    }
}

extension BackButtonNode: Updatable {
    func update() {
        guard let camera = scene?.camera else {return}
        self.position.x = camera.position.x + startPos.x
    }
}
