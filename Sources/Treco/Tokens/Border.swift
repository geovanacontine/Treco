//
//  Border.swift
//  Treco
//
//  Created by Pedro Contine on 23/12/21.
//

import UIKit

public enum BorderWidth: CGFloat {
    case none = 0
    case thin = 1
    case thick = 2
    case thicker = 4
}

public enum BorderRadius: CGFloat {
    case none = 0
    case small = 4
    case medium = 8
    case large = 16
}

public extension UIView {
    func addBorder(width: BorderWidth,
                   radius: BorderRadius = .none,
                   color: UIColor = .clear) {
        
        layer.borderWidth = width.rawValue
        layer.borderColor = color.cgColor
        layer.cornerRadius = radius.rawValue
        clipsToBounds = true
    }
}
