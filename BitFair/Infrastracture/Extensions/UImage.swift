//
//  UImage.swift
//  BitFair
//
//  Created by Tanya Koldunova on 07.10.2022.
//

import UIKit

public extension UIImage {

    func tint(with color: UIColor) -> UIImage {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()

        image.draw(in: CGRect(origin: .zero, size: size))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

    func toAttributedString(with heightRatio: CGFloat, tint color: UIColor? = nil) -> NSAttributedString {
        let attachment = NSTextAttachment()
        var image = self

        if let tintColor = color {
            image.withRenderingMode(.alwaysTemplate)
            image = image.tint(with: tintColor)
        }

        attachment.image = image

        let ratio: CGFloat = image.size.width / image.size.height
        let attachmentBounds = attachment.bounds

        attachment.bounds = CGRect(x: attachmentBounds.origin.x,
                                   y: attachmentBounds.origin.y,
                                   width: ratio * heightRatio,
                                   height: heightRatio)

        return NSAttributedString(attachment: attachment)
    }
}
