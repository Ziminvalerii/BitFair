//
//  ShopNode.swift
//  BitFair
//
//  Created by Tanya Koldunova on 21.09.2022.
//

import Foundation
import SpriteKit

class ShopNode:SKSpriteNode, FrameNodeProtocol {

    let iapManager = IAPManager()
    var products: [ProductSub]?
    
    var model: StoreModel.AllCases = StoreModel.allCases
    var currentIndex: Int = 0
    
    var shouldAcceptTouches: Bool = true {
        didSet {
            self.isUserInteractionEnabled = shouldAcceptTouches
        }
    }
    
    var delegate: Dependable {
        guard let delegate = scene as? Dependable else {
            fatalError("ButtonNode may only be used within a `ButtonNodeResponderType` scene.")
        }
        return delegate
    }
    
    var updateLabelDelegate: Dependable?
    
    //MARK: Nodes
    
    lazy var leftArrow: SKSpriteNode = {
        let leftArrow = SKSpriteNode(imageNamed: "shopLeftArrow")
        leftArrow.size = NodesSize.shopArrow.size
        leftArrow.zPosition = 20
        leftArrow.name = "shop left arrow"
        return leftArrow
    }()
    
    lazy var rigtArrow: SKSpriteNode = {
        let rightArrow = SKSpriteNode(imageNamed: "shopRightArrow")
        rightArrow.size = NodesSize.shopArrow.size
        rightArrow.zPosition = 20
        rightArrow.name = "shop right arrow"
        return rightArrow
    }()
    
    lazy var buyButton: SKSpriteNode = {
        let buyNode = SKSpriteNode(imageNamed: "buyButtonContainer")
        buyNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        buyNode.size = NodesSize.buyButtons.size
        buyNode.zPosition = 20
        buyNode.name = "buy"
        let text =  NSAttributedString(string: "Buy for \(StoreModel.simpleCharacter.buyForCoins)", attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 17)!, .foregroundColor: UIColor.white])
        
        let label = SKLabelNode(attributedText: text)
        label.position = CGPoint(x: 0, y:  -label.frame.size.height/2)
        label.zPosition = 21
        label.name = "buy for coins label"
        let img = SKSpriteNode(imageNamed: "coins")
        img.zPosition = 21
        img.size = CGSize(width: 20, height: 20)
        img.position = CGPoint(x: label.frame.size.width/2 - 28, y: 0)
        buyNode.addChild(label)
        buyNode.addChild(img)
        return buyNode
    }()
    lazy var watchAdButton: SKSpriteNode = {
        let watchAdNode = SKSpriteNode(imageNamed: "buyButtonContainer")
        watchAdNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        watchAdNode.size = NodesSize.buyButtons.size
        watchAdNode.zPosition = 20
        watchAdNode.name = "watch ad"
        let text =  NSAttributedString(string: "Watch ad", attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 17)!, .foregroundColor: UIColor.white])
        let label = SKLabelNode(attributedText: text)
        label.position = CGPoint(x: 0, y: -label.frame.size.height/2)
        label.zPosition = 21
        label.name = "watch ad label"
        watchAdNode.addChild(label)
        return watchAdNode
    }()
    lazy var buyForMoneyButton: SKSpriteNode = {
        let buyForMoneyNode = SKSpriteNode(imageNamed: "buyButtonContainer")
        buyForMoneyNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        buyForMoneyNode.size = NodesSize.buyButtons.size
        buyForMoneyNode.zPosition = 20
        buyForMoneyNode.name = "buy for money"
        let text =  NSAttributedString(string: "Buy for money", attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 17)!, .foregroundColor: UIColor.white])
        let label = SKLabelNode(attributedText: text)
        label.position = CGPoint(x: 0, y: -label.frame.size.height/2)
        label.zPosition = 21
        label.name = "buy for real money label"
        buyForMoneyNode.addChild(label)
        
        return buyForMoneyNode
    }()
    lazy var getCharacterButton: SKSpriteNode = {
        let getCharacterNode = SKSpriteNode(imageNamed: "buyButtonContainer")
        getCharacterNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        getCharacterNode.size = NodesSize.buyButtons.size
        getCharacterNode.zPosition = 20
        getCharacterNode.name = "get character"
        let text =  NSAttributedString(string: "Get character", attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 17)!, .foregroundColor: UIColor.white])
        let label = SKLabelNode(attributedText: text)
        label.position = CGPoint(x: 0, y: -label.frame.size.height/2)
        label.zPosition = 21
        label.name = "get character label"
        getCharacterNode.addChild(label)
        return getCharacterNode
    }()
    
    lazy var backButton: SKSpriteNode = {
        let backNode = SKSpriteNode(imageNamed: "buyButtonContainer")
        backNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backNode.size = NodesSize.playButton.size
        backNode.zPosition = 20
        backNode.name = "back"
        let text =  NSAttributedString(string: "back", attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 17)!, .foregroundColor: UIColor.white])
        let label = SKLabelNode(attributedText: text)
        label.position = CGPoint(x: 0, y: -label.frame.size.height/2)
        label.zPosition = 21
        label.name = "back label"
        backNode.addChild(label)
        return backNode
    }()
    
    lazy var character: SKSpriteNode = {
        let node = SKSpriteNode(texture: StoreModel.simpleCharacter.texture)
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node.size = NodesSize.mainCharacter.size
        node.zPosition = 20
        node.position = CGPoint(x: 0, y: self.size.height/2 - node.size.height/2 - 58)
        node.physicsBody = SKPhysicsBody(texture: node.texture!, size: node.size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.allowsRotation = false
        node.physicsBody?.affectedByGravity = false
        return node
    }()
    
    convenience init() {
        self.init(imageNamed: "shopTexture")
        self.size = NodesSize.shopNode.size
        self.zPosition = 19
        self.name = "shopNode"
        configureButtons(model: model[currentIndex])
        leftArrow.position = CGPoint(x: -self.size.width/2+leftArrow.size.width/2+200, y: character.position.y)
        rigtArrow.position = CGPoint(x: self.size.width/2-leftArrow.size.width/2-200, y: character.position.y)
        backButton.position = CGPoint(x: 0, y: -self.size.height/2+backButton.size.height/2+64)
        self.addChild(character)
        self.addChild(leftArrow)
        self.addChild(rigtArrow)
        self.addChild(backButton)
        self.requestProduct()
    }
    
    func configureButtons(model: StoreModel) {
        character.texture = model.texture
        character.size = model.size
        if UserDefaultsValues.availableCharacters.contains(model) {
            buyButton.removeFromParent()
            watchAdButton.removeFromParent()
            buyForMoneyButton.removeFromParent()
            getCharacterButton.position = CGPoint(x: 0, y: character.position.y - character.size.height/2 - 40)
            setTextForAvailableCharacters(current: (model == UserDefaultsValues.playingCharacter))
            if getCharacterButton.parent == nil {
                self.addChild(getCharacterButton)
            }
        } else {
            getCharacterButton.removeFromParent()
            showBuyButton(model)
            showWatchAdButton(model)
            showBuyForMoneyButton(model)
        }
    }
    
    func getBuyProduct(model: StoreModel) {
        if let node = model.node {
            var availableCharacters = UserDefaultsValues.availableCharacters
            availableCharacters.append(model)
            UserDefaultsValues.availableCharacters = availableCharacters
            configureButtons(model: model)
        } else {
            UserDefaultsValues.cointsCount += model.value
            updateLabelDelegate?.receiveMessage(with: "update label")
        }
    }
    
}

