//
//  Builder.swift
//  BitFair
//
//  Created by Tanya Koldunova on 14.09.2022.
//

import Foundation

protocol BuilderProtocol {
    func resolveGameViewController(router: RouterProtocol) -> GameViewController
    func resolveSettingsView() -> SettingsView
}

class Builder: BuilderProtocol {
    
    func resolveGameViewController(router: RouterProtocol) -> GameViewController {
        let vc = GameViewController.instantiateMyViewController(name: .game)
        vc.presenter = GamePresenter(view: vc, router: router, adManager: AdsManager())
        return vc
    }
    
    func resolveSettingsView() -> SettingsView {
        let view = SettingsView()
        return view
    }
}
