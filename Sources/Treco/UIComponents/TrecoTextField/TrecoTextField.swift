//
//  LRTextFieldComponent.swift
//  Treco
//
//  Created by Pedro Contine on 15/01/22.
//

import Foundation
import UIKit

public protocol LRTextFieldComponentDelegate: AnyObject {
    func didFinishEditingTextField(_ textField: TrecoTextField, text: String)
    func didFinishEditingWithError(errorMessage: String)
}

public extension LRTextFieldComponentDelegate {
    func didFinishEditingWithError(errorMessage: String) {}
}

public class TrecoTextField: UIView {
    
    weak var delegate: LRTextFieldComponentDelegate?
    
    private let titleLabel = UILabel()
    private let textField = TrecoPaddingTextField()
    private let errorImageView = UIImageView()
    
    private var titleLabelWidthConstraint: NSLayoutConstraint?
    private let textFieldHeight: CGFloat = 50
    
    private var dto: TrecoTextField.DTO?
    
    public init(dto: TrecoTextField.DTO, frame: CGRect = .zero) {
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
        setupTextField()
        setupTitleLabel()
        setupErrorImageView()
    }
    
    func render(withDTO dto: TrecoTextField.DTO) {
        self.dto = dto
        
        titleLabel.text = dto.title
        titleLabelWidthConstraint?.constant = getTitleWidth()
        textField.textContentType = dto.type.contentType
        textField.keyboardType = dto.type.keyboardType
        textField.isSecureTextEntry = dto.type.shouldHideText
        errorImageView.isHidden = true
        
        if !dto.text.isEmpty {
            animateTitleToTopPosition()
            textField.text = dto.text
        }
        
        textField.isEnabled = dto.isEnabled
        textField.textColor = dto.isEnabled ? .treco(.neutralDarkPure) : .treco(.neutralDark2)
    }
}

// MARK: - Setup elements

public extension TrecoTextField {
    private func setupTextField() {
        textField.delegate = self
        
        fillWithSubview(subview: textField, spacing: .init(top: 0,
                                                           left: 0,
                                                           bottom: Spacing.xxs.value,
                                                           right: 0))
        
        let heightConstraint = NSLayoutConstraint(item: textField,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: textFieldHeight)
        
        textField.addConstraint(heightConstraint)
        
        textField.padding = .init(top: Spacing.xxs.value,
                                  left: Spacing.xxs.value + 2,
                                  bottom: Spacing.xxs.value,
                                  right: Spacing.xxs.value)
        
        textField.addBorder(width: .thin, radius: .small, color: .treco(.neutralDark3))
        textField.tintColor = .treco(.neutralDark3)
        textField.font = .init(style: .title3)
        textField.addDoneButtonToKeyboard(title: "Confirmar")
    }
    
