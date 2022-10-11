//
//  LevelManager.swift
//  BitFair
//
//  Created by Tanya Koldunova on 15.09.2022.
//

import SpriteKit

class LevelManager {
    var currentLevel: Levels
    lazy var availableLevels: [Levels] = [Levels]()
    var unCompletedLevels: [Levels]?
    var levels: [Levels]
    var completeCurrentLevel: Bool = false
    
    init(sceneSize: CGSize) {
        self.levels = Levels.toArray(sceneSize: sceneSize)
        self.currentLevel = levels[2]
        setAvailableLevels()
    }
    
    func createTipCound()-> [TipGround] {
        var tipGrounds = [TipGround]()
        for i in 0..<currentLevel.tipPoints.count {
            let tipGround = TipGround(state: currentLevel.tipPoints[i].0)
            tipGround.position = currentLevel.tipPoints[i].1
            //  tipGround.name = i.description
            tipGrounds.append(tipGround)
        }
        return tipGrounds
    }
    
    func setAvailableLevels() {
        availableLevels.removeAll()
        var completedLevels: [Levels] = [Levels]()
        for level in levels {
            if let lev = UserDefaultsValues.levelInfo[level.levelKey] {
                completedLevels.append(level)
            }
        }
        availableLevels.append(contentsOf: completedLevels)
        if availableLevels.count < 3 {
        availableLevels.append(levels[completedLevels.count])
        }
        print(availableLevels)
    }
    
    func setLevelInfo(stars: Int) {
        var level = UserDefaultsValues.levelInfo
        var levelExist: Bool = false
        var index = 0
        print("----- stars \(stars)")
        if let lev = UserDefaultsValues.levelInfo[currentLevel.levelKey] {
            if lev < stars {
                level[currentLevel.levelKey] = stars
            }
        } else {
            level[currentLevel.levelKey] = stars
        }
        UserDefaultsValues.levelInfo = level
        setAvailableLevels()
    }
    
    func createStars() -> [StarNode] {
        var stars = [StarNode]()
        for pos in currentLevel.starPosition {
            let star = StarNode()
            star.position = pos
            stars.append(star)
        }
        return stars
    }
    
    func setToIntroudctionLevel() {
        currentLevel = levels[0]
    }
    
    func createCoints() -> [SKSpriteNode] {
        var coints = [SKSpriteNode]()
        for pos in currentLevel.cointsPoint {
            let coint = CoinsNode()
            coint.position = pos
            coints.append(coint)
        }
        
        return coints
    }
    
    func createObstacles()->[SKSpriteNode] {
        var obstacles = [SKSpriteNode]()
        for pos in currentLevel.obstaclePoints {
            let obstacle = createObstacle()
            obstacle.position = pos
            obstacles.append(obstacle)
        }
        return obstacles
    }
    
    func createLevelsGround() -> [SKSpriteNode] {
        var levelsGround = [LevelGroundNode]()
        for level in self.levels {
            let lev = LevelGroundNode(currentLevel: false, level: level)
            lev.position = level.levelPosition
            levelsGround.append(lev)
        }
        return levelsGround
    }
    
    
    
    func createEnemies() -> [SimpleEnemy] {
        var enemies = [SimpleEnemy]()
        for pos in currentLevel.enemyPosition {
            let enemy = SimpleEnemy(reward: pos.0)
            enemy.position = pos.1
            enemies.append(enemy)
        }
        return enemies
    }
    
    func createObstacle() -> SKSpriteNode {
        
        let obstacleNode = SKSpriteNode(imageNamed: "obstacle")
        obstacleNode.size = NodesSize.obstacle.size
        obstacleNode.zPosition = 3
        obstacleNode.physicsBody = SKPhysicsBody(rectangleOf: obstacleNode.size)
        //   obstacleNode.physicsBody = SKPhysicsBody(texture: obstacleNode.texture!, size: obstacleNode.size)
        obstacleNode.physicsBody?.isDynamic = false
        obstacleNode.physicsBody?.affectedByGravity = false
        obstacleNode.physicsBody?.categoryBitMask = PhysicsBitMask.ground.bitMask
        obstacleNode.physicsBody?.collisionBitMask = PhysicsBitMask.player.bitMask
        obstacleNode.physicsBody?.contactTestBitMask = PhysicsBitMask.enemyWeapon.bitMask | PhysicsBitMask.weapon.bitMask
        obstacleNode.physicsBody?.usesPreciseCollisionDetection = true
        return obstacleNode
    }
    
