//
//  TokensManager.swift
//  
//
//  Created by Pedro Contine on 27/02/22.
//

import Foundation
import UIKit

public class TokensManager {
    
    public static let shared = TokensManager()
    private var tokens: [String: String] = [:]
    private init() {}
}

// MARK: - Public methods

extension TokensManager {
    public func setTheme(fromDict tokens: [String: String]) {
        self.tokens = tokens
    }
    
    public func setTheme(fromJson jsonName: String) {
        let jsonData = loadTokensFromJson(named: jsonName)
        self.tokens = jsonData ?? [:]
    }
}

// MARK: - Internal methods

extension TokensManager {
    public func getStringValue(_ token: String) -> String? {
        tokens[token]
    }
    
    public func getFloatValue(_ token: String) -> CGFloat? {
        guard let sizeString = tokens[token],
              let sizeDouble = Double(sizeString) else {
            return nil
        }
        
        return CGFloat(sizeDouble)
    }
}

// MARK: - Private methods

extension TokensManager {
    private func loadTokensFromJson(named jsonName: String) -> [String: String]? {
        guard let url = Bundle.main.url(forResource: jsonName, withExtension: "json") else {
            return nil
        }
        
        let data = (try? Data(contentsOf: url)) ?? Data()
        let decoder = JSONDecoder()
        return try? decoder.decode([String: String].self, from: data)
    }
}
