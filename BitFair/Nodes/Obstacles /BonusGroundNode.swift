//
//  BonusGroundNode.swift
//  BitFair
//
//  Created by Tanya Koldunova on 19.09.2022.
//

import SpriteKit

class BonusGroundNode: SKSpriteNode {
    
    var bonusGrounds = [SKSpriteNode]()
    private var activeTexture = SKTexture(imageNamed: "bonusGround")
    private var unactiveTexture = SKTexture(imageNamed: "unactiveBonusGround")
    
    convenience init(bonusCount: Int) {
        self.init(color: .clear, size: CGSize(width: NodesSize.bonusGround.size.width * CGFloat(bonusCount), height: 40))
//        for i in 0 ..< bonusCount {
//            let bonusGround = createBonusGround()
//            let xPos = (self.size.width/2 - bonusGround.size.width/2)
//            bonusGround.position = CGPoint(x: xPos*CGFloat(-1+i), y: 0)
//            bonusGround.name = "bonusNode-\(i)"
//            bonusGrounds.append(bonusGround)
//            self.addChild(bonusGround)
//        }
        spawnGround(bonusCount: bonusCount)
        
    }
    
    func spawnGround(bonusCount: Int) {
        let spacebetween: CGFloat = (self.size.width - (50 * CGFloat(bonusCount)))/(CGFloat(bonusCount)+1)
        var xPos:CGFloat = -self.size.width/2 + 50/2 + spacebetween
        var yPos :CGFloat = -225
        for i in 0 ..< bonusCount {
            let bonusGround = createBonusGround()
            bonusGround.name = "bonusNode-\(i)"
            bonusGround.position =  CGPoint(x: xPos, y: 0)
            xPos += bonusGround.size.width + spacebetween
            bonusGrounds.append(bonusGround)
            self.addChild(bonusGround)
        }
    }
    
    private func createBonusGround() -> SKSpriteNode {
        let bonusGround = SKSpriteNode(texture: activeTexture)
        bonusGround.size = NodesSize.bonusGround.size
        bonusGround.zPosition = 2
        bonusGround.physicsBody = SKPhysicsBody(rectangleOf: NodesSize.bonusGround.size)
        bonusGround.physicsBody?.isDynamic = false
        bonusGround.physicsBody?.categoryBitMask = PhysicsBitMask.bonusGround.bitMask 
        bonusGround.physicsBody?.contactTestBitMask = PhysicsBitMask.player.bitMask | PhysicsBitMask.enemyWeapon.bitMask | PhysicsBitMask.weapon.bitMask
        bonusGround.physicsBody?.collisionBitMask = PhysicsBitMask.player.bitMask
        return bonusGround
    }
    
    func handleContact(name:String) {
        if let node = self.childNode(withName: name) as? SKSpriteNode {
            if node.texture == activeTexture {
                let cointNode = CoinsNode()
                cointNode.position = CGPoint(x: node.position.x, y: node.position.y + self.size.height/2 + node.size.height/2 + 8)
                cointNode.alpha = 0.0
                let action = SKAction.fadeIn(withDuration: 0.4)
                self.addChild(cointNode)
                cointNode.run(action)
                node.texture = unactiveTexture
            }
        }
    }
}
