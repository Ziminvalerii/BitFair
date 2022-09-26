//
//  BaseSceneManager.swift
//  BitFair
//
//  Created by Tanya Koldunova on 13.09.2022.
//

import SpriteKit


protocol GameSceneManagerProtocol  {
    var scene: SKScene? { get }
    var contactManager: ContactManager? {get}
    var toucheble: [Touchable] { get }
    var updatable: [Updatable] { get }
    var endless: [Endless] {get}
    func preparePhysicsForWold(for scene: SKScene)
}

enum PhysicsCategory {
   
}

protocol ContactManager : AnyObject {
    func handleContact()
    func handleGameResult()
}

extension ContactManager {
    func handleContact(){}
    func handleGameResult(){}
}
