//
//  SettingsView.swift
//  BitFair
//
//  Created by Tanya Koldunova on 14.09.2022.
//

import UIKit

@IBDesignable class SettingsView: UIView {
    
    @IBOutlet weak var soundOffButton: UIButton!
    @IBOutlet weak var soundOnButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var shopButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var showRestart: Bool = false {
        didSet {
            restartButton.isHidden = !showRestart
            shopButton.isHidden = showRestart
        }
    }
    
    convenience init() {
        let size = CGSize(width: 584, height: 357)
        self.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        guard let view = loadFromNib(nib: SettingsView.self) else {return}
        view.frame = self.frame
        view.layer.borderWidth = 10.0
        view.layer.borderColor = UIColor.black.cgColor
        addSubview(view)
        
    }
    
    @IBAction func soundOffButtonPressed(_ sender: Any) {
        UserDefaultsValues.soundOff = true
    }
    @IBAction func soundOnButtonPressed(_ sender: Any) {
        UserDefaultsValues.soundOff = false
    }
    @IBAction func restartButtonPressed(_ sender: Any) {
    }
    @IBAction func shopButtonPressed(_ sender: Any) {
    }
    

}
