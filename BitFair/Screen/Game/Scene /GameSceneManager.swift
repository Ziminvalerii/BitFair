//
//  GameSceneManager.swift
//  BitFair
//
//  Created by Tanya Koldunova on 13.09.2022.
//

import SpriteKit
import GameplayKit

enum PhysicsBitMask {
    case player
    case ground
    case enemy
    case weapon
    case coint
    case finish
    case bonusGround
    case enemyWeapon
    case starts
    
    var bitMask: UInt32 {
        switch self {
        case .player:
            return 0x1 << 1
        case .ground:
            return 0x1 << 0
        case .enemy:
            return 0x1 << 2
        case .weapon:
            return 0x1 << 3
        case .coint:
            return 0x1 << 4
        case .finish:
            return 0x1 << 5
        case .bonusGround:
            return 0x1 << 6
        case .enemyWeapon:
            return 0x1 << 7
        case .starts:
            return 0x1 << 8
        }
    }
}


class GameSceneManager : NSObject, GameSceneManagerProtocol {
    weak var scene: SKScene?
    lazy var cameraNode: SKCameraNode = SKCameraNode()
    weak var contactManager: ContactManager?
    var parentViewController: GameViewController!
    var toucheble: [Touchable] = [Touchable]()
    var updatable: [Updatable] = [Updatable]()
    var endless: [Endless] = [Endless]()
    var cointsCount: Int = 0 {
        didSet {
            cointsLabel?.setText(text: "Coints amount: \(cointsCount)")
        }
    }
    var starsCount: Int = 0
    var cointsLabel: CointsLabel?
    var audioNodes: [SKAudioNode] = [SKAudioNode]()
    private var gravity = CGVector(dx: 0, dy: -9.8)
    var levelManager: LevelManager
    var hpDelegate: Dependable?
    var starsDelegate: Dependable?
    var contactInterval = Date().timeIntervalSince1970
    var touchedOnce: Bool = false
    
    var playableChacarter: (Mortal)?
    
    required init?(scene : SKScene) {
        self.scene = scene
        self.levelManager = LevelManager(sceneSize: scene.size)
        guard let scene = self.scene else { return nil }
        super.init()
        scene.backgroundColor = .white
        preparePhysicsForWold(for: scene)
        
        configureBackgroundAudio()
        
    }
    
    func preparePhysicsForWold(for scene: SKScene) {
        scene.physicsWorld.gravity = gravity
        scene.physicsWorld.contactDelegate = self
    }
    
    func configureBackgroundAudio() {
        if !UserDefaultsValues.soundOff {
            let playCointsSound = SKAction.playSoundFileNamed("backgroundSound.wav", waitForCompletion: true)
            self.scene?.run(SKAction.repeatForever(playCointsSound), withKey: "play background audio")
        }
    }
    
}

extension GameSceneManager: Dependable {
    func receiveMessage<T>(with arguments: T) {
        if let arguments = arguments as? LevelManager {
            self.levelManager = arguments
        }
    }
}

