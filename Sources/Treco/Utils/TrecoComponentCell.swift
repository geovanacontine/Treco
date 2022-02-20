//
//  TrecoComponentCell.swift
//  PhotosApp
//
//  Created by Pedro Contine on 18/01/22.
//

import UIKit

public class TrecoComponentCell: UITableViewCell {
    
    var component: UIView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        selectionStyle = .none
    }
    
    func render(component: UIView, spacing: UIEdgeInsets = .zero) {
        self.component = component
        contentView.subviews.forEach { $0.removeFromSuperview() }
        contentView.fillWithSubview(subview: component, spacing: spacing)
    }
}
