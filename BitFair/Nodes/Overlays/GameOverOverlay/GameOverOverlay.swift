//
//  GameOverOverlay.swift
//  BitFair
//
//  Created by Tanya Koldunova on 16.09.2022.
//

import SpriteKit


class GameOverOverlay: SKSpriteNode {
    var gameOverNode: GameOverNode!
    
    convenience init(with size: CGSize, level: LevelManager) {
        self.init(imageNamed: "gameOverOverlay")
        self.size = size
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = 22
        gameOverNode = GameOverNode(levelManager: level)
        self.addChild(gameOverNode)
        self.name = "game over overlay"
    }
}

extension GameOverOverlay: Updatable {
    func update() {
        guard let camera = scene?.camera else {return}
        self.position.x = camera.position.x
    }
}
