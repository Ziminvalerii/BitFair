//
//  StarsNode.swift
//  BitFair
//
//  Created by Tanya Koldunova on 22.09.2022.
//

import Foundation
import SpriteKit

class StarsNode:SKSpriteNode {
    lazy var activeTexture: SKTexture = SKTexture(imageNamed: "stars")
    lazy var unactiveTexture: SKTexture = SKTexture(imageNamed: "unactiveStarImage")
    var stars: [StarNode] = [StarNode]()
    var starCount: Int = 0 {
        didSet {
            for i in 0..<starCount {
                stars[i].texture = unactiveTexture
            }
        }
    }
    var gettedStars: Int = 0 {
        didSet {
            for i in 0..<gettedStars {
                stars[i].texture = activeTexture
            }
        }
    }
    var delegate: Dependable {
        guard let delegate = scene as? Dependable else {
            fatalError("ButtonNode may only be used within a `ButtonNodeResponderType` scene.")
        }
        return delegate
    }
    
    convenience init(sceneSize: CGSize, star: Int) {
        self.init(color: .clear, size: CGSize(width: NodesSize.coint.size.width * 3 + 10, height: NodesSize.coint.size.height))
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5 )
        self.zPosition = 10
        self.starCount = star
        for i in 0..<star {
            let star = StarNode()
            let xPos = (self.size.width/2 - star.size.width/2)
            star.position = CGPoint(x: xPos*CGFloat(-1+i), y: 0)
            star.texture = unactiveTexture
            stars.append(star)
            self.addChild(star)
        }
        self.position = CGPoint(x: -(sceneSize.width/2-self.size.width/2 - 32 - NodesSize.heart.size.width), y: (sceneSize.height/2-self.size.height-150))
        self.name = "stars count"
    }
}

extension StarsNode: Dependable {
    func receiveMessage<T>(with arguments: T) {
        if let argument = arguments as? Int {
            gettedStars += argument
        }
       
        
    }
}

extension StarsNode: Updatable {
    func update() {
        guard let camera = scene?.camera else {return}
        self.position.x = camera.position.x - (scene!.size.width/2-self.size.width/2 - 32)
    }
}
