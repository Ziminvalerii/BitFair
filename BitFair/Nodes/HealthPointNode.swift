//
//  HealthPointNode.swift
//  BitFair
//
//  Created by Tanya Koldunova on 16.09.2022.
//

import SpriteKit

class HealthPointNode: SKSpriteNode {
    lazy var activeHeart: SKTexture = SKTexture(imageNamed: "heartImage")
    lazy var unactiveHeart: SKTexture = SKTexture(imageNamed: "unactiveHeartImage")
    var hearts: [SKSpriteNode] = [SKSpriteNode]()
    private var startPos = CGPoint.zero
    var hp: Int = 0 {
        didSet {
            for i in 0..<hp {
                hearts[i].texture = activeHeart
            }
            self.hpRemain = hp
        }
    }
    var hpRemain: Int = 0 {
        didSet {
            for i in stride(from: hp, to: hpRemain, by: -1) {
                if i > 0 {
                hearts[i-1].texture = unactiveHeart
                }
            }
        }
    }
    var delegate: Dependable {
        guard let delegate = scene as? Dependable else {
            fatalError("ButtonNode may only be used within a `ButtonNodeResponderType` scene.")
        }
        return delegate
    }
    
    convenience init(sceneSize: CGSize, healthPoints: Int) {
        self.init(color: .clear, size: CGSize(width: NodesSize.coint.size.width * 3 + 10, height: NodesSize.coint.size.height))
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5 )
        self.zPosition = 10
        self.hp = healthPoints
        self.hpRemain = healthPoints
        for i in 0..<healthPoints {
            let heartNode = initHeart()
            let xPos = (self.size.width/2 - heartNode.size.width/2)
            heartNode.position = CGPoint(x: xPos*CGFloat(-1+i), y: 0)
            hearts.append(heartNode)
            self.addChild(heartNode)
        }
        self.position = CGPoint(x: -(sceneSize.width/2-self.size.width/2 - 32), y: (sceneSize.height/2-self.size.height-100))
        self.name = "health point"
    }
    
    func setUpPos(pos: CGPoint) {
        self.position = pos
        self.startPos = position
    }
    
    func setUpXpos(x: CGFloat) {
        self.position.x = x
        startPos = position
    }
    
    private func initHeart()->SKSpriteNode {
        let heart = SKSpriteNode(texture: activeHeart)
        heart.zPosition = 11
        heart.size = NodesSize.coint.size
        return heart
    }
}

extension HealthPointNode: Dependable {
    func receiveMessage<T>(with arguments: T) {
        if let argument = arguments as? Int {
            hpRemain -= argument
        }
        if hpRemain <= 0 {
            self.delegate.switchState(state: .gameOver)
        }
        
    }
}

extension HealthPointNode: Updatable {
    func update() {
        guard let camera = scene?.camera else {return}
        self.position.x = camera.position.x + startPos.x
    }
}


