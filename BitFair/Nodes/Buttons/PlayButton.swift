//
//  PlayButton.swift
//  BitFair
//
//  Created by Tanya Koldunova on 13.09.2022.
//

import Foundation
import SpriteKit


class PlayButtonNode:SKSpriteNode{
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
    
    convenience init() {
        self.init(imageNamed: "playButtonTexture")
        self.size = NodesSize.orangeButton.size
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = 19
        self.position = CGPoint(x: 0, y: self.size.height/2)
    }
    
}

extension PlayButtonNode: ButtonType {
    
    
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?) {
        if let touch = touches.first {
            guard let scene = scene else {return}
            if self.contains(touch.location(in: scene)) {
                delegate.switchState(state: GameStates.goToMap)
            }
            playSound(scene)
        }
    }
}
