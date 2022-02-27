//
//  TrecoButton.swift
//  Treco
//
//  Created by Pedro Contine on 16/01/22.
//

import UIKit

public protocol TrecoButtonDelegate: AnyObject {
    func didTapButton(_ button: TrecoButton)
}

public class TrecoButton: UIView {
    
    var identifier: String?
    weak var delegate: TrecoButtonDelegate?
    
    private let button = UIButton()
    private var activityIndicator: UIActivityIndicatorView?
    
    private var dto: TrecoButton.DTO?
    private var isLoading: Bool = false
    private let buttonHeight: CGFloat = 50
    
    public init(dto: TrecoButton.DTO, frame: CGRect = .zero) {
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
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.titleLabel?.font = .init(style: .title2)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        fillWithSubview(subview: button)
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
    private func render(withDTO dto: TrecoButton.DTO) {
        self.dto = dto
        
        button.setTitle(dto.title, for: .normal)
        button.setTitleColor(dto.textColor, for: .normal)
        button.backgroundColor = dto.isSecondary ? .clear : dto.backgroundColor
        button.isEnabled = dto.isEnabled
        
        if dto.hasBorder {
            button.addBorder(width: .thick, radius: .small, color: dto.backgroundColor)
        }
    }
    
    @objc private func didTapButton() {
        guard !isLoading else {
            return
        }
        
        delegate?.didTapButton(self)
    }
}

// MARK: - Loading

public extension TrecoButton {
    func startLoading() {
        setupActivityIndicator()
        
        guard let activityIndicator = activityIndicator else {
            return
        }
        
        isLoading = true
        button.setTitle("", for: .normal)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        isLoading = false
        button.setTitle(dto?.title, for: .normal)
        activityIndicator?.stopAnimating()
    }
    
    private func setupActivityIndicator() {
        guard activityIndicator == nil else {
            return
        }
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .treco(.neutralLightPure)
        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.isHidden = true
        self.activityIndicator = activityIndicator
        
        button.addSubview(activityIndicator)
    }
}

// MARK: - DTO

public extension TrecoButton {
    struct DTO {
        let title: String
        let backgroundColor: UIColor
        let textColor: UIColor
        let isEnabled: Bool
        let isSecondary: Bool
        let hasBorder: Bool
        
        public init(title: String,
                    backgroundColor: UIColor = .treco(.brandPure),
                    textColor: UIColor = .treco(.neutralLightPure),
                    isEnabled: Bool = true,
                    isSecondary: Bool = false,
                    hasBorder: Bool = true) {
            
            self.title = title
            self.backgroundColor = backgroundColor
            self.textColor = textColor
            self.isEnabled = isEnabled
            self.isSecondary = isSecondary
            self.hasBorder = hasBorder
        }
    }
}
