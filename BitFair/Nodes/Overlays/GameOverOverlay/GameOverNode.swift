//
//  GameOverNode.swift
//  BitFair
//
//  Created by Tanya Koldunova on 16.09.2022.
//

import SpriteKit

class GameOverNode: SKSpriteNode {
    
    var recurrentWithCoins: RescurrrentButton!
    var recurrentWatchAdd: RescurrrentButton!
    
    lazy var replayButton = ReplayButtonNode()
    lazy var gameOverLabel: SKLabelNode = {
        let text =  NSAttributedString(string: "Game over", attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 32)!, .foregroundColor: UIColor.black])
        let label = SKLabelNode(attributedText: text)
        label.zPosition = 25
        return label
    }()
    lazy var goToStartButton = GoToStartButton()
    
    convenience init(levelManager: LevelManager) {
        self.init(imageNamed: "shopTexture")
        self.size = NodesSize.shopNode.size
        self.zPosition = 23
        self.name = "game over node"
        recurrentWithCoins = RescurrrentButton(type: .withCoins, level: levelManager)
        recurrentWatchAdd = RescurrrentButton(type: .watchAdd, level: levelManager)
        
        gameOverLabel.position = CGPoint(x: 0, y: self.size.height/2 - gameOverLabel.frame.height - 100)
        recurrentWithCoins.position = CGPoint(x: 0, y: gameOverLabel.position.y - recurrentWithCoins.size.height/2 - 32)
        recurrentWatchAdd.position = CGPoint(x: 0, y: recurrentWithCoins.position.y - recurrentWatchAdd.size.height/2 - 32)
        self.addChild(gameOverLabel)
        self.addChild(recurrentWithCoins)
        self.addChild(recurrentWatchAdd)
        
        goToStartButton.position = CGPoint(x: 0, y:-(self.size.height/2 - gameOverLabel.frame.height - 52) )
        replayButton.position = CGPoint(x: 0, y: goToStartButton.position.y + goToStartButton.size.height/2 + 32)
        self.addChild(replayButton)
        self.addChild(goToStartButton)
        
    }
    
    func allTouchableButtons() -> [Touchable] {
        return [recurrentWatchAdd, recurrentWithCoins, replayButton, goToStartButton]
    }
}