    private func setupTitleLabel() {
        titleLabel.font = .init(style: .body)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .treco(.neutralDark2)
        titleLabel.backgroundColor = .treco(.neutralLightPure)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor,
                                                constant: Spacing.xxs.value),
            titleLabel.topAnchor.constraint(equalTo: textField.topAnchor,
                                            constant: Spacing.xxs.value),
            titleLabel.bottomAnchor.constraint(equalTo: textField.bottomAnchor,
                                               constant: -Spacing.xxs.value)
        ])
        
        let constraint = titleLabel.widthAnchor.constraint(equalToConstant: getTitleWidth())
        titleLabelWidthConstraint = constraint
        titleLabelWidthConstraint?.isActive = true
        addConstraint(constraint)
    }
    
    private func setupErrorImageView() {
        errorImageView.image = .init(icon: .error, font: .init(style: .caption))
        errorImageView.tintColor = .treco(.feedbackError)
        errorImageView.contentMode = .scaleAspectFit
        
        errorImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(errorImageView)
        
        NSLayoutConstraint.activate([
            errorImageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            errorImageView.trailingAnchor.constraint(equalTo: textField.trailingAnchor,
                                                     constant: -Spacing.xs.value),
            errorImageView.widthAnchor.constraint(equalToConstant: Spacing.xs.value),
            errorImageView.heightAnchor.constraint(equalToConstant: Spacing.xs.value)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapErrorImage))
        errorImageView.isUserInteractionEnabled = true
        errorImageView.addGestureRecognizer(tapGesture)
    }
    
    private func animateTitleToTopPosition() {
        let xOffset = getTitleWidth() * 0.1
        let yOffset = textFieldHeight * 0.6
        
        UIView.animate(withDuration: 0.3) {
            let translation = CGAffineTransform(translationX: -xOffset, y: -yOffset)
            let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.titleLabel.transform = translation.concatenating(scale)
        }
    }
    
    private func animateTitleToDefaultPosition() {
        UIView.animate(withDuration: 0.3) {
            let translation = CGAffineTransform(translationX: 0, y: 0)
            let scale = CGAffineTransform(scaleX: 1, y: 1)
            self.titleLabel.transform = translation.concatenating(scale)
        }
    }
    
    private func getTitleWidth() -> CGFloat {
        let title = titleLabel.text ?? ""
        let fontAttributes = [NSAttributedString.Key.font: UIFont.init(style: .title3)]
        return title.size(withAttributes: fontAttributes).width + Spacing.xxxs.value
    }
}

// MARK: - Error handling

public extension TrecoTextField {
    private func hasError() -> Bool {
        let text = textField.text ?? ""
        return dto?.type.getErrorMessage(text: text) != nil
    }
    
    private func setupErrorFeedback() {
        guard let text = textField.text,
              let errorMessage = dto?.type.getErrorMessage(text: text) else {
                  return
              }
        
        errorImageView.isHidden = false
        delegate?.didFinishEditingWithError(errorMessage: errorMessage)
        UINotificationFeedbackGenerator().notificationOccurred(.error)
        textField.addBorder(width: .thin, radius: .small, color: .treco(.feedbackError))
        titleLabel.textColor = .treco(.feedbackError)
        textField.tintColor = .treco(.feedbackError)
    }
    
    private func setupViewNormalState() {
        errorImageView.isHidden = true
        textField.addBorder(width: .thin, radius: .small, color: .treco(.neutralDark3))
        titleLabel.textColor = .treco(.neutralDark3)
        textField.tintColor = .treco(.neutralDark3)
    }
    
    @objc private func didTapErrorImage() {
        guard let text = textField.text,
              let errorMessage = dto?.type.getErrorMessage(text: text) else {
                  return
              }
        
        delegate?.didFinishEditingWithError(errorMessage: errorMessage)
    }
}

// MARK: - UITextFieldDelegate

extension TrecoTextField: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        animateTitleToTopPosition()
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        let text = textField.text ?? ""
        
        if text.isEmpty {
            animateTitleToDefaultPosition()
        }
        
        if hasError(), dto?.shouldShowErrors == true {
            setupErrorFeedback()
        } else {
            setupViewNormalState()
            delegate?.didFinishEditingTextField(self, text: text)
        }
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text,
              let stringRange = Range(range, in: currentText),
              let maxCharacters = dto?.maxCharacters else {
                  return false
              }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= maxCharacters
    }
}

// MARK: - DTO

public extension TrecoTextField {
    struct DTO {
        let title: String
        var type: TrecoTextFieldType
        let text: String
        let shouldShowErrors: Bool
        let isEnabled: Bool
        let maxCharacters: Int
        
        public init(title: String,
                    type: TrecoTextFieldType,
                    text: String = "",
                    shouldShowErrors: Bool = false,
                    isEnabled: Bool = true,
                    maxCharacters: Int = 255) {
            
            self.title = title
            self.type = type
            self.text = text
            self.shouldShowErrors = shouldShowErrors
            self.isEnabled = isEnabled
            self.maxCharacters = maxCharacters
        }
    }
}
