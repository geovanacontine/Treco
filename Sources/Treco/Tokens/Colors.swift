//
//  Colors.swift
//  Treco
//
//  Created by Pedro Contine on 23/12/21.
//

import UIKit
import SwiftUI

public enum Colors: String {
    // Brand
    case brandPure
    
    // Neutral Light
    case neutralLightPure
    
    // Neutral Dark
    case neutralDarkPure
    case neutralDark2
    case neutralDark3
    
    // Feedback
    case feedbackError
    case feedbackSuccess
    case feedbackInfo
}

public extension UIColor {
    static func treco(_ color: Colors) -> UIColor {
        let tokenPrefix = "color_"
        let colorToken = tokenPrefix + color.rawValue
        let hex = TokensManager.shared.getStringValue(colorToken) ?? ""
        return .init(hex: hex)
    }
}

public extension Color {
    static func treco(_ color: Colors) -> Color {
        let uiColor: UIColor = .treco(color)
        return .init(uiColor)
    }
}
