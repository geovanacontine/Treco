//
//  AppDelegate.swift
//  SampleApp
//
//  Created by Pedro Contine on 16/02/22.
//

import UIKit
import Treco

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let appTokens = decodeTokens()
        TokensManager.shared.loadTokens(appTokens)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate {
    private func decodeTokens() -> [String: String] {
        let url = Bundle.main.url(forResource: "tokens", withExtension: "json")!
        let data = (try? Data(contentsOf: url)) ?? Data()
        let decoder = JSONDecoder()
        let jsonData = try? decoder.decode([String: String].self, from: data)
        return jsonData ?? [:]
    }
}
