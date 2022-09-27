//
//  CharacterProtocol.swift
//  BitFair
//
//  Created by Tanya Koldunova on 21.09.2022.
//
import UIKit
import SpriteKit

protocol CharacterProtocol: SKSpriteNode, Dependable, Mortal {
    var hp: Int {get set}
    var mySpeed: CGFloat {get set}
    var jump: CGFloat {get set}
    var numberOfShoots: Int {get set}
    var walkTextures: [SKTexture] {get set}
    func setUpPhysics()
    func setUpHit()
    func hitAction()
    func createWeaponeNode()->HeroWeaponProtocol
    func moveAutomatic(groundNode: SKNode, contactPoint: CGPoint) 
    
    var shootCount: Int {get set}
}

extension CharacterProtocol {
    
    func setUpPhysics() {
        //self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = PhysicsBitMask.player.bitMask
        self.physicsBody?.collisionBitMask = PhysicsBitMask.ground.bitMask | PhysicsBitMask.enemy.bitMask | PhysicsBitMask.bonusGround.bitMask
        self.physicsBody?.contactTestBitMask = PhysicsBitMask.coint.bitMask | PhysicsBitMask.enemy.bitMask | PhysicsBitMask.enemyWeapon.bitMask | PhysicsBitMask.ground.bitMask | PhysicsBitMask.starts.bitMask | PhysicsBitMask.bonusGround.bitMask
    }
    
    func moveAutomatic(groundNode: SKNode, contactPoint: CGPoint) {
        let customActionBlock: (SKNode, CGFloat)->Void = { (node, elapsedTime) in
            guard let scene = self.scene else {return}
            let nodeX = groundNode.position.x - scene.size.width/2
            let dx = nodeX - node.position.x
        }
        
        let duration = TimeInterval(Int.max) //want the action to run infinitely
        let followPlayer = SKAction.customAction(withDuration:duration,actionBlock:customActionBlock)
        self.run(followPlayer ,withKey:"follow ground")
        
    }
    
    func setUpHit() {
        self.run(SKAction.moveTo(x: self.position.x - 50, duration: 0.2), withKey: "hit player")
        if let cameraNode = self.scene?.camera {
            if self.position.x > 0 {
                cameraNode.position.x = self.position.x
            }
        }
    }
    
    func hitAction() {
        guard let scene = scene else {return}
        let weapon = createWeaponeNode()
        scene.addChild(weapon)
        weapon.position = CGPoint(x: self.position.x + self.size.width/2, y: self.position.y)
        if numberOfShoots > shootCount {
            weapon.applyAction(scene: scene, heroPos: self.position)
            shootCount += 1
        }
    }
    
    func animateHero() {
        self.run(SKAction.repeatForever(
            SKAction.animate(with: walkTextures,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)),
                 withKey:"walking")
    }
    
    func animateEnded() {
        self.removeAction(forKey: "walking")
    }
    
    
    func receiveMessage<T>(with arguments: T) {
        if let arguments = arguments as? ButtonState {
            self.position.x += mySpeed*CGFloat(arguments.rawValue)//speed
            
        }  else if let arguments = arguments as? String {
            if arguments == "animate" {
                animateHero()
            } else if arguments == "stop animating" {
                animateEnded()
            }
            if let cameraNode = self.scene?.camera {
                if let backgroundNode = scene?.childNode(withName: "background") as? BackgroundNode {
                    if self.parent == self.scene {
                        if self.position.x > 0 && backgroundNode.currentCusrsor < scene!.size.width * CGFloat(backgroundNode.backGroundCount) {
                            cameraNode.position.x = self.position.x
                        }
                        print("Hero position: \(self.position)")
                        print("Ground position: \(self.parent!.position)")
                    } else {
                        if self.parent?.name == "tip ground node" {
                            cameraNode.position.x = self.parent!.position.x - scene!.size.width/2 + self.position.x
//                            if self.position.y > self.parent!.frame.size.height/2 + self.size.height/2 {
//                                self.move(toParent: scene!)
//                            }
                            
                        }
                    }
                   
                }
            }
        }
    }
    
    func recieveMessage<T>(with argumets: T, completion: @escaping () -> Void) {
        if let arguments = argumets as? Int {
            //   self.physicsBody?.pinned = false
            var jumpAction = SKAction.applyImpulse(CGVector(dx: 0, dy: jump), duration: 0.1)
            self.run(SKAction.sequence([jumpAction, SKAction.wait(forDuration: 0.5*Double(arguments)), SKAction.run({
                completion()
            })]))
        }
    }
    
    func recieveMessage<T, V>(with argumets: T, type: V.Type, completion: @escaping (V) -> Void) {
        if let argument = argumets as? String {
            if argument == "weapon" {
                if numberOfShoots > shootCount {
                    let weapon = createWeaponeNode()
                    weapon.position = CGPoint(x: self.position.x+4, y: self.position.y)
                    guard let scene = scene else {return}
                    scene.addChild(weapon)
                    weapon.applyAction(scene: scene, heroPos: self.position)
                    shootCount += 1
                   // if let shooCount = shootCount as? V.Type {
                    completion((numberOfShoots - shootCount) as! V)
                    //}
                }
            }
        }
    }
}
