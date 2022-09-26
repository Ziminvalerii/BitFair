//
//  RescurentState.swift
//  BitFair
//
//  Created by Tanya Koldunova on 20.09.2022.
//

import GameplayKit

class RescurentState: GKState {
    weak var gameSceneManager: GameSceneManager?
    
    init(gameSceneManager: GameSceneManager) {
        self.gameSceneManager = gameSceneManager
    }
    
    override func didEnter(from previousState: GKState?) {
        guard let scene = gameSceneManager?.scene as? GameScene else {return}
        //scene.parentViewController?.showRewardedAd()
    }
    
    override func willExit(to nextState: GKState) {
        if let nextState = nextState as? PlayingState {
            guard let scene = gameSceneManager?.scene else {return}
            scene.isPaused = false
            let backgroundOverlay = scene.childNode(withName: "game over overlay")
            backgroundOverlay?.removeFromParent()
            gameSceneManager?.toucheble.removeAll(where: { node in
                if let node = node as? SKNode {
                    return node.name == "go to start" || node.name?.starts(with: "rescurent node") ?? false || node.name == "replay" || node.name == "shop"
                } else {
                    return false
                }
            })
        } else {
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
    
    
}
