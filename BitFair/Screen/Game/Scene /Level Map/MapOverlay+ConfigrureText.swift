//
//  MapOverlay+ConfigrureText.swift
//  BitFair
//
//  Created by Tanya Koldunova on 26.09.2022.
//

import SpriteKit

extension MapOverlay {
    
    func setText(_ text: String) {
        let text =  NSAttributedString(string: text, attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 32)!, .foregroundColor: UIColor.black])
        levelLabel.attributedText = text
    }
    
    func setPlayLabel(available: Bool) {
        let text =  NSAttributedString(string: available ? "Play" : "Locked", attributes: [.font : UIFont(name: "PixelCyr-Normal", size: 17)!, .foregroundColor: UIColor.white])
        if let label = playLevel.childNode(withName: "play label node") as? SKLabelNode {
            label.attributedText = text
        }
    }
}
