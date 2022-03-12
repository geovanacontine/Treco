//
//  Border.swift
//  Treco
//
//  Created by Pedro Contine on 23/12/21.
//

import UIKit
import SwiftUI

// MARK: - BorderWidth

public enum BorderWidth: String {
    case none
    case thin
    case thick
    case thicker
}

public extension BorderWidth {
    var value: CGFloat {
        let tokenPrefix = "borderWidth_"
        let borderWidthToken = tokenPrefix + rawValue
        return TokensManager.shared.getFloatValue(borderWidthToken) ?? 0
    }
}

// MARK: - BorderRadius

public enum BorderRadius: String {
    case none
    case small
    case medium
    case large
}

public extension BorderRadius {
    var value: CGFloat {
        let tokenPrefix = "borderRadius_"
        let borderRadiusToken = tokenPrefix + rawValue
        return TokensManager.shared.getFloatValue(borderRadiusToken) ?? 0
    }
}

// MARK: - Extensions

public extension View {
    func addBorder(radius: BorderRadius, width: BorderWidth = .thin, color: Colors = .neutralDarkPure) -> some View {
        let roundedRect = RoundedRectangle(cornerRadius: radius.value)
        return clipShape(roundedRect)
            .overlay(roundedRect.strokeBorder(Color.treco(color), lineWidth: width.value))
    }
}

public extension UIView {
    func addBorder(width: BorderWidth,
                   radius: BorderRadius = .none,
                   color: UIColor = .clear) {
        
        layer.borderWidth = width.value
        layer.borderColor = color.cgColor
        layer.cornerRadius = radius.value
        clipsToBounds = true
    }
}
