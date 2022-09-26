//
//  GameScene.swift
//  BitFair
//
//  Created by Tanya Koldunova on 13.09.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var gameManager: GameSceneManager!
    weak var parentViewController: GameViewController?
    lazy var stateMachine: GKStateMachine = GKStateMachine(states: [
        StartState(gameSceneManager: gameManager!),
        MapState(gameSceneManager: gameManager!),
        ShopState(gameSceneManager: gameManager!),
        InstructionState(gameSceneManager: gameManager!),
        PlayingState(gameSceneManager: gameManager!),
        GameOverState(gameSceneManager: gameManager!),
        WinState(gameSceneManager: gameManager!),
        RescurentState(gameSceneManager: gameManager!)
        ])
   
    
    override func sceneDidLoad() {
        gameManager = GameSceneManager(scene: self)
        gameManager.contactManager = self
        self.camera = gameManager.cameraNode
        self.stateMachine.enter(StartState.self)
       
        
    }
    
    override func didMove(to view: SKView) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.gameManager.toucheble.forEach { node in
            node.touchesBegan(touches, with: event, in: self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.gameManager.toucheble.forEach { node in
            node.touchesMoved(touches, with: event, in: scene)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.gameManager.toucheble.forEach { node in
            node.touchesEnded(touches, with: event, in: scene)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.gameManager.toucheble.forEach { node in
            node.touchesCancelled(touches, with: event, in: scene)
        }
    }
    override func update(_ currentTime: TimeInterval) {
        
        self.gameManager.updatable.forEach { node in
            node.update()
        }
    }
}

extension GameScene: Dependable {
    
    func switchState(state: GameStates) {
        if state == GameStates.playing {
            self.stateMachine.enter(PlayingState.self)
        } else if state == GameStates.gameOver {
            self.stateMachine.enter(GameOverState.self)
        } else if state == GameStates.win {
            self.stateMachine.enter(WinState.self)
        } else if state == GameStates.start {
            self.stateMachine.enter(StartState.self)
        } else if state == GameStates.goToSettings {
            var showRestarButton = false
            self.scene?.isPaused = true
            if let currentState = stateMachine.currentState {
                showRestarButton = ((currentState as? PlayingState) != nil)
            }
            parentViewController?.showSettingsView(showRestartButton: showRestarButton)
        } else if state == GameStates.goToShop {
            self.stateMachine.enter(ShopState.self)
        } else if state == GameStates.watchAd {
            self.stateMachine.enter(RescurentState.self)
            parentViewController?.showRewardedAd(completion: {
                self.gameManager.configureBackgroundAudio()
                self.stateMachine.enter(PlayingState.self)
            })
        } else if state == GameStates.rescurentWithCoints {
            self.stateMachine.enter(RescurentState.self)
            self.gameManager.cointsCount -= 100
        } else if state == GameStates.goToInstruction {
            self.stateMachine.enter(InstructionState.self)
        } else if state == GameStates.goToMap {
            self.stateMachine.enter(MapState.self)
        }
        
    }
    
    func recieveMessage<T>(with argumets: T, completion: @escaping () -> Void) {
        if let argumets = argumets as? String {
            if argumets == "Watch add" {
                parentViewController?.showRewardedAd {
                    self.gameManager.configureBackgroundAudio()
                    completion()
                }
            }
        }
    }
    
}

extension GameScene: ContactManager {
    func handleGameResult() {
        self.stateMachine.enter(WinState.self)
    }
}
