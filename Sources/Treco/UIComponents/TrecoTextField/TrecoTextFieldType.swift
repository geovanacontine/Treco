//
//  TrecoTextFieldType.swift
//  Treco
//
//  Created by Pedro Contine on 16/01/22.
//

import UIKit

public enum TrecoTextFieldType {
    case text
    case number
    case email
    case password
    case confirmPassword(password: String)
    
    var contentType: UITextContentType? {
        switch self {
        case .email:
            return .emailAddress
        case .password, .confirmPassword:
            return .password
        default:
            return nil
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .email:
            return .emailAddress
        case .number:
            return .numberPad
        default:
            return .default
        }
    }
    
    var shouldHideText: Bool {
        switch self {
        case .password, .confirmPassword:
            return true
        default:
            return false
        }
    }
    
    func getErrorMessage(text: String) -> String? {
        switch self {
        case .email:
            return isValidEmail(text: text) ? nil : Strings.invalidEmail
        case .password:
            return isValidPassword(text: text) ? nil : Strings.minCharactersPassword
        case .confirmPassword(let password):
            return text == password ? nil : Strings.passwordDontMatch
        default:
            return text.isEmpty ? Strings.mandatoryField : nil
        }
    }
}

public extension TrecoTextFieldType {
    private func isValidEmail(text: String) -> Bool {
        let REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: text)
    }
    
    private func isValidPassword(text: String) -> Bool {
        let minCharacters = 6
        return text.count >= minCharacters && !text.isEmpty
    }
}

public extension TrecoTextFieldType {
    struct Strings {
        static let mandatoryField = "Campo obrigatório"
        static let invalidEmail = "Email inválido"
        static let minCharactersPassword = "Senha precisa ter ao menos 6 caracteres"
        static let passwordDontMatch = "Senhas não são iguais"
    }
}
