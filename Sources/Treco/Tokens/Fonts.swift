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
    case base = "Montserrat"
}

// MARK: - FontSize

public enum FontSize: String {
    case xxxs
    case xxs
    case xs
    case sm
    case md
    case lg
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
    case semiBold
    case bold
}

// MARK: - FontStyle

public enum FontStyle: String {
    case heading1
    case heading2
    case heading3
    case heading4
    case paragraph
    case description
    case caption
    
    public init(fromRawValue rawValue: String) {
        self = FontStyle(rawValue: rawValue) ?? .paragraph
    }
}

public extension FontStyle {
    var size: FontSize {
        switch self {
        case .heading1:
            return .lg
        case .heading2:
            return .md
        case .heading3:
            return .sm
        case .heading4:
            return .xs
        case .paragraph:
            return .xs
        case .description:
            return .xxs
        case .caption:
            return .xxxs
        }
    }
    
    var weight: FontWeight {
        switch self {
        case .heading1:
            return .bold
        case .heading2:
            return .bold
        case .heading3:
            return .semiBold
        case .heading4:
            return .semiBold
        case .paragraph:
            return .regular
        case .description:
            return .regular
        case .caption:
            return .light
        }
    }
    
    var color: Color {
        switch self {
        case .description, .caption:
            return Color.treco(.neutralDark2)
        default:
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
    private let color: Color?
    
    public init(style: FontStyle, color: Color? = nil) {
        self.style = style
        self.color = color
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
            .foregroundColor(color ?? style.color)
    }
}

public extension View {
    func textStyle(_ style: FontStyle, color: Color? = nil) -> some View {
        modifier(TrecoTextStyle(style: style, color: color))
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
