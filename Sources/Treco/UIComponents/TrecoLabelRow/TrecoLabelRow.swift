//
//  TrecoLabelRow.swift
//  Treco
//
//  Created by Pedro Contine on 22/01/22.
//

import UIKit

public class TrecoLabelRow: UIView {
    
    private let verticalStackView = UIStackView()
    private let horizontalStackView = UIStackView()
    private let topDivisorView = UIView()
    private let bottomDivisorView = UIView()
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    private let disclosureIconView = UIImageView()
    
    private var dto: TrecoLabelRow.DTO?
    
    public init(dto: TrecoLabelRow.DTO, frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
        render(withDTO: dto)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        verticalStackView.axis = .vertical
        verticalStackView.spacing = Spacing.xxs.value
        fillWithSubview(subview: verticalStackView)
        
        topDivisorView.backgroundColor = .treco(.neutralDark3)
        topDivisorView.translatesAutoresizingMaskIntoConstraints = false
        topDivisorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        verticalStackView.addArrangedSubview(topDivisorView)
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = Spacing.xs.value
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        bottomDivisorView.backgroundColor = .treco(.neutralDark3)
        bottomDivisorView.translatesAutoresizingMaskIntoConstraints = false
        bottomDivisorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        verticalStackView.addArrangedSubview(bottomDivisorView)
        
        iconView.tintColor = .treco(.brandPure)
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.widthAnchor.constraint(equalToConstant: Spacing.sm.value).isActive = true
        horizontalStackView.addArrangedSubview(iconView)
        
        titleLabel.font = .init(style: .title3)
        titleLabel.textColor = .treco(.neutralDarkPure)
        horizontalStackView.addArrangedSubview(titleLabel)
        
        valueLabel.font = .init(style: .body)
        valueLabel.textColor = .treco(.neutralDark3)
        horizontalStackView.addArrangedSubview(valueLabel)
        
        disclosureIconView.image = .init(icon: .chevron, font: .init(style: .title3))
        disclosureIconView.tintColor = .treco(.neutralDark3)
        disclosureIconView.contentMode = .scaleAspectFit
        horizontalStackView.addArrangedSubview(disclosureIconView)
    }
    
    private func render(withDTO dto: TrecoLabelRow.DTO) {
        self.dto = dto
        
        iconView.image = .init(icon: dto.icon, font: .init(style: .title))
        titleLabel.text = dto.title
        valueLabel.text = dto.value
        
        topDivisorView.isHidden = !dto.hasTopDivisor
        bottomDivisorView.isHidden = !dto.hasBottomDivisor
        disclosureIconView.isHidden = !dto.hasDisclosureIcon
    }
}

// MARK: - DTO

public extension TrecoLabelRow {
    struct DTO {
        let title: String
        let icon: Icon
        let value: String?
        let hasTopDivisor: Bool
        let hasBottomDivisor: Bool
        let hasDisclosureIcon: Bool
        
        public init(title: String,
                    icon: Icon,
                    value: String? = nil,
                    hasTopDivisor: Bool = false,
                    hasBottomDivisor: Bool = true,
                    hasDisclosureIcon: Bool = true) {
            
            self.title = title
            self.icon = icon
            self.value = value
            self.hasTopDivisor = hasTopDivisor
            self.hasBottomDivisor = hasBottomDivisor
            self.hasDisclosureIcon = hasDisclosureIcon
        }
    }
}
