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
    // var initialPos: CGPoint?
    convenience init(reward: EnemyKillReward) {
        self.init(imageNamed: "batEnemy")
        self.size = NodesSize.flyEnemy.size
        self.zPosition = 10
        self.name = "bat enemy"
        setUpPhysics()
        self.reward = reward
    }
    
    func setUpPhysics() {
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
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
    func setUpAction() {
        guard let scene = scene else {return}
        //  self.run(SKAction.repeatForever(SKAction.applyImpulse(CGVector(), duration: <#T##TimeInterval#>)))
        if let superhero = scene.childNode(withName: "superhero") as? CharacterProtocol {
            let xpos = self.position.x - scene.size.width/2 - self.size.width
            let yPos =  self.position.y -  scene.size.height/2
        let range = xpos - 400 ... xpos + 300
        let rangeY = yPos - 35 ... self.position.y + 35
        if range.contains(superhero.position.x) && rangeY.contains(superhero.position.y) {
            if Date().timeIntervalSince1970 - timeInterval > 1 {
                let weaponeNode = EnemyWeaponNode()
                weaponeNode.position = CGPoint(x: xpos, y: yPos)
                scene.addChild(weaponeNode)
                weaponeNode.applyAction(scene: scene, enemyPos: CGPoint(x: xpos, y: yPos), targetPos: superhero.position)
                timeInterval = Date().timeIntervalSince1970
            }
        }
    }
}
//
//    func hitAction() {
//
//    }

}
