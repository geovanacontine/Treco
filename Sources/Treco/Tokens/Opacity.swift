//
//  Opacity.swift
//  Treco
//
//  Created by Pedro Contine on 23/12/21.
//

import UIKit

public enum Opacity: String {
    case none
    case semiOpaque
    case intense
    case medium
    case light
}

public extension Opacity {
    var value: CGFloat {
        let tokenPrefix = "opacity_"
        let opacityToken = tokenPrefix + rawValue
        return TokensManager.shared.getFloatValue(opacityToken) ?? 0
    }
}
