//
//  BaseView.swift
//  BitFair
//
//  Created by Tanya Koldunova on 14.09.2022.
//

import UIKit

extension UIView {
    func loadFromNib(nib: AnyObject.Type)->UIView? {
       let nibName = String(describing: nib.self)
       let bundle = Bundle(for: type(of: self))
       let nib = UINib(nibName: nibName, bundle: bundle)
       return nib.instantiate(withOwner: self, options: nil).first as? UIView
   }
   
}

class BaseView<T>: UIView {
    var presenter: T! {
        didSet {
            presenterDidSet()
        }
    }
    
    
    func presenterDidSet() {}
}
