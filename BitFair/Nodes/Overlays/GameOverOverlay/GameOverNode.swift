//
//  GameOverNode.swift
//  BitFair
//
//  Created by Tanya Koldunova on 16.09.2022.
//

import SpriteKit

class GameOverNode: SKSpriteNode {
    
    var recurrentWithCoins: RescurrrentButton?
    var recurrentWatchAdd: RescurrrentButton!
    
    lazy var replayButton = ReplayButtonNode()
    lazy var gameOverLabel: SKLabelNode = {
        let text =  NSAttributedString(string: "Game over", attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 32)!, .foregroundColor: UIColor.black])
        let label = SKLabelNode(attributedText: text)
        label.zPosition = 25
        return label
    }()
    lazy var goToStartButton = GoToStartButton()
    lazy var coinsLabel: SKSpriteNode = {
        let coins = SKSpriteNode(imageNamed: "coins")
        coins.zPosition = 25
        let text =  NSAttributedString(string: "Coins: \(UserDefaultsValues.cointsCount)", attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 17)!, .foregroundColor: UIColor.black])
        let label = SKLabelNode(attributedText: text)
        label.zPosition = 25
        label.name = "coins label"
        label.position = CGPoint(x: coins.position.x - label.frame.width/2 - 24, y: -label.frame.size.height/2)
        coins.addChild(label)
        return coins
    }()
    
    convenience init(levelManager: LevelManager) {
        self.init(imageNamed: "shopTexture")
        self.size = NodesSize.shopNode.size
        self.zPosition = 23
        self.name = "game over node"
        
        recurrentWatchAdd = RescurrrentButton(type: .watchAdd, level: levelManager)
        gameOverLabel.position = CGPoint(x: 0, y: self.size.height/2 - gameOverLabel.frame.height - 100)
        coinsLabel.position = CGPoint(x: self.size.width/2 - coinsLabel.size.width - 100, y: gameOverLabel.position.y + gameOverLabel.frame.height/2)
        if UserDefaultsValues.cointsCount < 100 {
            recurrentWatchAdd.position = CGPoint(x: 0, y: gameOverLabel.position.y - recurrentWatchAdd.size.height/2 - 32)
        } else {
            recurrentWithCoins = RescurrrentButton(type: .withCoins, level: levelManager)
            recurrentWithCoins?.position = CGPoint(x: 0, y: gameOverLabel.position.y - recurrentWithCoins!.size.height/2 - 32)
            recurrentWatchAdd.position = CGPoint(x: 0, y: recurrentWithCoins!.position.y - recurrentWatchAdd.size.height/2 - 32)
            self.addChild(recurrentWithCoins!)
        }
        
        self.addChild(gameOverLabel)
        self.addChild(recurrentWatchAdd)
        goToStartButton.position = CGPoint(x: 0, y:-(self.size.height/2 - gameOverLabel.frame.height - 52) )
        replayButton.position = CGPoint(x: 0, y: goToStartButton.position.y + goToStartButton.size.height/2 + 32)
        self.addChild(replayButton)
        self.addChild(goToStartButton)
        self.addChild(coinsLabel)
        
    }
    
    func allTouchableButtons() -> [Touchable] {
        if let recurrentWithCoins = recurrentWithCoins {
        return [recurrentWatchAdd, recurrentWithCoins, replayButton, goToStartButton]
        } else {
            return  [recurrentWatchAdd, replayButton, goToStartButton]
        }
    }
}
