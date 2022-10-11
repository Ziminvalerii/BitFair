//
//  WinState.swift
//  BitFair
//
//  Created by Tanya Koldunova on 22.09.2022.
//

import GameplayKit

class WinState: GKState {
    weak var gameSceneManager: GameSceneManager?
    var winOverlay: WinOverlay!
    
    init(gameSceneManager: GameSceneManager) {
        self.gameSceneManager = gameSceneManager
        guard let scene = gameSceneManager.scene else {return}
        winOverlay = WinOverlay(at: scene.size)
    }
    
    override func didEnter(from previousState: GKState?) {
        guard let gameSceneManager = gameSceneManager else {return}
        guard let scene = gameSceneManager.scene else {return}
        guard let camera = scene.camera else {return}
        winOverlay.position = camera.position
        winOverlay.apear()
        scene.addChild(winOverlay)
        gameSceneManager.toucheble.append(winOverlay)
        gameSceneManager.levelManager.setLevelInfo(stars: gameSceneManager.starsCount)
        UserDefaultsValues.cointsCount += Float(gameSceneManager.cointsCount)
    }
    
    override func willExit(to nextState: GKState) {
        guard let scene = gameSceneManager?.scene else {return}
        if scene.isPaused {
            scene.isPaused = false
        }
        gameSceneManager?.toucheble.removeAll()
        gameSceneManager?.updatable.removeAll()
        gameSceneManager?.playableChacarter = nil
        gameSceneManager?.scene?.removeAllActions()
        gameSceneManager?.scene?.removeAllChildren()
        gameSceneManager?.scene?.camera?.position = CGPoint(x: 0, y: 0)
        gameSceneManager?.cointsLabel = nil
        gameSceneManager?.cointsCount = 0
        gameSceneManager?.starsCount = 0
        winOverlay.removeFromParent()
    }
    
}
