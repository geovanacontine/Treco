//
//  Fonts.swift
//  Treco
//
//  Created by Pedro Contine on 23/12/21.
//

import UIKit
import SwiftUI

// MARK: - FontFamily

public enum FontFamily: String {
    case base = "Roboto"
}

// MARK: - FontSize

public enum FontSize: String {
    case us
    case xxxs
    case xxs
    case xs
    case sm
    case md
    case lg
    case xl
    case xxl
}

public extension FontSize {
    var value: CGFloat {
        let tokenPrefix = "fontSize_"
        let fontSizeToken = tokenPrefix + rawValue
        return TokensManager.shared.getFloatValue(fontSizeToken) ?? 0
    }
}

// MARK: - FontWeight

public enum FontWeight: String {
    case light
    case regular
    case medium
    case bold
}

// MARK: - FontStyle

public enum FontStyle: String {
    case caption
    case body
    case title
    case title2
    case title3
    case largeTitle
    
    public init(fromRawValue rawValue: String) {
        self = FontStyle(rawValue: rawValue) ?? .body
    }
}

public extension FontStyle {
    var size: FontSize {
        switch self {
        case .caption:
            return .us
        case .body:
            return .xxxs
        case .title2, .title3:
            return .xxs
        case .title:
            return .sm
        case .largeTitle:
            return .lg
        }
    }
    
    var weight: FontWeight {
        switch self {
        case .caption:
            return .light
        case .body, .title3:
            return .regular
        case .title2:
            return .medium
        case .title, .largeTitle:
            return .bold
        }
    }
    
    var color: Color {
        switch self {
        case .caption:
            return Color.treco(.neutralDark3)
        case .body, .title3:
            return Color.treco(.neutralDark2)
        case .title2, .title, .largeTitle:
            return Color.treco(.neutralDarkPure)
        }
    }
    
    var family: FontFamily {
        return .base
    }
}

// MARK: - TrecoText

public struct TrecoText: View {
    
    private let text: String
    
    public init(_ text: String) {
        self.text = text
    }
    
    public var body: some View {
        Text(text)
    }
}

// MARK: - TrecoTextStyle

public struct TrecoTextStyle: ViewModifier {
    
    private let style: FontStyle
    
    public init(style: FontStyle) {
        self.style = style
    }
    
    private var fontName: String {
        style.family.rawValue + "-" + style.weight.rawValue.capitalized
    }
    
    private var fontSize: CGFloat {
        style.size.value
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.custom(fontName, size: fontSize))
            .foregroundColor(style.color)
    }
}

public extension View {
    func textStyle(_ style: FontStyle) -> some View {
        modifier(TrecoTextStyle(style: style))
    }
}

// MARK: - UIFont

public extension UIFont {
    convenience init(style: FontStyle, family: FontFamily = .base) {
        let fontName = family.rawValue + "-" + style.weight.rawValue.capitalized
        self.init(name: fontName, size: style.size.value)!
    }
    
    convenience init(size: FontSize, weight: FontWeight, family: FontFamily = .base) {
        let fontName = family.rawValue + "-" + weight.rawValue.capitalized
        self.init(name: fontName, size: size.value)!
    }
}