    func createBonusGround()->[BonusGroundNode] {
        var bonusGrounds = [BonusGroundNode]()
        for item in currentLevel.bonusCountInGrount {
            let bonusGround = BonusGroundNode(bonusCount: item.0)
            bonusGround.position = item.1
            bonusGrounds.append(bonusGround)
        }
        return bonusGrounds
    }
    
    func createBatEnemy()->[BatEnemyNode] {
        var batEnemies = [BatEnemyNode]()
        for pos in currentLevel.batEnemyPosition {
            let batEnemy = BatEnemyNode(reward: pos.0)
            batEnemy.position = pos.1
            batEnemies.append(batEnemy)
        }
        return batEnemies
    }
    
    func createBigEnemies()->[BigEnemyNode] {
        var bigEnemies = [BigEnemyNode]()
        for pos in currentLevel.bigEnemies {
            let bigEnemy = BigEnemyNode(reward: pos.0)
            bigEnemy.position = pos.1
            bigEnemies.append(bigEnemy)
        }
        return bigEnemies
    }
}


enum Levels {
    case first(CGSize)
    case second(CGSize)
    case third(CGSize)
    case fourth(CGSize)
    case fifth(CGSize)
    
    static func toArray(sceneSize:CGSize)->[Levels] {
        return [.first(sceneSize), .second(sceneSize), .third(sceneSize)]
    }
    
    var levelKey: String {
        switch self {
        case .first(_):
            return "com.firstLevel.key"
        case .second(_):
            return "com.secondLevel.key"
        case .third(_):
            return "com.thirdLevel.key"
        case .fourth(_):
            return "com.fourthLevel.key"
        case .fifth(_):
            return "com.fifthLevel.key"
        }
    }
    
    var levelStars: Int {
        var stars: Int = 0
        if let star = UserDefaultsValues.levelInfo[levelKey] {
            stars = star
        }
        return stars
    }
    
    var description:String {
        switch self {
        case .first(let cGSize):
            return "1"
        case .second(let cGSize):
            return "2"
        case .third(let cGSize):
            return "3"
        case .fourth(let cGSize):
            return "4"
        case .fifth(let cGSize):
            return "5"
        }
    }
    
    var countOfBackgroundNodes: Int {
        switch self {
        case .first(_):
            return 6
        case .second(_):
            return 6
        case .third(_):
            return 8
        case .fourth(_):
            return 10
        case .fifth(_):
            return 11
        }
    }
    
    var levelPosition: CGPoint {
        switch self {
        case .first(let sceneSize):
            return CGPoint(x: -sceneSize.width/2 + NodesSize.levelGround.size.width/2 + 150, y: -sceneSize.height/2 + NodesSize.levelGround.size.height/2 + 250)
        case .second(let sceneSize):
            return CGPoint(x: 0, y: sceneSize.height/2 - NodesSize.levelGround.size.height/2 - 300)
        case .third(let sceneSize):
            return CGPoint(x: sceneSize.width/2 - NodesSize.levelGround.size.width/2 - 150, y: -sceneSize.height/2 + NodesSize.levelGround.size.height/2 + 250)
        case .fourth(let cGSize):
            return CGPoint.zero
        case .fifth(let cGSize):
            return CGPoint.zero
        }
    }
    
    var bonusCountInGrount: [(Int, CGPoint)] {
        switch self {
        case .first(_):
            return [(Int, CGPoint)]()
        case .second(let sceneSize):
            return [(1, CGPoint(x: sceneSize.width*0.8, y: sceneSize.height*0.4)),
                    (2, CGPoint(x: sceneSize.width*2.8, y: sceneSize.height*0.5)),
                    (3, CGPoint(x: sceneSize.width*3.3, y: sceneSize.height*0.35)),
                    (1, CGPoint(x: sceneSize.width*3.3 + NodesSize.bonusGround.size.width, y: sceneSize.height*0.6))]
        case .third(let sceneSize):
            return [(2, CGPoint(x: sceneSize.width*1.4, y: sceneSize.height*0.36)),
                    (1, CGPoint(x: sceneSize.width*1.8, y: sceneSize.height*0.6)),
                    (5, CGPoint(x: sceneSize.width*3.6, y: sceneSize.height*0.4)),
                    (2, CGPoint(x: sceneSize.width*4.8, y: sceneSize.height*0.9)),
                    (1, CGPoint(x: sceneSize.width*5.5, y: sceneSize.height*0.4)),
                    (3, CGPoint(x: sceneSize.width*5.7, y: sceneSize.height*0.4)),
                    (3, CGPoint(x: sceneSize.width*5.8, y: sceneSize.height*0.6)),
            ]
        case .fourth(_):
            return [(Int, CGPoint)]()
        case .fifth(_):
            return [(Int, CGPoint)]()
        }
    }
    
