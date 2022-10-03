//
//  BatEnemy.swift
//  BitFair
//
//  Created by Tanya Koldunova on 19.09.2022.
//

import SpriteKit

class BatEnemyNode: SKSpriteNode, EnemyProtocol {
   
    var reward: EnemyKillReward!
    var timeInterval = Date().timeIntervalSince1970
    var hp: Int = 2
    var actionEnded: Bool = true
    var head: SKSpriteNode!
    // var initialPos: CGPoint?
    convenience init(reward: EnemyKillReward) {
        self.init(imageNamed: "batEnemy")
        self.size = NodesSize.flyEnemy.size
        self.zPosition = 10
        self.name = "bat enemy"
        self.head = createHead()
        self.addChild(head)
        setUpPhysics()
        self.reward = reward
    }
    
    func setUpPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height - 20))
       // self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        setUpBitMasks()
    }
    
    func setUpBehaviour() {
        self.run(SKAction.repeatForever(SKAction.sequence([SKAction.moveTo(y: self.position.y + 8, duration: 0.6),
                                                           SKAction.moveTo(y: self.position.y - 8, duration: 0.6)
                                                          ])))
    }
    func shootAction(heroPos:CGPoint) {
        guard let scene = self.scene else {return}
        let xpos = self.position.x - scene.size.width/2 - self.size.width
        let yPos =  self.position.y -  scene.size.height/2
        let range = xpos - 400 ... xpos + 300
        let rangeY = yPos - 35 ... self.position.y + 35
            if range.contains(heroPos.x) && rangeY.contains(heroPos.y) {
                if Date().timeIntervalSince1970 - timeInterval > 1 {
                    let weaponeNode = EnemyWeaponNode()
                    weaponeNode.position = CGPoint(x: xpos, y: yPos)
                    scene.addChild(weaponeNode)
                    weaponeNode.applyAction(scene: scene, enemyPos: CGPoint(x: xpos, y: yPos), targetPos: heroPos)
                    timeInterval = Date().timeIntervalSince1970
                }
            }
    }
    func setUpAction() {
        guard let scene = scene else {return}
        if let superhero = scene.childNode(withName: "superhero") as? CharacterProtocol {
            shootAction(heroPos: superhero.position)
        } else if let background = scene.childNode(withName: "background") {
            background.enumerateChildNodes(withName: "tip ground node") { node, error in
                if let superhero = node.childNode(withName: "superhero") as? CharacterProtocol {
                    let superHeroPosition = CGPoint(x: superhero.parent!.position.x - scene.size.width/2 + superhero.position.x, y: superhero.parent!.position.y - scene.size.height/2 + superhero.position.y)
                    self.shootAction(heroPos: superHeroPosition)
                }
            }
        }
        
    }
    
}
