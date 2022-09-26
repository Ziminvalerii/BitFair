//
//  MapOverlay+Touches.swift
//  BitFair
//
//  Created by Tanya Koldunova on 26.09.2022.
//

import SpriteKit

extension MapOverlay: ButtonType {
    
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?) {
        guard let scene = scene else {return}
        if containsTouches(touches: touches, scene: scene, nodeName: "level ground node 1") {
            selectedLevel = levels[0].level
            setText("Level \(String(describing: levels[0].levelName!))")
            changePos(level: levels[0], to: 0)
            changePos(level: levels[1], to: 1)
            changePos(level: levels[2], to: 2)
        } else if containsTouches(touches: touches, scene: scene, nodeName: "level ground node 2") {
            selectedLevel = levels[1].level
            setText("Level \(String(describing: levels[1].levelName!))")
            changePos(level: levels[1], to: 0)
            changePos(level: levels[2], to: 1)
            changePos(level: levels[0], to: 2)
        } else if containsTouches(touches: touches, scene: scene, nodeName: "level ground node 3") {
            selectedLevel = levels[2].level
            setText("Level \(String(describing: levels[2].levelName!))")
            changePos(level: levels[2], to: 0)
            changePos(level: levels[0], to: 1)
            changePos(level: levels[1], to: 2)
        } else if containsTouches(touches: touches, scene: scene, nodeName: "play button node") {
            if playLevel.texture == playButtonTexture {
                levelManager.currentLevel = selectedLevel
                gameSceneDelegate?.receiveMessage(with: levelManager)
                delegate.switchState(state: .playing)
            }
        } else if containsTouches(touches: touches, scene: scene, nodeName: "back button node") {
            delegate.switchState(state: .start)
        }
        playSound(scene)
    }
    
}