    var tipPoints: [(GroundState, CGPoint)] {
        switch self {
        case .first(let sceneSize):
            return [(.stop,CGPoint(x: sceneSize.width/3, y: sceneSize.height/2)),
                    (.stop, CGPoint(x: 1.6*sceneSize.width, y: sceneSize.height/3)),
                    (.stop, CGPoint(x: 2.9*sceneSize.width, y: sceneSize.height/3)),
                    (.stop, CGPoint(x: 3.1*sceneSize.width, y: sceneSize.height/2)),
                    (.stop, CGPoint(x: 4.8*sceneSize.width, y: sceneSize.height/3))]
        case .second(let sceneSize):
            return [(.stop, CGPoint(x: sceneSize.width/4, y: sceneSize.height/4)),
                    (.stop, CGPoint(x: sceneSize.width*1.2, y: sceneSize.height*0.28)),
                    (.stop, CGPoint(x: sceneSize.width*1.4, y: sceneSize.height*0.4)),
                    (.stop, CGPoint(x: sceneSize.width*1.6, y: sceneSize.height*0.6)),
                    (.stop, CGPoint(x: sceneSize.width*2.5, y: sceneSize.height*0.3)),
                    (.stop, CGPoint(x: sceneSize.width*4.3, y: sceneSize.height*0.35)),
            ]
        case .third(let sceneSize):
            return [(.stop, CGPoint(x: sceneSize.width*0.8, y: sceneSize.height/4)),
                    (.stop, CGPoint(x: sceneSize.width*1.65, y: sceneSize.height*0.5)),
                    (.upDown, CGPoint(x: sceneSize.width*2.3, y: sceneSize.height*0.4)),
                    (.stop, CGPoint(x: sceneSize.width*2.4, y: sceneSize.height*0.7)),
                    (.upDown, CGPoint(x: sceneSize.width*4.1, y: sceneSize.height*0.4)),
                    (.leftRight, CGPoint(x: sceneSize.width*4.5, y: sceneSize.height*0.6)),
                    (.leftRight, CGPoint(x: sceneSize.width*4.8, y: sceneSize.height*0.6)),
                    (.stop, CGPoint(x: sceneSize.width*5.2, y: sceneSize.height*0.6)),
                    (.stop, CGPoint(x: sceneSize.width*5.4, y: sceneSize.height*0.4)),
            ]
        case .fourth(_):
            return [(GroundState, CGPoint)]()
        case .fifth(_):
            return [(GroundState, CGPoint)]()
        }
    }
    
    var obstaclePoints: [CGPoint] {
        switch self {
        case .first(let sceneSize):
            return [CGPoint(x: sceneSize.width*1.3, y: 95 + NodesSize.obstacle.size.height/2),
                    CGPoint(x: sceneSize.width*2.1, y: 95 + NodesSize.obstacle.size.height/2),
                    CGPoint(x: sceneSize.width*2.3, y: 95 + NodesSize.obstacle.size.height/2),
                    CGPoint(x: sceneSize.width*3.6, y: 95 + NodesSize.obstacle.size.height/2),
                    CGPoint(x: sceneSize.width*4.2, y: 95 + NodesSize.obstacle.size.height/2),
                    CGPoint(x: sceneSize.width*5.3, y: 95 + NodesSize.obstacle.size.height/2)
            ]
        case .second(let sceneSize):
            return [CGPoint(x: sceneSize.width*2.2, y: 95 + NodesSize.obstacle.size.height/2),
                    CGPoint(x: sceneSize.width*3.6, y: 95 + NodesSize.obstacle.size.height/2),
                    CGPoint(x: sceneSize.width*3.8, y: 95 + NodesSize.obstacle.size.height/2),
                    CGPoint(x: sceneSize.width*4.9, y: 95 + NodesSize.obstacle.size.height/2),
                    CGPoint(x: sceneSize.width*5.2, y: 95 + NodesSize.obstacle.size.height/2),
            ]
        case .third(let sceneSize):
            return [CGPoint(x: sceneSize.width*0.9, y: 95 + NodesSize.obstacle.size.height/2),
                    CGPoint(x: sceneSize.width*1.9, y: 95 + NodesSize.obstacle.size.height/2),
                    CGPoint(x: sceneSize.width*2.9, y: 95 + NodesSize.obstacle.size.height/2),
                    CGPoint(x: sceneSize.width*3.0, y: 95 + NodesSize.obstacle.size.height/2),
                    CGPoint(x: sceneSize.width*3.1, y: 95 + NodesSize.obstacle.size.height/2),
                    CGPoint(x: sceneSize.width*4.2, y: 95 + NodesSize.obstacle.size.height/2),
                    CGPoint(x: sceneSize.width*5.3, y: 95 + NodesSize.obstacle.size.height/2),
                    CGPoint(x: sceneSize.width*6.6, y: 95 + NodesSize.obstacle.size.height/2)
            ]
        case .fourth(_):
            return [CGPoint]()
        case .fifth(_):
            return [CGPoint]()
        }
    }
    
