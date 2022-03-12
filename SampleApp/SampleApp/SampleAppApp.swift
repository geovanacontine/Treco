//
//  SampleAppApp.swift
//  SampleApp
//
//  Created by Pedro Contine on 02/03/22.
//

import SwiftUI
import Treco

@main
struct SampleAppApp: App {
    
    init() {
        TokensManager.shared.setTheme(fromJson: "tokens")
    }
    
    var body: some Scene {
        WindowGroup {
            ListView()
                .preferredColorScheme(.light)
        }
    }
}
