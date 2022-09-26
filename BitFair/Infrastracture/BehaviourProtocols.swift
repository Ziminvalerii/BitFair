//
//  BehaviourProtocols.swift
//  BitFair
//
//  Created by Tanya Koldunova on 13.09.2022.
//

import SpriteKit
import GameplayKit

protocol Touchable : AnyObject {
    var shouldAcceptTouches: Bool { get set }
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?)
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?)
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?)
    func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?)
}

extension Touchable {
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?) {}
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?) {}
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?) {}
    func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?) {}
}

protocol Updatable : AnyObject {
    func update()
}
extension Updatable {
    func update() { }
}


protocol Endless: AnyObject {
    func start(scene:SKScene)
}

extension Endless {
    func start(scene:SKScene) { }
}

protocol Mortal {
    var hp: Int {get set}
}

protocol ButtonType: Touchable {
    func playSound(_ scene: SKScene)
    func containsTouches(touches: Set<UITouch>, scene: SKScene, nodeName:String) -> Bool
    func containsTouches(touches: Set<UITouch>, scene: SKScene, nodeNames:[String]) -> Bool
}

extension ButtonType {
    func playSound(_ scene: SKScene) {
        if !UserDefaultsValues.soundOff {
        let touchSound = SKAction.playSoundFileNamed("pressSound.wav", waitForCompletion: false)
        scene.run(touchSound)
        }
    }
    func containsTouches(touches: Set<UITouch>, scene: SKScene, nodeName:String) -> Bool {
        return touches.contains { touch in
            let touchPoint = touch.location(in: scene)
            let touchedNode = scene.atPoint(touchPoint)
            return touchedNode.name == nodeName
            //return touchedNode === leftArrowNode || touchedNode.inParentHierarchy(self)
        }
    }
    func containsTouches(touches: Set<UITouch>, scene: SKScene, nodeNames:[String]) -> Bool {
        return touches.contains { touch in
            let touchPoint = touch.location(in: scene)
            let touchedNode = scene.atPoint(touchPoint)
            if let name = touchedNode.name {
            return nodeNames.contains(name)
            } else {
                return false
            }
            //return touchedNode === leftArrowNode || touchedNode.inParentHierarchy(self)
        }
    }
}



protocol Dependable: AnyObject {
    func receiveMessage<T>(with arguments: T)
    func recieveMessage<T>(with argumets: T, completion: @escaping()->Void)
    func recieveMessage<T, V>(with argumets: T, type: V.Type, completion: @escaping(V)->Void) 
    func switchState(state: GameStates)
    
}

extension Dependable {
    func receiveMessage<T>(with arguments: T) {}
    func recieveMessage<T>(with argumets: T, completion: @escaping()->Void) {}
    func switchState(state: GameStates) {}
    func recieveMessage<T, V>(with argumets: T, type: V.Type, completion: @escaping(V)->Void) {}
}