    var cointsPoint: [CGPoint] {
        switch self {
        case .first(let sceneSize):
            var points = pointsOfCointsFirstLevel(sceneSize: sceneSize)
            let xPos = NodesSize.tipGround.size.width/2 - NodesSize.coint.size.width/2
            let yPos = NodesSize.tipGround.size.height/2 +  NodesSize.tipGround.size.height/2
            let tipGroundPoints = [CGPoint(x: tipPoints[1].1.x, y: tipPoints[1].1.y + yPos),
                                   CGPoint(x: tipPoints[2].1.x - xPos, y: tipPoints[2].1.y + yPos),
                                   CGPoint(x: tipPoints[2].1.x + xPos, y: tipPoints[2].1.y + yPos),
                                   CGPoint(x: tipPoints[3].1.x - xPos, y: tipPoints[3].1.y + yPos),
                                   CGPoint(x: tipPoints[3].1.x + xPos, y: tipPoints[3].1.y + yPos),
                                   CGPoint(x: tipPoints[3].1.x, y: tipPoints[3].1.y + yPos)
            ]
            points.append(contentsOf: tipGroundPoints)
            return points
        case .second(let sceneSize):
            let xPos = NodesSize.tipGround.size.width/2 - NodesSize.coint.size.width/2
            let yPos = NodesSize.tipGround.size.height/2 +  NodesSize.tipGround.size.height/2
            return [CGPoint(x: 0.8*sceneSize.width, y: 200),
                    CGPoint(x: 0.84*sceneSize.width, y: 200),
                    CGPoint(x: 0.88*sceneSize.width, y: 200),
                    CGPoint(x: 1.5*sceneSize.width, y: 200),
                    CGPoint(x: 1.6*sceneSize.width, y: 200),
                    CGPoint(x: 1.7*sceneSize.width, y: 200),
                    CGPoint(x: 1.8*sceneSize.width, y: 200),
                    CGPoint(x: 2.2*sceneSize.width, y: 200),
                    CGPoint(x: 2.4*sceneSize.width, y: 200),
                    CGPoint(x: 2.6*sceneSize.width, y: 200),
                    CGPoint(x: 3.4*sceneSize.width, y: 200),
                    CGPoint(x: 3.45*sceneSize.width, y: 200),
                    CGPoint(x: 3.5*sceneSize.width, y: 200),
                    CGPoint(x: 4.0*sceneSize.width, y: 200),
                    CGPoint(x: 4.4*sceneSize.width, y: 200),
                    CGPoint(x: 4.8*sceneSize.width, y: 200),
                    CGPoint(x: 5.2*sceneSize.width, y: 200),
                    CGPoint(x: 5.4*sceneSize.width, y: 200),
                    CGPoint(x: 5.6*sceneSize.width, y: 200),
                    CGPoint(x: tipPoints[1].1.x, y: tipPoints[1].1.y+yPos),
                    CGPoint(x: tipPoints[2].1.x-xPos, y: tipPoints[2].1.y+yPos),
                    CGPoint(x: tipPoints[2].1.x+xPos, y: tipPoints[2].1.y+yPos),
                    CGPoint(x: tipPoints[4].1.x-xPos, y: tipPoints[4].1.y+yPos),
                    CGPoint(x: tipPoints[4].1.x, y: tipPoints[4].1.y+yPos),
                    CGPoint(x: tipPoints[4].1.x+xPos, y: tipPoints[4].1.y+yPos)
            ]
        case .third(let sceneSize):
            let xPos = NodesSize.tipGround.size.width/2 - NodesSize.coint.size.width/2
            let yPos = NodesSize.tipGround.size.height/2 +  NodesSize.tipGround.size.height/2
            return [CGPoint(x: 1.1*sceneSize.width, y: 200),
                    CGPoint(x: 1.2*sceneSize.width, y: 200),
                    CGPoint(x: 1.3*sceneSize.width, y: 200),
                    CGPoint(x: 2.1*sceneSize.width, y: 200),
                    CGPoint(x: 2.9*sceneSize.width, y: 200),
                    CGPoint(x: 4.1*sceneSize.width, y: 200),
                    CGPoint(x: 5.1*sceneSize.width, y: 200),
                    CGPoint(x: 5.2*sceneSize.width, y: 200),
                    CGPoint(x: 5.3*sceneSize.width, y: 200),
                    CGPoint(x: 5.4*sceneSize.width, y: 200),
                    CGPoint(x: 5.5*sceneSize.width, y: 200),
                    CGPoint(x: tipPoints[0].1.x-xPos, y: tipPoints[0].1.y+yPos),
                    CGPoint(x: tipPoints[0].1.x+xPos, y: tipPoints[0].1.y+yPos),
                    CGPoint(x: tipPoints[3].1.x-xPos, y: tipPoints[3].1.y+yPos),
                    CGPoint(x: tipPoints[3].1.x, y: tipPoints[3].1.y+yPos),
                    CGPoint(x: tipPoints[3].1.x+xPos, y: tipPoints[3].1.y+yPos),
                    CGPoint(x: tipPoints[7].1.x-xPos, y: tipPoints[7].1.y+yPos),
                    CGPoint(x: tipPoints[7].1.x+xPos, y: tipPoints[7].1.y+yPos),
            ]
        case .fourth(_):
            return [CGPoint]()
        case .fifth(_):
            return [CGPoint]()
        }
    }
    
