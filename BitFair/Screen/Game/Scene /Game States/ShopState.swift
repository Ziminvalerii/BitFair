//
//  ShopState.swift
//  BitFair
//
//  Created by Tanya Koldunova on 21.09.2022.
//

import GameplayKit
import SpriteKit

class ShopState: GKState {
    weak var gameSceneManager: GameSceneManager?
    var shopOverlay: ShopOverlay!
    
    init(gameSceneManager: GameSceneManager) {
        self.gameSceneManager = gameSceneManager
        guard let scene = gameSceneManager.scene else {return}
        shopOverlay = ShopOverlay(with: scene.size)
    }
    
    override func didEnter(from previousState: GKState?) {
        guard let scene = gameSceneManager?.scene else {return}
        scene.addChild(shopOverlay)
        shopOverlay.apear()
        gameSceneManager?.toucheble.append(shopOverlay)
        gameSceneManager?.toucheble.append(shopOverlay.frameNode)
    }
    
    override func willExit(to nextState: GKState) {
        shopOverlay.dissapear()
        gameSceneManager?.toucheble.removeAll(where: { node in
            if let node = node as? SKNode {
                return node.name == "shopNode"
            } else {
                return false
            }
        })
    }
    
}
