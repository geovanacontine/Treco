//
//  Spacing.swift
//  Treco
//
//  Created by Pedro Contine on 23/12/21.
//

import UIKit
import SwiftUI

public enum Spacing: String {
    case none
    case xxxs
    case xxs
    case xs
    case sm
    case md
    case lg
    case xl
    case xxl
    
    public init(fromRawValue rawValue: String) {
        self = Spacing(rawValue: rawValue) ?? .none
    }
}

public extension Spacing {
    var value: CGFloat {
        let tokenPrefix = "spacing_"
        let spacingToken = tokenPrefix + rawValue
        return TokensManager.shared.getFloatValue(spacingToken) ?? 0
    }
}

// MARK: - TrecoSpacer

public struct TrecoSpacer: View {
    
    private let vertical: Spacing
    private let horizontal: Spacing
    
    public init(vertical: Spacing = .none, horizontal: Spacing = .none) {
        self.vertical = vertical
        self.horizontal = horizontal
    }
    
    public var body: some View {
        Spacer()
            .frame(width: horizontal.value, height: vertical.value)
    }
}
