//
//  Spacing.swift
//  Photos
//
//  Created by Pedro Contine on 23/12/21.
//

import UIKit

public enum Spacing: CGFloat {
    case xxxs = 4
    case xxs = 8
    case xs = 16
    case sm = 24
    case md = 32
    case lg = 40
    case xl = 64
    case xxl = 96
}

public extension Spacing {
    var value: CGFloat {
        rawValue
    }
}
