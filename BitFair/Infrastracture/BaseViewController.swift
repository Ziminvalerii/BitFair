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
        return [.landscapeRight, .landscapeLeft]
    }
    
//    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
//        return .landscapeRight
//    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
