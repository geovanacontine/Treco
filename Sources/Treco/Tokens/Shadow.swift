//
//  Shadow.swift
//  Treco
//
//  Created by Pedro Contine on 23/12/21.
//

import UIKit

public enum ShadowLevel {
    case level1
    case level2
}

public extension ShadowLevel {
    var offset: CGSize {
        switch self {
        case .level1:
            return .init(width: 0, height: 4)
        case .level2:
            return .init(width: 0, height: 8)
        }
    }
    
    var radius: CGFloat {
        switch self {
        case .level1:
            return 8
        case .level2:
            return 16
        }
    }
}

public extension UIView {
    func addShadow(level: ShadowLevel) {
        layer.shadowColor = UIColor.treco(.neutralDarkPure).cgColor
        layer.shadowOpacity = Opacity.light.rawValue
        layer.shadowOffset = level.offset
        layer.shadowRadius = level.radius
    }
}
