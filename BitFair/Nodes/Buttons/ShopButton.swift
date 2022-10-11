//
//  ShopButton.swift
//  BitFair
//
//  Created by Tanya Koldunova on 13.09.2022.
//

import SpriteKit

class ShopButtonNode:SKSpriteNode {
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
    
    convenience init(at sceneSize:CGSize?) {
        self.init(imageNamed: "shopButtonTexture")
        self.size = NodesSize.orangeButton.size
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = 19
        if let sceneSize = sceneSize {
            self.position = CGPoint(x: 0, y: -self.size.height/2)
        }
        self.name = "shop"
    }
    
    
}


extension ShopButtonNode: ButtonType {
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?) {
        guard let scene = scene else {return}
        if containsTouches(touches: touches, scene: scene, nodeName: "shop") {
            self.delegate.switchState(state: .goToShop)
            playSound(scene)
        }
    }
}
