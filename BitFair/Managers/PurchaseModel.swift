

import StoreKit

public struct ProductSub: Hashable {
    let subsctiption: Subscription
    let title: String
    var price: String?
    let locale: Locale
    let product: SKProduct
    
    lazy var formatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.locale = locale
        return nf
    }()
    
    init(_ product: SKProduct) {
        self.product = product
        self.subsctiption = Subscription.allCases.first(where: {$0.rawValue == product.productIdentifier}) ?? .newbieKnightCharacter
        self.title = product.localizedTitle
        self.locale = product.priceLocale
        self.price = formatter.string(from: product.price)
    }
    
    
}

