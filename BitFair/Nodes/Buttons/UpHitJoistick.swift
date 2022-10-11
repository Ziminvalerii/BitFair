//
//  UpHitJoistick.swift
//  BitFair
//
//  Created by Tanya Koldunova on 14.09.2022.
//

import SpriteKit


class UpHitJoistick: SKSpriteNode {
    var shouldAcceptTouches: Bool = true 
    
    lazy var hitNode: SKSpriteNode = {
        let hit = SKSpriteNode(imageNamed: "hitButtonTexture")
        hit.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        hit.position = CGPoint(x: 0, y: -self.size.height/2 + hit.size.height/2)
        hit.zPosition = 10
        hit.size = CGSize(width: 68, height: 61)
        hit.name = "hit"
        let text =  NSAttributedString(string: "Hit count", attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 24)!, .foregroundColor: UIColor.black])
        let label = SKLabelNode(attributedText: text)
        label.zPosition = 25
        label.position = CGPoint(x: 0, y: -label.frame.height/2)
        label.name = "hit label"
        hit.addChild(label)
        return hit
    }()
    
    lazy var upNode: SKSpriteNode = {
        let up = SKSpriteNode(imageNamed: "arrowTop")
        up.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        up.position = CGPoint(x: 0, y: self.size.height/2 - up.size.height/2)
        up.zPosition = 10
        up.size = CGSize(width: 70, height: 85)
        up.name = "up"
        return up
    }()
    
    private var isJumping: Bool = false
    private var isDoubleJumping: Bool = false
    
    
    private var tapCount: Int = 0
    
    var delegate: Dependable?
    
    convenience init(at sceneSize: CGSize, with text: String) {
        self.init(color: .clear, size: CGSize(width: 100, height: 185))
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = 10
        self.addChild(hitNode)
        self.addChild(upNode)
        setUpLabel(text: text)
        self.position = CGPoint(x: (sceneSize.width/2-self.size.width/2 - 32), y: -(sceneSize.height/2-self.size.height))
        
        self.name = "up hit joistick"
    }
    
    func setUpLabel(text:String) {
        let text =  NSAttributedString(string: text, attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 24)!, .foregroundColor: UIColor.black])
        if let label = hitNode.childNode(withName: "hit label") as? SKLabelNode {
            label.attributedText = text
        }
    }
    
}

extension UpHitJoistick: ButtonType {
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?) {
        if shouldAcceptTouches {
            guard let scene = scene else {return}
            guard let delegate = delegate else {return}
            if containsTouches(touches: touches, scene: scene, nodeName: "hit") {
//                self.delegate?.receiveMessage(with: "weapon")
//                self.delegate?.recieveMessage(with: "weapon", completion: {
//
//                })
//
                self.delegate?.recieveMessage(with: "weapon", type: Int.self, completion: { arg in
                        self.setUpLabel(text: arg.description)
                })
                playSound(scene)
            } else if containsTouches(touches: touches, scene: scene, nodeName: "up") {
                if isDoubleJumping {
                    return
                }
                if isJumping {
                    isDoubleJumping = true
                    isJumping = false
                    self.delegate?.recieveMessage(with: 2, completion: {
                        print("end double jump")
                        self.isDoubleJumping = false
                    })
                }
                else {
                    isJumping = true
                    self.delegate?.recieveMessage(with: 1, completion: {
                        self.isJumping = false
                    })
                }
                playSound(scene)
            }
           
        }
    }
    
}

extension UpHitJoistick: Updatable {
    func update() {
        guard let scene = self.scene else {return}
        guard let camera = scene.camera else {return}
        self.position.x = camera.position.x + (scene.size.width/2-self.size.width/2 - 32)
    }
}
