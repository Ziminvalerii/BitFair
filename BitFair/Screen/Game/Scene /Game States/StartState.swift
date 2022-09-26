//
//  StartState.swift
//  BitFair
//
//  Created by Tanya Koldunova on 13.09.2022.
//

import GameplayKit

class StartState: GKState {
    weak var gameSceneManager: GameSceneManager?
    private lazy var playingCharacter: BasicCharacter = BasicCharacter()
    private var backgroundNode: BackgroundNode!
    private var startOverlay: StartNode!
    
    init(gameSceneManager: GameSceneManager) {
        self.gameSceneManager = gameSceneManager
        guard let scene = gameSceneManager.scene else {return}
        startOverlay = StartNode(with: scene.size)
    }
    override func didEnter(from previousState: GKState?) {
        guard let scene = gameSceneManager?.scene else {return}
        guard let camera = scene.camera else {return}
        startOverlay.position = camera.position
        scene.addChild(startOverlay)
        gameSceneManager?.toucheble.append(startOverlay.settingsButton)
        gameSceneManager?.toucheble.append(startOverlay.shopButton)
        gameSceneManager?.toucheble.append(startOverlay.startButton)
        gameSceneManager?.toucheble.append(startOverlay.instructionButton)
    }
    
    override func willExit(to nextState: GKState) {
        startOverlay.removeFromParent()
        gameSceneManager?.toucheble.removeAll()
     
    }

}

