//
//  GameOverState.swift
//  BitFair
//
//  Created by Tanya Koldunova on 13.09.2022.
//

import GameplayKit

class GameOverState: GKState {
    weak var gameSceneManager: GameSceneManager?
    var gameOverOverlay: GameOverOverlay!
    
    init(gameSceneManager: GameSceneManager) {
        self.gameSceneManager = gameSceneManager
        guard let scene = gameSceneManager.scene else {return}
    }
    
    override func didEnter(from previousState: GKState?) {
        guard let scene = gameSceneManager?.scene else {return}
        guard let camera = scene.camera else {return}
        gameOverOverlay = GameOverOverlay(with: scene.size, level: gameSceneManager!.levelManager)
        scene.isPaused = true
        gameOverOverlay.position = camera.position
        scene.addChild(gameOverOverlay)
        gameSceneManager?.updatable.append(gameOverOverlay)
        gameSceneManager?.toucheble.append(contentsOf: gameOverOverlay.gameOverNode.allTouchableButtons())
    }
    
    override func willExit(to nextState: GKState) {
        if let nextState = nextState as? RescurentState {
            return
        } else {
            gameSceneManager?.toucheble.removeAll()
            gameSceneManager?.updatable.removeAll()
            gameSceneManager?.playableChacarter = nil
            gameSceneManager?.scene?.removeAllActions()
            gameSceneManager?.scene?.removeAllChildren()
            gameSceneManager?.scene?.camera?.position = CGPoint(x: 0, y: 0)
            gameSceneManager?.scene?.isPaused = false
            gameSceneManager?.cointsLabel = nil
            gameSceneManager?.cointsCount = 0
        }
    }
    
    
}
