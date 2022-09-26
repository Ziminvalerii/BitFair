//
//  MapState.swift
//  BitFair
//
//  Created by Tanya Koldunova on 22.09.2022.
//

import GameplayKit

class MapState: GKState {
    weak var gameSceneManager: GameSceneManager?
    private var mapOverlay: MapOverlay!
    
    init(gameSceneManager: GameSceneManager) {
        self.gameSceneManager = gameSceneManager
        guard let scene = gameSceneManager.scene else {return}
        mapOverlay = MapOverlay(at: scene.size, levelManager: gameSceneManager.levelManager)
        
    }
    override func didEnter(from previousState: GKState?) {
        guard let gameSceneManager = gameSceneManager else {return}
        guard let scene = gameSceneManager.scene else {return}
        guard let camera = scene.camera else {return}
        if previousState is GameOverState || previousState is WinState {
            mapOverlay.levelManager = gameSceneManager.levelManager
        }
        mapOverlay.alpha = 1.0
        mapOverlay.gameSceneDelegate = gameSceneManager
        mapOverlay.position = camera.position
        gameSceneManager.toucheble.append(mapOverlay)
   //     mapOverlay.apear()
        scene.addChild(mapOverlay)
       
    }
    
    override func willExit(to nextState: GKState) {
        mapOverlay.dissapear()
    }

}
