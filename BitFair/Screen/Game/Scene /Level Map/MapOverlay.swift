//
//  MapOverlay.swift
//  BitFair
//
//  Created by Tanya Koldunova on 22.09.2022.
//

import SpriteKit

class MapOverlay: SKSpriteNode {
    var shouldAcceptTouches: Bool = true 
    var selectedLevel: Levels! {
        didSet {
            configureButton()
        }
    }
    var levelManager: LevelManager! {
        didSet {
            for level in levels {
                if let levManager = levelManager.levels.first(where: {$0.description == level.levelName}) {
                    level.level = levManager
                }
            }
            self.configureButton()
            coinsLabel.setText(text: "Coins: \(UserDefaultsValues.cointsCount)")
        }
    }
    private var radius: CGFloat = 150.0
    
    var delegate: Dependable {
        guard let delegate = scene as? Dependable else {
            fatalError("ButtonNode may only be used within a `ButtonNodeResponderType` scene.")
        }
        return delegate
    }
    var gameSceneDelegate: Dependable?
    var playButtonTexture = SKTexture(imageNamed: "buyButtonContainer")
    var lockButtonTextureb = SKTexture(imageNamed: "buttonTexture")
    
    //MARK: Nodes
    
    var levels: [LevelGroundNode] = [LevelGroundNode]()
    
    lazy var coinsLabel = CointsLabel(red: false)
    
    lazy var levelLabel: SKLabelNode = {
        let text =  NSAttributedString(string: "Level: 1", attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 32)!, .foregroundColor: UIColor.black])
        let label = SKLabelNode(attributedText: text)
        label.zPosition = 11
        return label
    }()
    
    lazy var playLevel: SKSpriteNode = {
        let node = SKSpriteNode(texture: playButtonTexture)
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node.size = NodesSize.playButton.size
        node.zPosition = 20
        node.name = "play button node"
        let text =  NSAttributedString(string: "Play", attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 17)!, .foregroundColor: UIColor.white])
        let label = SKLabelNode(attributedText: text)
        label.position = CGPoint(x: 0, y:  -label.frame.size.height/2)
        label.zPosition = 21
        label.name = "play label node"
        node.addChild(label)
        return node
    }()
    
    lazy var backButton: SKSpriteNode = {
        let node = SKSpriteNode(texture: playButtonTexture)
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node.size = NodesSize.buyButtons.size
        node.zPosition = 20
        node.name = "back button node"
        let text =  NSAttributedString(string: "Back", attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 17)!, .foregroundColor: UIColor.white])
        let label = SKLabelNode(attributedText: text)
        label.position = CGPoint(x: 0, y:  -label.frame.size.height/2)
        label.zPosition = 21
        label.name = "back label node"
        node.addChild(label)
        return node
    }()
    
    convenience init(at size: CGSize, levelManager: LevelManager) {
        self.init(imageNamed: "mapOverlay")
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.alpha = 0
        self.size = size
        self.zPosition = 4
        self.name = "map overlay node"
        playLevel.position = CGPoint(x: 0, y: -size.height/2 + playLevel.size.height/2 + 100)
        levelLabel.position = CGPoint(x: 0, y: size.height/2 - levelLabel.frame.height/2 - 100)
        backButton.size = coinsLabel.size
        backButton.position = CGPoint(x: size.width/2 - backButton.size.width/2 - 64, y: levelLabel.position.y)
        coinsLabel.position = CGPoint(x: -size.width/2 + coinsLabel.size.width/2 + 64, y: levelLabel.position.y)
        coinsLabel.setText(text: "Coins: \(UserDefaultsValues.cointsCount)")
        spawnLevels(levelManager: levelManager)
        self.levelManager = levelManager
        selectedLevel = levelManager.levels[0]
        self.addChild(levelLabel)
        self.addChild(playLevel)
        self.addChild(backButton)
        self.addChild(coinsLabel)
    }
    
    func apear() {
        self.run(SKAction.fadeIn(withDuration: 0.1))
    }
    
    func dissapear() {
        self.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.1), SKAction.removeFromParent()]))
    }
    
    func createLevelGround(_ text: String)->SKLabelNode {
        let text =  NSAttributedString(string: text, attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 32)!, .foregroundColor: UIColor.yellow])
        let label = SKLabelNode(attributedText: text)
        label.zPosition = 11
        return label
    }
    
    func changePos(level: LevelGroundNode, to i: Int) {
        let angle = 2 * Double.pi / Double(levels.count) * Double(i)
        let levelX = radius * sin(CGFloat(angle))
        let levelY = radius * cos(CGFloat(angle))
        let changePosition = CGPoint(x: levelX + frame.midX, y: levelY + frame.midY + 16)
        level.run(SKAction.move(to: changePosition, duration: 0.2))
    }
    
    func spawnLevels(levelManager: LevelManager) {
        for i in 0..<levelManager.levels.count {
            let angle = 2 * Double.pi / Double(levelManager.levels.count) * Double(i)
            let levelX = radius * sin(CGFloat(angle))
            let levelY = radius * cos(CGFloat(angle))
            let level = LevelGroundNode(currentLevel: false, level: levelManager.levels[i])
            level.position = CGPoint(x: levelX + frame.midX, y: levelY + frame.midY + 16)
            levels.append(level)
            addChild(level)
        }
    }
    
    private func configureButton() {
        var available: Bool = false
        for level in levelManager.availableLevels {
            if selectedLevel.levelKey == level.levelKey {
                available = true
            }
        }
        playLevel.texture = available ? playButtonTexture : lockButtonTextureb
        setPlayLabel(available: available)
    }
}