    var starPosition: [CGPoint] {
        switch self {
        case .first(let sceneSize):
            let xPos = NodesSize.tipGround.size.width/2 - NodesSize.coint.size.width/2
            let yPos = NodesSize.tipGround.size.height/2 +  NodesSize.tipGround.size.height/2
            return [CGPoint(x: tipPoints[4].1.x, y: tipPoints[4].1.y+yPos),
                    CGPoint(x: sceneSize.width*5.5, y: 200)]
        case .second(let sceneSize):
            let xPos = NodesSize.tipGround.size.width/2 - NodesSize.coint.size.width/2
            let yPos = NodesSize.tipGround.size.height/2 +  NodesSize.tipGround.size.height/2
            return [CGPoint(x: tipPoints[3].1.x, y: tipPoints[3].1.y+yPos)]
        case .third(let sceneSize):
            let xPos = NodesSize.tipGround.size.width/2 - NodesSize.coint.size.width/2
            let yPos = NodesSize.tipGround.size.height/2 +  NodesSize.tipGround.size.height/2
            return [CGPoint(x: tipPoints[8].1.x, y: tipPoints[8].1.y+yPos)]
        case .fourth(let sceneSize):
            return [CGPoint]()
        case .fifth(let sceneSize):
            return [CGPoint]()
        }
    }
    
