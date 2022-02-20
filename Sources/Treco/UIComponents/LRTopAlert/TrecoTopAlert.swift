//
//  TrecoTopAlert.swift
//  PhotosApp
//
//  Created by Pedro Contine on 16/01/22.
//

import UIKit

public class TrecoTopAlert: UIView {
    
    private let stackView = UIStackView()
    private let iconView = UIImageView()
    private let messageLabel = UILabel()
    private let closeIconView = UIImageView()
    
    private let alertHeight: CGFloat = 50
    private let initialTopSpacing: CGFloat = Spacing.xxs.value
    private let topSpacing: CGFloat =  Spacing.lg.value
    private let horizontalSpacing: CGFloat = Spacing.md.value
    
    private var dto: TrecoTopAlert.DTO?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func removeFromSuperview() {
        showDismissAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            super.removeFromSuperview()
        }
    }
    
    private func setupView() {
        addBorder(width: .thin, radius: .small)
        messageLabel.font = .init(style: .body)
        messageLabel.numberOfLines = 0
        
        stackView.axis = .horizontal
        stackView.spacing = Spacing.xs.value
        stackView.distribution = .fillProportionally
        fillWithSubview(subview: stackView, spacing: .init(top: .zero,
                                                           left: Spacing.xs.value,
                                                           bottom: .zero,
                                                           right: Spacing.xs.value))
        stackView.addArrangedSubview(iconView)
        stackView.addArrangedSubview(messageLabel)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCloseAlertButton))
        closeIconView.isUserInteractionEnabled = true
        closeIconView.addGestureRecognizer(tapGesture)
        stackView.addArrangedSubview(closeIconView)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(didTapCloseAlertButton))
        swipeGesture.direction = .up
        isUserInteractionEnabled = true
        addGestureRecognizer(swipeGesture)
    }
    
    @objc func didTapCloseAlertButton() {
        removeFromSuperview()
    }
}

// MARK: - Render

public extension TrecoTopAlert {
    func render(withDTO dto: TrecoTopAlert.DTO) {
        self.dto = dto
        
        backgroundColor = dto.style.backgroundColor
        messageLabel.text = dto.message
        messageLabel.textColor = dto.style.messageFontColor
        setupIcons(style: dto.style)
        setupAlertFrame()
        
        if dto.shouldAutoDismiss {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.removeFromSuperview()
            }
        }
    }
    
    private func setupIcons(style: LRAlertStyle) {
        iconView.image = .init(icon: style.icon, font: .init(style: .caption))
        iconView.tintColor = style.messageFontColor
        iconView.contentMode = .scaleAspectFit
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.widthAnchor.constraint(equalToConstant: Spacing.sm.value).isActive = true
        
        closeIconView.image = .init(icon: .close, font: .init(style: .caption))
        closeIconView.tintColor = style.messageFontColor
        closeIconView.contentMode = .scaleAspectFit
        
        closeIconView.translatesAutoresizingMaskIntoConstraints = false
        closeIconView.widthAnchor.constraint(equalToConstant: 12).isActive = true
    }
    
    private func showDismissAnimation() {
        UIView.animate(withDuration: 1) {
            self.alpha = 0
            self.transform = CGAffineTransform(translationX: 0, y: self.initialTopSpacing)
        }
    }
    
    private func setupAlertFrame() {
        let maxWidth = superview?.frame.width ?? 0
        let fixedWidth = maxWidth - (2 * horizontalSpacing)
        
        alpha = 0
        frame = CGRect(x: horizontalSpacing,
                       y: initialTopSpacing,
                       width: fixedWidth,
                       height: alertHeight)
        
        UIView.animate(withDuration: 1) {
            self.alpha = 1
            self.transform = CGAffineTransform(translationX: 0, y: self.topSpacing)
        }
    }
}

// MARK: - DTO

public extension TrecoTopAlert {
    struct DTO {
        let message: String
        let style: LRAlertStyle
        let shouldAutoDismiss: Bool
        
        public init(message: String, style: LRAlertStyle, shouldAutoDismiss: Bool) {
            self.message = message
            self.style = style
            self.shouldAutoDismiss = shouldAutoDismiss
        }
    }
}

public enum LRAlertStyle {
    case error
    case success
}

public extension LRAlertStyle {
    var icon: Icon {
        switch self {
        case .error:
            return .error
        case .success:
            return .success
        }
    }
    
    var messageFontColor: UIColor {
        switch self {
        case .error, .success:
            return .neutralLightPure
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .error:
            return .feedbackError
        case .success:
            return .feedbackSuccess
        }
    }
}
