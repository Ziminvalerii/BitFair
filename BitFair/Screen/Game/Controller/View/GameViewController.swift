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
    @IBOutlet weak var settingsView: UIView! {
        didSet {
            settingsView.layer.borderWidth = 10.0
            settingsView.layer.borderColor = UIColor.black.cgColor
        }
    }
    @IBOutlet weak var settingsLabel: UILabel! {
        didSet {
            settingsLabel.font = UIFont(name: "Pixel Cyr", size: 30)
        }
    }
    @IBOutlet weak var brightnessLabel: UILabel! {
        didSet {
            brightnessLabel.font = UIFont(name: "Pixel Cyr", size: 24)
        }
    }
    @IBOutlet weak var backLabel: UILabel! {
        didSet {
            backLabel.font = UIFont(name: "Pixel Cyr", size: 35)
        }
    }
    @IBOutlet weak var settingsCollectionView: UICollectionView! {
        didSet {
            settingsCollectionView.delegate = presenter
            settingsCollectionView.dataSource = presenter
        }
    }
    @IBOutlet weak var brightnessSlider: UISlider! {
        didSet {
            brightnessSlider.value =  UserDefaultsValues.brightness
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.isHidden = true
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "GameScene") {
                scene.scaleMode = .aspectFill
                if let scene = scene as? GameScene {
                    scene.parentViewController = self
                }
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            self.navigationController?.navigationBar.isHidden = true
        }
        
        for font in UIFont.familyNames {
            print(font)
        }
    }

    func showAlert() {
        let alertController = UIAlertController(title: "Not enough coins", message: "You don`t have enough coins", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Got it", style: UIAlertAction.Style.cancel)
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showWatchErrorAlert() {
        let alertController = UIAlertController(title: "Failed to watch add", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Got it", style: UIAlertAction.Style.cancel)
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showSettingsView() {
        settingsView.isHidden = false
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
            } else {
                DispatchQueue.main.async {
                    self.showWatchErrorAlert()
                }
                
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        settingsView.isHidden = true
        pressedButtonSound()
        if let view = view as? SKView {
            view.scene?.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func brightnessSliderValueChanged(_ sender: Any) {
        UserDefaultsValues.brightness = Float(brightnessSlider.value)
        UIScreen.main.brightness = CGFloat(UserDefaultsValues.brightness)
    }
    
}
