//
//  Icons.swift
//  Treco
//
//  Created by Pedro Contine on 15/01/22.
//

import Foundation
import UIKit

public enum Icon: String {
    case error = "exclamationmark.circle.fill"
    case success = "checkmark.circle.fill"
    case close = "xmark"
    case profile = "person.crop.circle.fill"
    case chevron = "chevron.right"
    case password = "lock.circle.fill"
    case trash = "trash.circle.fill"
    case document = "doc.circle.fill"
    case signOut = "chevron.left.circle.fill"
}

public extension UIImage {
    convenience init(icon: Icon) {
        self.init(named: icon.rawValue)!
    }
    
    convenience init(icon: Icon, font: UIFont) {
        let config = UIImage.SymbolConfiguration(font: font)
        self.init(systemName: icon.rawValue, withConfiguration: config)!
    }
}
