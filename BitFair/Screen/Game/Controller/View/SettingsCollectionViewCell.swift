//
//  SettingsCollectionViewCell.swift
//  BitFair
//
//  Created by Tanya Koldunova on 11.10.2022.
//

import UIKit
import SpriteKit

class SettingsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var controlButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont(name: "Pixel Cyr", size: 17)
        }
    }
    private var model: SettingsModel?
    func configure(model: SettingsModel) {
        self.titleLabel.text = model.title
        self.controlButton.setImage(model.isOn ? model.onTexture : model.offTexture, for: .normal)
        self.model = model
    }
    
    func updateValue(model: SettingsModel) {
        self.controlButton.setImage(model.isOn ? model.onTexture : model.offTexture, for: .normal)
    }
    @IBAction func buttonPressed(_ sender: Any) {
        if let model = model {
            model.setValue()
            updateValue(model: model)
        }
    }
}
