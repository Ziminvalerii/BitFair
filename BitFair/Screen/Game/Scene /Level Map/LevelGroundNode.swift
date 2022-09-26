//
//  LevelGroundNode.swift
//  BitFair
//
//  Created by Tanya Koldunova on 23.09.2022.
//

import SpriteKit

class LevelGroundNode: SKSpriteNode {
    lazy var levelGround: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "levelGround")
        node.size = NodesSize.levelGround.size
        node.zPosition = 5
        node.physicsBody = SKPhysicsBody(texture: node.texture!, size: node.size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.categoryBitMask = PhysicsBitMask.ground.bitMask
        node.physicsBody?.collisionBitMask = PhysicsBitMask.player.bitMask
        return node
    }()
    
    var levelName: String!
    var level: Levels! {
        didSet {
            starsCount.gettedStars = level.levelStars
        }
    }
    
    lazy var label: SKLabelNode = {
        let text =  NSAttributedString(string: "text", attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 24)!, .foregroundColor: UIColor.yellow])
        let label = SKLabelNode(attributedText: text)
        label.zPosition = 11
        return label
    }()
    
    lazy var starsCount: StarsNode = {
        let node = StarsNode(sceneSize: CGSize.zero, star: 3)
        return node
        
    }()
    convenience init(currentLevel: Bool, level: Levels) {
        self.init(color: .clear, size: CGSize(width: NodesSize.levelGround.size.width, height: NodesSize.levelGround.size.height + 24))
        levelGround.position = CGPoint(x: 0, y: -self.size.height/2+levelGround.size.height/2)
        levelGround.name = "level ground node \(level.description)"
        starsCount.position = CGPoint(x: levelGround.position.x, y: levelGround.position.y + 48)
        starsCount.stars[1].position.y = starsCount.stars[1].position.y + 32
        starsCount.gettedStars = level.levelStars
        self.level = level
        label.position = CGPoint(x: levelGround.position.x, y: levelGround.position.y + label.frame.height/2 + 24)
        setText(level.description)
        levelName = level.description
        self.addChild(levelGround)
        self.addChild(starsCount)
        self.addChild(label)
    }
    
    private func setText(_ text: String) {
        let text =  NSAttributedString(string: text, attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 24)!, .foregroundColor: UIColor.yellow])
        label.attributedText = text
    }
}
