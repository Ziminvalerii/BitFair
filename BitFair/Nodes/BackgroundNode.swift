//
//  BackgroundNode.swift
//  BitFair
//
//  Created by Tanya Koldunova on 13.09.2022.
//

import SpriteKit

class BackgroundNode: SKSpriteNode {
    
    var ground: SKSpriteNode!
    var background: SKSpriteNode!
    var groundTips: [TipGround] = [TipGround]()
    var coints: [SKSpriteNode] = [SKSpriteNode]()
    var obstacles: [SKSpriteNode] = [SKSpriteNode]()
    var enemies: [SimpleEnemy] = [SimpleEnemy]()
    var batEnemies: [BatEnemyNode] = [BatEnemyNode]()
    var bigEnemies: [BigEnemyNode] = [BigEnemyNode]()
    var bonusGround: [BonusGroundNode] = [BonusGroundNode]()
    var stars: [StarNode] = [StarNode]()
    private var sceneSize: CGSize!
    var levelManager: LevelManager!
    var backGroundCount = 0
    
    lazy var finishNode: SKSpriteNode = {
        let finish = SKSpriteNode(imageNamed: "finishImage")
        finish.zPosition = 10
        finish.physicsBody = SKPhysicsBody(texture: finish.texture!, size: finish.size)
        finish.physicsBody?.isDynamic = false
        finish.physicsBody?.categoryBitMask = PhysicsBitMask.finish.bitMask
        finish.physicsBody?.contactTestBitMask = PhysicsBitMask.player.bitMask
        return finish
    }()
    
    
    var i = 0
    var currentCusrsor = 0.0
    
    
    convenience init(at sceneSize: CGSize, level: LevelManager) {
        self.init(color: .red, size: CGSize(width: sceneSize.width*2, height: sceneSize.height))
        self.sceneSize = sceneSize
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.levelManager = level
        background = createBackgroundNode(at: sceneSize, index: 0)
        ground = createGround(at: sceneSize, index: 0)
        self.backGroundCount = level.currentLevel.countOfBackgroundNodes
        self.addChild(background)
        self.addChild(ground)
        createChilds()
        self.name = "background"
        self.position = CGPoint(x: -sceneSize.width/2, y: -sceneSize.height/2)
    }
    
    
    
    func setUpPhysics(texture: SKTexture, size: CGSize) -> SKPhysicsBody {
        let physicBody = SKPhysicsBody(rectangleOf: size)
        physicBody.isDynamic = false
        physicBody.affectedByGravity = false
        physicBody.categoryBitMask = PhysicsBitMask.ground.bitMask
        physicBody.collisionBitMask = PhysicsBitMask.player.bitMask
        physicBody.contactTestBitMask = PhysicsBitMask.player.bitMask 
        return physicBody
    }
    
    private func createBackgroundNode(at sceneSize: CGSize, index: Int)->SKSpriteNode {
        let background = SKSpriteNode(imageNamed: "background")
        background.size.width =  sceneSize.width
        background.size.height = sceneSize.height
        background.position = CGPoint(x: sceneSize.width/2 + sceneSize.width*CGFloat((i)), y: sceneSize.height*0.5)
        background.zPosition = 1
        return background
    }
    
    private func createGround(at sceneSize: CGSize, index: Int)->SKSpriteNode {
        let ground = SKSpriteNode(imageNamed: "ground")
        ground.size = CGSize(width: sceneSize.width, height: 100)
        ground.position = CGPoint(x: sceneSize.width/2 + sceneSize.width*CGFloat((i)), y: (ground.size.height/2))
        ground.zPosition = 2
        ground.physicsBody = setUpPhysics(texture: ground.texture!, size: ground.size)
        ground.name = "ground"
        return ground
    }
    
