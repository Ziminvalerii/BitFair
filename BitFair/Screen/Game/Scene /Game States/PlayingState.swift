//
//  PlayingState.swift
//  BitFair
//
//  Created by Tanya Koldunova on 13.09.2022.
//

import GameplayKit

class PlayingState: GKState {
    weak var gameSceneManager: GameSceneManager?
    var hpNode: HealthPointNode!
    var startsCountNode: StarsNode!
    lazy var cointsLabel = CointsLabel(red: true)
    var backgroundNode: BackgroundNode!
    var playerNode: CharacterProtocol!
    var joistickNode: Joistick!
    var upHitJoistick: UpHitJoistick!
    lazy var backButton = BackButtonNode()
   // var settingsButton: SettingsButtonNode!
    
    init(gameSceneManager: GameSceneManager) {
        self.gameSceneManager = gameSceneManager
       
    }
    override func didEnter(from previousState: GKState?) {
        guard let gameSceneManager = gameSceneManager else {return}
        guard let scene = gameSceneManager.scene else {return}
        if let previousState = previousState as? RescurentState {
            guard let character = gameSceneManager.playableChacarter else {return}
            let healthNode = scene.childNode(withName: "health point") as! HealthPointNode
            healthNode.hp = character.hp
            
            return
        }
        gameSceneManager.cointsCount = 0 
        gameSceneManager.touchedOnce = false
        playerNode = UserDefaultsValues.playingCharacter.node
        backgroundNode = BackgroundNode(at: scene.size, level: gameSceneManager.levelManager)
        scene.addChild(backgroundNode)
        gameSceneManager.updatable.append(backgroundNode)
        joistickNode =  Joistick(at: scene.size)
        upHitJoistick = UpHitJoistick(at: scene.size, with: playerNode.numberOfShoots.description)
        scene.camera?.position = CGPoint(x: 0, y: 0)
        scene.addChild(playerNode)
        gameSceneManager.playableChacarter = playerNode
        joistickNode.delegate = playerNode
        scene.addChild(joistickNode)
        upHitJoistick.delegate = playerNode
        scene.addChild(upHitJoistick)
        gameSceneManager.toucheble.append(joistickNode)
        gameSceneManager.updatable.append(joistickNode)
        gameSceneManager.toucheble.append(upHitJoistick)
        gameSceneManager.updatable.append(upHitJoistick)
        
        backButton.setUpPos(pos: CGPoint(x: (-scene.size.width/2+backButton.size.width/2 + 32), y: (scene.size.height/2-backButton.size.height-100)))
        hpNode = HealthPointNode(sceneSize: scene.size, healthPoints: playerNode.hp)
        hpNode.setUpXpos(x: backButton.position.x + backButton.size.width/2 + 16 + hpNode.size.width/2)
        gameSceneManager.hpDelegate = hpNode
        gameSceneManager.updatable.append(hpNode)
        startsCountNode = StarsNode(sceneSize: scene.size, star: 3)
        startsCountNode.setUpXpos(x: backButton.position.x + backButton.size.width/2 + 16 + startsCountNode.size.width/2)
        gameSceneManager.starsDelegate = startsCountNode
        gameSceneManager.updatable.append(startsCountNode)
        scene.addChild(startsCountNode)
       // let xPos = hpNode.position.x + hpNode.size.width/2 + cointsLabel.frame.width/2
        cointsLabel.setUpPosition(position: CGPoint(x: scene.size.width/2 - cointsLabel.size.width/2 - 32, y: hpNode.position.y))
        gameSceneManager.updatable.append(cointsLabel)
        gameSceneManager.cointsLabel = cointsLabel
        gameSceneManager.updatable.append(backButton)
        gameSceneManager.toucheble.append(backButton)
        scene.addChild(cointsLabel)
        scene.addChild(hpNode)
        scene.addChild(backButton)
    }

    
    override func willExit(to nextState: GKState) {
        if let nextState = nextState as? GameOverState {
            return
        }
        gameSceneManager?.toucheble.removeAll()
        gameSceneManager?.updatable.removeAll()
        gameSceneManager?.playableChacarter = nil
        gameSceneManager?.scene?.removeAllActions()
        gameSceneManager?.scene?.removeAllChildren()
        gameSceneManager?.scene?.camera?.position = CGPoint(x: 0, y: 0)
        gameSceneManager?.scene?.isPaused = false
        gameSceneManager?.cointsLabel = nil
    }

}