    var enemyPosition: [(EnemyKillReward, CGPoint)] {
        switch self {
        case .first(let sceneSize):
            return [
                (.coins(2), CGPoint(x: 0.6*sceneSize.width, y: 102 + NodesSize.simpleEnemy.size.height/2)),
                (.no, CGPoint(x: 1.4*sceneSize.width, y: 102 + NodesSize.simpleEnemy.size.height/2)),
                (.stars(1), CGPoint(x: 2.2*sceneSize.width, y: 102 + NodesSize.simpleEnemy.size.height/2)),
                (.coins(4), CGPoint(x: 3.8*sceneSize.width, y: 102 + NodesSize.simpleEnemy.size.height/2))
            ]
        case .second(let sceneSize):
            return [(.no, CGPoint(x: 2.0*sceneSize.width, y: 102 + NodesSize.simpleEnemy.size.height/2)),
                    (.coins(4), CGPoint(x: 3.7*sceneSize.width, y: 102 + NodesSize.simpleEnemy.size.height/2)),
                    (.coins(4), CGPoint(x: 5.0*sceneSize.width, y: 102 + NodesSize.simpleEnemy.size.height/2)),
                    (.no, CGPoint(x: 5.5*sceneSize.width, y: 102 + NodesSize.simpleEnemy.size.height/2)),
                    (.no, CGPoint(x: 5.5*sceneSize.width, y: 102 + NodesSize.simpleEnemy.size.height/2)),
                    (.coins(6), CGPoint(x: 1.4*sceneSize.width, y: sceneSize.height*0.4 + NodesSize.simpleEnemy.size.height/2 + 24)),
                    (.coins(6), CGPoint(x: 2.5*sceneSize.width, y: sceneSize.height*0.3 + NodesSize.simpleEnemy.size.height/2 + 24)),
            ]
        case .third(let sceneSize):
            return [(.coins(2), CGPoint(x: 0.8*sceneSize.width, y: sceneSize.height/4 + NodesSize.simpleEnemy.size.height/2 + 24)),
                    (.no, CGPoint(x: 2.1*sceneSize.width, y: 102 + NodesSize.simpleEnemy.size.height/2)),
                    (.no, CGPoint(x: 3.3*sceneSize.width, y: 102 + NodesSize.simpleEnemy.size.height/2)),
                    (.coins(4), CGPoint(x: 5.5*sceneSize.width, y: 102 + NodesSize.simpleEnemy.size.height/2)),
            ]
        case .fourth(_):
            return [(EnemyKillReward, CGPoint)]()
        case .fifth(_):
            return [(EnemyKillReward, CGPoint)]()
        }
    }
    
    var batEnemyPosition: [(EnemyKillReward, CGPoint)] {
        switch self {
        case .first(_):
            return [(EnemyKillReward, CGPoint)]()
        case .second(let sceneSize):
            return [(.coins(12), CGPoint(x: 0.9*sceneSize.width, y: 0.5*sceneSize.height)),
                    (.stars(1), CGPoint(x: 1.7*sceneSize.width, y: sceneSize.height*0.7)),
                    (.stars(1), CGPoint(x: 3.5*sceneSize.width, y: sceneSize.height*0.7))
            ]
        case .third(let sceneSize):
            return [(.coins(6), CGPoint(x: sceneSize.width*1.7, y: sceneSize.height*0.7)),
                    (.coins(6), CGPoint(x: sceneSize.width*2.54, y: sceneSize.height*0.54)),
                    (.stars(1), CGPoint(x: 3.8*sceneSize.width, y: sceneSize.height*0.5)),
                    (.coins(6), CGPoint(x: 4.3*sceneSize.width, y: sceneSize.height*0.4)),
                    (.coins(12), CGPoint(x: sceneSize.width*5.8, y: sceneSize.height*0.5))
            ]
        case .fourth(let cGSize):
            return [(EnemyKillReward, CGPoint)]()
        case .fifth(let cGSize):
            return [(EnemyKillReward, CGPoint)]()
        }
    }
    
    var bigEnemies: [(EnemyKillReward, CGPoint)] {
        switch self {
        case .first(_):
            return [(EnemyKillReward, CGPoint)]()
        case .second(_):
            return [(EnemyKillReward, CGPoint)]()
        case .third(let sceneSize):
            return  [(.stars(1), CGPoint(x: 1.8 * sceneSize.width, y: 60 + NodesSize.mainCharacter.size.height)),
                     (.coins(20), CGPoint(x: 3.8 * sceneSize.width, y: 60 + NodesSize.mainCharacter.size.height)),
            ]
        case .fourth(_):
            return [(EnemyKillReward, CGPoint)]()
        case .fifth(_):
            return [(EnemyKillReward, CGPoint)]()
        }
    }
    
    var cointsForRescurent: Int {
        switch self {
        case .first(_):
            return 100
        case .second(_):
            return 100
        case .third(_):
            return 100
        case .fourth(_):
            return 100
        case .fifth(_):
            return 100
        }
    }
    
    
    private func pointsOfCointsFirstLevel(sceneSize: CGSize) -> [CGPoint] {
        var step = sceneSize.width
        var prevPos: CGFloat = 0
        var position: [CGPoint] = [CGPoint]()
        for i in 0 ..< (countOfBackgroundNodes-1)*3{
            if i%3 != 0 || i==0 {
                let pos = CGPoint(x: step - 30*3 + prevPos, y: 200)
                prevPos += 30 + 16
                position.append(pos)
            } else {
                step += sceneSize.width
                prevPos = 0
                let pos = CGPoint(x: step - 30*3 + prevPos, y: 200)
                prevPos += 30 + 16
                position.append(pos)
            }
        }
        return position
    }
    
    
    
    
}