     func createChilds() {
        groundTips = levelManager.createTipCound()
        groundTips.forEach { node in
            if node.position.x < sceneSize.width*CGFloat(i+1) {
                self.addChild(node)
                node.setAction()
            }
        }
        coints = levelManager.createCoints()
        coints.forEach { node in
            if node.position.x < sceneSize.width {
                self.addChild(node)
            }
        }
        obstacles = levelManager.createObstacles()
        obstacles.forEach { node in
            if node.position.x < sceneSize.width {
                self.addChild(node)
            }
        }
        enemies = levelManager.createEnemies()
        enemies.forEach { node in
            if node.position.x < sceneSize.width {
                node.physicsBody?.isDynamic = false
                self.addChild(node)
                node.setUpAction()
            }
        }
         batEnemies = levelManager.createBatEnemy()
         batEnemies.forEach { node in
             if node.position.x < sceneSize.width {
                 node.setUpBehaviour()
                 self.addChild(node)
             }
         }
         bonusGround = levelManager.createBonusGround()
         bonusGround.forEach { node in
             if node.position.x < sceneSize.width {
                 self.addChild(node)
             }
         }
         bigEnemies = levelManager.createBigEnemies()
         bigEnemies.forEach { node in
             if node.position.x < sceneSize.width {
                 node.setUpBehaviour()
                 self.addChild(node)
             }
         }
         stars = levelManager.createStars()
         stars.forEach { node in
             if node.position.x < sceneSize.width {
                 self.addChild(node)
             }
         }
    }
}

extension BackgroundNode: Updatable {
    func update() {
        guard let scene = self.scene else {return}
        guard let camera = scene.camera else {return}
        if camera.position.x >= currentCusrsor && i<backGroundCount {
            i+=1
            currentCusrsor += sceneSize.width
            self.size.width += self.size.width
            if i < backGroundCount {
                var backGround = createBackgroundNode(at: sceneSize, index: i)
                var ground = createGround(at: sceneSize, index: i)
                groundTips.forEach { node in
                    if (node.position.x >= currentCusrsor) && (node.position.x < currentCusrsor + sceneSize.width) {
                        node.setAction()
                        self.addChild(node)
                    }
                }
                coints.forEach { node in
                    if (node.position.x >= currentCusrsor) && (node.position.x < currentCusrsor + sceneSize.width) {
                        self.addChild(node)
                    }
                }
                obstacles.forEach { node in
                    if (node.position.x >= currentCusrsor) && (node.position.x < currentCusrsor + sceneSize.width) {
                        self.addChild(node)
                    }
                }
                enemies.forEach { node in
                    if (node.position.x >= currentCusrsor) && (node.position.x < currentCusrsor + sceneSize.width) {
                        node.physicsBody?.isDynamic = false
                        self.addChild(node)
                        node.setUpAction()
                    }
                }
                batEnemies.forEach { node in
                    if (node.position.x >= currentCusrsor) && (node.position.x < currentCusrsor + sceneSize.width) {
                        node.setUpBehaviour()
                        self.addChild(node)
                    }
                }
                bonusGround.forEach { node in
                    if (node.position.x >= currentCusrsor) && (node.position.x < currentCusrsor + sceneSize.width) {
                        self.addChild(node)
                    }
                }
                bigEnemies.forEach { node in
                    if (node.position.x >= currentCusrsor) && (node.position.x < currentCusrsor + sceneSize.width) {
                        node.setUpBehaviour()
                        self.addChild(node)
                    }
                }
                stars.forEach { node in
                    if (node.position.x >= currentCusrsor) && (node.position.x < currentCusrsor + sceneSize.width) {
                        self.addChild(node)
                    }
                }
                self.addChild(backGround)
                self.addChild(ground)
                finishNode.position = CGPoint(x: scene.size.width*CGFloat(backGroundCount) - finishNode.size.width - 32, y: 95 + finishNode.size.height/2)
                if (finishNode.position.x >= currentCusrsor) && (finishNode.position.x < currentCusrsor + sceneSize.width) {
                    self.addChild(finishNode)
                }
            }
          //  }
        }
         self.enumerateChildNodes(withName: "bat enemy", using: { node, error in
            if let node = node as? BatEnemyNode {
                node.setUpAction()
            }
        })
        self.enumerateChildNodes(withName: "big enemy", using: { node, error in
           if let node = node as? BigEnemyNode {
               node.setUpAction()
           }
       })
    }
    
    func convertPointToCurentAnchorPoint(point: CGPoint) {
        return
    }
}
