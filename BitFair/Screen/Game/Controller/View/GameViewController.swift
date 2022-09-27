//
//  GameViewController.swift
//  BitFair
//
//  Created by Tanya Koldunova on 13.09.2022.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: BaseViewController<GamePresenterProtocol>, GameViewProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                if let scene = scene as? GameScene {
                    scene.parentViewController = self
                }
                // Present the scene
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
        }
    }

   
    
    func showSettingsView(showRestartButton:Bool) {
        let view = presenter.showSettingsView(showRestartButton: showRestartButton)
        self.view.addSubview(view)
    }
    
    func shopButtonPressed() {
        if let view = self.view as? SKView {
            if let scene = view.scene as? GameScene {
                scene.switchState(state: .goToMap)
            }
        }
    }
    
    func restartButtonPressed() {
        if let view = self.view as? SKView {
            if let scene = view.scene as? GameScene {
                scene.switchState(state: .playing)
            }
        }
    }
    
    func cancelButtonPressed() {
        if let view = self.view as? SKView {
            if let scene = view.scene as? GameScene {
                if scene.isPaused == true {
                    scene.isPaused = false
                }
            }
        }
    }
    
    func setChilds(childs: [UIView]) {
        childs.forEach { child in
            self.view.addSubview(child)
        }
       
    }
    
    func showRewardedAd(completion: @escaping()->Void) {
        presenter.adManager.showRewardedAds(at: self) { reward in
            if reward != nil {
                completion()
            }
        }
    }
    
   
    
}
