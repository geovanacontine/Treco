//
//  UITextField+Extensions.swift
//  PhotosApp
//
//  Created by Pedro Contine on 21/01/22.
//

import UIKit

public extension UITextField {
    func addDoneButtonToKeyboard(title: String) {
        let size = CGSize(width: frame.width, height: Spacing.lg.value)
        let doneToolbar = UIToolbar(frame: .init(origin: .zero, size: size))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let done = UIBarButtonItem(title: title, style: .done, target: self, action: #selector(didTapKeyboardDoneButton))
        
        let font = UIFont.init(style: .title2)
        
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.foregroundColor: UIColor.brandPure]
        done.setTitleTextAttributes(attributes, for: .normal)
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        inputAccessoryView = doneToolbar
    }
    
    @objc func didTapKeyboardDoneButton() {
        resignFirstResponder()
    }
}
