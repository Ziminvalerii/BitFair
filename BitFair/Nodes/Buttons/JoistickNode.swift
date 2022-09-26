//
//  JoistickNode.swift
//  BitFair
//
//  Created by Tanya Koldunova on 14.09.2022.
//

import SpriteKit

enum ButtonState: Int {
    case right = 1
    case left = -1
}

class Joistick: SKSpriteNode {
    var shouldAcceptTouches: Bool = true {
        didSet {
            self.isUserInteractionEnabled = shouldAcceptTouches
        }
    }
    
    lazy var leftArrowNode: SKSpriteNode = {
        let leftArrow = SKSpriteNode(imageNamed: "arrowLeft")
        leftArrow.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        leftArrow.position = CGPoint(x: -self.size.width/2+leftArrow.size.width/2, y: 0)
        leftArrow.zPosition = 10
        leftArrow.size = CGSize(width: 85, height: 70)
        leftArrow.name = "left"
        return leftArrow
    }()
    
    lazy var rightArrowNode: SKSpriteNode = {
        let rightNode = SKSpriteNode(imageNamed: "arrowRight")
        rightNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        rightNode.position = CGPoint(x:  self.size.width/2-rightNode.size.width/2 , y: 0)
        rightNode.zPosition = 10
        rightNode.size = CGSize(width: 85, height: 70)
        rightNode.name = "right"
        return rightNode
    }()
    
    var delegate: Dependable?
    private var rightArrowTapped = false
    private var leftArrowTapped = false
    
    convenience init(at sceneSize: CGSize) {
        self.init(color: .clear, size: CGSize(width: 250, height: 140))
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = 10
        self.addChild(leftArrowNode)
        self.addChild(rightArrowNode)
        self.position = CGPoint(x: -(sceneSize.width/2-self.size.width/2 - 32), y: -(sceneSize.height/2-self.size.height-32))
        self.name = "joistick"
    }
    
}

extension Joistick: ButtonType {
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?) {
        if shouldAcceptTouches {
            guard let scene = scene else {return}
            guard let delegate = delegate else {return}
            if containsTouches(touches: touches, scene: scene, nodeName: "left") {
                self.delegate?.receiveMessage(with: "animate")
                leftArrowTapped = true
                rightArrowTapped = false
            } else if containsTouches(touches: touches, scene: scene, nodeName: "right") {
                self.delegate?.receiveMessage(with: "animate")
                rightArrowTapped = true
                leftArrowTapped = false
            }
            playSound(scene)
        }
    }

    
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?) {
        if shouldAcceptTouches {
            guard let scene = scene else {return}
            guard let delegate = delegate else {return}
            if containsTouches(touches: touches, scene: scene, nodeName: "left") {
                self.delegate?.receiveMessage(with: "stop animating")
                leftArrowTapped = false
                rightArrowTapped = false
            } else if containsTouches(touches: touches, scene: scene, nodeName: "right") {
                self.delegate?.receiveMessage(with: "stop animating")
                rightArrowTapped = false
                leftArrowTapped = false
            }
            playSound(scene)
        }
       
    }
    
    func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?) {
        if shouldAcceptTouches {
            guard let scene = scene else {return}
            guard let delegate = delegate else {return}
            if containsTouches(touches: touches, scene: scene, nodeName: "left") {
                leftArrowTapped = false
                rightArrowTapped = false
            } else if containsTouches(touches: touches, scene: scene, nodeName: "right") {
                rightArrowTapped = false
                leftArrowTapped = false
            }
            playSound(scene)
        }
    }

    
    
    func setTouches(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?) {
        guard let scene = scene else {return}
        guard let delegate = delegate else {return}
        if containsTouches(touches: touches, scene: scene, nodeName: "left") {
            leftArrowTapped = !leftArrowTapped
        } else if containsTouches(touches: touches, scene: scene, nodeName: "right") {
            rightArrowTapped = !rightArrowTapped
        }
    }
    
    
    
    
}

extension Joistick: Updatable {
    func update() {
        guard let camera = scene?.camera else {return}
        self.position.x = camera.position.x - (scene!.size.width/2 - self.size.width/2 - 32)
        if leftArrowTapped {
            delegate?.receiveMessage(with: ButtonState.left)
        }
        if rightArrowTapped {
            delegate?.receiveMessage(with: ButtonState.right)
        }
        delegate?.receiveMessage(with: "update key")
    }
}

