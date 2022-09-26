//
//  BigEnemy.swift
//  BitFair
//
//  Created by Tanya Koldunova on 20.09.2022.
//

import SpriteKit

class BigEnemyNode: SKSpriteNode, EnemyProtocol {
    var hp: Int = 4
    var timeInterval = Date().timeIntervalSince1970
    var reward: EnemyKillReward!
    convenience init(reward: EnemyKillReward) {
        self.init(imageNamed: "bigEnemy")
        self.size = NodesSize.mainCharacter.size
        self.zPosition = 10
        self.setUpPhysics()
        self.reward = reward
    }
    
    func setUpPhysics() {
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
        setUpBitMasks()
        self.name = "big enemy"
    }
    
    func setUpBehaviour() {
        let customActionBlock: (SKNode, CGFloat)->Void = { (node, elapsedTime) in
            guard let scene = self.scene else {return}
            if let superhero = scene.childNode(withName: "superhero") as? CharacterProtocol {
                let nodeX = self.position.x - scene.size.width/2
                let nodeY =  self.position.y -  scene.size.height/2
                let dx = superhero.position.x - nodeX
                let dy = superhero.position.y - nodeY
                let angle = atan2(dx,dy)
                node.position.x += angle*1.2
             //   node.position.y += cos(angle) * 1.5
            }
        }
        
        let duration = TimeInterval(Int.max) //want the action to run infinitely
        let followPlayer = SKAction.customAction(withDuration:duration,actionBlock:customActionBlock)
        self.run(followPlayer ,withKey:"follow")
    }
    
    func setUpAction() {
        guard let scene = scene else {return}
        if let superhero = scene.childNode(withName: "superhero") as? CharacterProtocol {
            let xpos = self.position.x - scene.size.width/2 - self.size.width 
            let yPos =  self.position.y -  scene.size.height/2
            let range = xpos - 400 ... xpos + 300
            let rangeY = yPos - 35 ... self.position.y + 35
            if range.contains(superhero.position.x) && rangeY.contains(superhero.position.y) {
                if Date().timeIntervalSince1970 - timeInterval > 0.5 {
                    let weaponeNode = UpgratedEnemyWeaponNode()
                    weaponeNode.position = CGPoint(x: xpos, y: yPos)
                    scene.addChild(weaponeNode)
                    weaponeNode.applyAction(scene: scene, enemyPos: CGPoint(x: xpos, y: yPos), targetPos: superhero.position)
                    timeInterval = Date().timeIntervalSince1970
                }
            }
        }
    }
    
    
}
