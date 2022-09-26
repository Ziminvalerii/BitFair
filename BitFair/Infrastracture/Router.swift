//
//  Router.swift
//  BitFair
//
//  Created by Tanya Koldunova on 14.09.2022.
//

import UIKit


protocol RouterProtocol {
    var navigationController: UINavigationController {get set}
    var builder: BuilderProtocol {get set}
    func start()
}


class Router: RouterProtocol {
    var navigationController: UINavigationController
    
    var builder: BuilderProtocol
    
    init(navigationController: UINavigationController, builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func start() {
        let vc = builder.resolveGameViewController(router: self)
        navigationController.viewControllers = [vc]
    }
    
    
}
