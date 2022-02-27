//
//  Fonts.swift
//  Treco
//
//  Created by Pedro Contine on 23/12/21.
//

import UIKit

public enum FontFamily: String {
    case base = "Roboto"
}

public enum FontSize: CGFloat {
    case us = 12
    case xxxs = 14
    case xxs = 16
    case xs = 20
    case sm = 24
    case md = 32
    case lg = 40
    case xl = 48
    case xxl = 56
}

public enum FontWeight: String {
    case light
    case regular
    case medium
    case bold
}

public enum FontStyle {
    case caption
    case body
    case title
    case title2
    case title3
    case largeTitle
}

public extension FontStyle {
    var size: FontSize {
        switch self {
        case .caption:
            return .us
        case .body:
            return .xxxs
        case .title:
            return .sm
        case .title2, .title3:
            return .xxs
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
}

public extension UIFont {
    convenience init(style: FontStyle, family: FontFamily = .base) {
        let fontName = family.rawValue + "-" + style.weight.rawValue.capitalized
        self.init(name: fontName, size: style.size.rawValue)!
    }
    
    convenience init(size: FontSize, weight: FontWeight, family: FontFamily = .base) {
        let fontName = family.rawValue + "-" + weight.rawValue.capitalized
        self.init(name: fontName, size: size.rawValue)!
    }
}
