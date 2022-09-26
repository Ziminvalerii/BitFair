//
//  Shop+IAP.swift
//  BitFair
//
//  Created by Tanya Koldunova on 26.09.2022.
//

import SpriteKit

extension ShopNode {
    func requestProduct() {
        iapManager.requestProducts { products in
            self.products = products
            DispatchQueue.main.async {
                if self.model[self.currentIndex].purchaseIdentifier != nil {
                self.configureButtons(model: self.model[self.currentIndex])
                }
            }
        }
    }
    
    func buyProduct(model: StoreModel) {
        if let product = products?.first(where: {$0.subsctiption.rawValue == model.purchaseIdentifier}) {
            iapManager.buyProduct(product.product) { success, productId in
                if success {
                    self.getBuyProduct(model: model)
                }
            }
        }
    }
}
