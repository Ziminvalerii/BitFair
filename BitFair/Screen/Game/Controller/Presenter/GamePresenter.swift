//
//  GamePresenter.swift
//  BitFair
//
//  Created by Tanya Koldunova on 14.09.2022.
//

import Foundation
import UIKit

protocol GameViewProtocol:AnyObject {
    func setChilds(childs: [UIView])
    func shopButtonPressed()
    func restartButtonPressed()
    func cancelButtonPressed()
}

protocol GamePresenterProtocol:AnyObject {
    init(view:GameViewProtocol, router: RouterProtocol, adManager: AdsManager)
    var adManager: AdsManager {get set}
    func showSettingsView(showRestartButton:Bool)->UIView
    
}

class GamePresenter:GamePresenterProtocol {
    weak var view: GameViewProtocol?
    var router: RouterProtocol
    var adManager: AdsManager
    private lazy var overlay: UIView = {
        let overlay = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        return overlay
    }()
    
    required init(view: GameViewProtocol, router: RouterProtocol, adManager: AdsManager) {
        self.view = view
        self.router = router
        self.adManager = adManager
    }
    
    func showSettingsView(showRestartButton:Bool)->UIView {
        let view = getSettingsView()
        view.showRestart = showRestartButton
        view.cancelButton.addTarget(self, action: #selector(settingsCancelButtonTapped(_:)), for: .touchUpInside)
        view.restartButton.addTarget(self, action: #selector(settingsRestartButtonTapped(_:)), for: .touchUpInside)
        view.shopButton.addTarget(self, action: #selector(settingsShopButtonTapped(_:)), for: .touchUpInside)
        view.center = overlay.center
        overlay.addSubview(view)
        return overlay
       // self.view?.setChilds(childs: [overlay])
    }
    
    @objc func settingsCancelButtonTapped(_ sender:UIButton) {
        overlay.removeFromSuperview()
        view?.cancelButtonPressed()
    }
    @objc func settingsRestartButtonTapped(_ sender:UIButton) {
        overlay.removeFromSuperview()
        view?.cancelButtonPressed()
        view?.restartButtonPressed()
    }
                                  
    @objc func settingsShopButtonTapped(_ sender:UIButton) {
        overlay.removeFromSuperview()
        view?.cancelButtonPressed()
        view?.shopButtonPressed()
        
    }
    
    func getSettingsView()->SettingsView {
        let settingsView = router.builder.resolveSettingsView()
        return settingsView
    }
    
    
    
    
}
