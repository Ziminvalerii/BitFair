//
//  InstructionState.swift
//  BitFair
//
//  Created by Tanya Koldunova on 22.09.2022.
//

import GameplayKit

class InstructionState: GKState {
    weak var gameSceneManager: GameSceneManager?
    var instructionOverlay: InstructionOberlay!
    
    init(gameSceneManager: GameSceneManager) {
        self.gameSceneManager = gameSceneManager
        guard let scene = gameSceneManager.scene else {return}
        instructionOverlay = InstructionOberlay(with: scene.size)
    }
    
    override func didEnter(from previousState: GKState?) {
        guard let scene = gameSceneManager?.scene else {return}
        scene.addChild(instructionOverlay)
        instructionOverlay.apear()
        
        gameSceneManager?.toucheble.append(instructionOverlay.frameNode)
    }
    
    override func willExit(to nextState: GKState) {
        instructionOverlay.dissapear()
        gameSceneManager?.toucheble.removeAll(where: { node in
            if let node = node as? SKNode {
                return node.name == "instructionNode"
            } else {
                return false
            }
        })
    }
    
}
