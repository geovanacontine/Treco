//
//  TokensManager.swift
//  
//
//  Created by Pedro Contine on 27/02/22.
//

import Foundation

public class TokensManager: Decodable {
    
    public static let shared = TokensManager()
    
    private init() {}
    
    private var tokens: [String: String] = [:]
    
    public func loadTokens(_ tokens: [String: String]) {
        self.tokens = tokens
    }
    
    func getValue(_ token: String) -> String? {
        tokens[token]
    }
}
