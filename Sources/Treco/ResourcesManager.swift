//
//  ResourcesManager.swift
//  
//
//  Created by Pedro Contine on 03/06/22.
//

import Foundation
import UIKit

public struct ResourcesManager {

    public static  func configurePackageUI() {
        loadPackageFonts()
    }

    static func loadPackageFonts() {
    
        let fontNames = ["Montserrat-Bold.ttf",
                         "Montserrat-Light.ttf",
                         "Montserrat-Regular.ttf",
                         "Montserrat-SemiBold.ttf",
        ]
    
        fontNames.forEach{registerFont(fileName: $0)}
    }

    static func registerFont(fileName: String) {
        guard let gFontRef = getFont(named: fileName) else {
            print("*** ERROR: ***")
            return
    }
    
    var errorRef: Unmanaged<CFError>? = nil
        if !CTFontManagerRegisterGraphicsFont(gFontRef, &errorRef) {
            print("*** ERROR: \(errorRef.debugDescription) ***")
        }
    }

    static func getFont(named fileName: String) -> CGFont? {
        let url = Bundle.module.url(forResource: fileName, withExtension: nil)
        guard let gUrl = url,
              let gFontData = NSData(contentsOf: gUrl),
              let gDataProvider = CGDataProvider(data: gFontData),
              let gFontRef = CGFont(gDataProvider) else {
                print("*** ERROR: ***")
                return nil
    }
    
        return gFontRef
    }
}