extension ShopNode: ButtonType {
    
    
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, in scene: SKScene?) {
        guard let scene = scene else {return}
        if containsTouches(touches: touches, scene: scene, nodeNames: ["buy", "buy for coins label"]) {
            if model[currentIndex].buyForCoins ?? 0.0 > Float(UserDefaultsValues.cointsCount) {
                delegate.switchState(state: .noEnoughCoins)
            } else {
                UserDefaultsValues.cointsCount -= model[currentIndex].buyForCoins!
                updateLabelDelegate?.receiveMessage(with: "update label")
                getBuyProduct(model: model[currentIndex])
            }
            playSound(scene)
            
        } else if containsTouches(touches: touches, scene: scene, nodeNames: ["watch ad", "watch ad label"]) {
            if let scene = scene as? GameScene {
                stopPlaying()
            self.delegate.recieveMessage(with: "Watch add") {
                self.getBuyProduct(model: self.model[self.currentIndex])
            }
            playSound(scene)
            }
        } else if containsTouches(touches: touches, scene: scene, nodeNames: ["buy for money", "buy for real money label"]) {
            buyProduct(model: model[currentIndex])
            playSound(scene)
        } else if containsTouches(touches: touches, scene: scene, nodeName: "shop left arrow") {
            currentIndex -= 1
            if currentIndex < 0 {
                currentIndex = model.count-1
            }
            configureButtons(model: model[currentIndex])
            playSound(scene)
        } else if containsTouches(touches: touches, scene: scene, nodeName: "shop right arrow") {
            currentIndex += 1
            if currentIndex > model.count - 1 {
                currentIndex = 0
            }
            configureButtons(model: model[currentIndex])
            playSound(scene)
        } else if containsTouches(touches: touches, scene: scene, nodeNames: ["get character", "get character label"]) {
            UserDefaultsValues.playingCharacter = model[currentIndex]
            configureButtons(model: model[currentIndex])
            playSound(scene)
            
        } else if containsTouches(touches: touches, scene: scene, nodeNames: ["back", "back label"]) {
            playSound(scene)
            self.delegate.switchState(state: .start)
        }
    }
}
