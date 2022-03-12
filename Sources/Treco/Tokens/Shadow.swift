//
//  Shadow.swift
//  Treco
//
//  Created by Pedro Contine on 23/12/21.
//

import UIKit
import SwiftUI

public enum Shadow: String {
    case level1
    case level2
}

public extension Shadow {
    var offset: CGSize {
        let tokenPrefix = "shadowOffset_"
        let shadowOffsetToken = tokenPrefix + rawValue
        let height = TokensManager.shared.getFloatValue(shadowOffsetToken) ?? 0
        return .init(width: 0, height: height)
    }
    
    var radius: CGFloat {
        let tokenPrefix = "shadowRadius_"
        let shadowRadiusToken = tokenPrefix + rawValue
        return TokensManager.shared.getFloatValue(shadowRadiusToken) ?? 0
    }
}

// MARK: - Extensions

public struct TrecoShadow: ViewModifier {
    
    private let shadow: Shadow
    private let color: Colors
    
    public init(_ shadow: Shadow, color: Colors = .neutralDarkPure) {
        self.shadow = shadow
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .shadow(color: Color.treco(.neutralDarkPure), radius: shadow.radius, x: shadow.offset.width, y: shadow.offset.height)
    }
}

public extension View {
    func addShadow(_ shadow: Shadow, color: Colors = .neutralDarkPure) -> some View {
        modifier(TrecoShadow(shadow, color: color))
    }
}

public extension UIView {
    func addShadow(level: Shadow) {
        layer.shadowColor = UIColor.treco(.neutralDarkPure).cgColor
        layer.shadowOpacity = Float(Opacity.light.value)
        layer.shadowOffset = level.offset
        layer.shadowRadius = level.radius
    }
}
