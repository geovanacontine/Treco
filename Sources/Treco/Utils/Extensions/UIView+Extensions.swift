//
//  UIView+Extensions.swift
//  Treco
//
//  Created by Pedro Contine on 23/12/21.
//

import UIKit

public extension UIView {
    func fillWithSubview(subview: UIView, spacing: UIEdgeInsets = .zero) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing.left),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing.right),
            subview.topAnchor.constraint(equalTo: topAnchor, constant: spacing.top),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -spacing.bottom)
        ])
    }
}
