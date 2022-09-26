//
//  InstructionOverlay.swift
//  BitFair
//
//  Created by Tanya Koldunova on 22.09.2022.
//

import SpriteKit


class InstructionOberlay: ChooseBackground {
    
    convenience init(with size: CGSize) {
        self.init(with: size, frameNode: InstructionNode())
    
        
    }
}
