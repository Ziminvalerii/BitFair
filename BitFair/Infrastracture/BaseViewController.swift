//
//  BaseViewController.swift
//  BitFair
//
//  Created by Tanya Koldunova on 14.09.2022.
//

import UIKit


class BaseViewController<T>: UIViewController {
    var presenter: T!
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscapeRight
        } else {
            return .landscapeLeft
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
