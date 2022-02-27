//
//  UIImage+Extensions.swift
//  Treco
//
//  Created by Pedro Contine on 03/01/22.
//

import UIKit

public extension UIImage {
    func getCroppedImage() -> UIImage? {
        guard let cropRect = makeCropRect(),
              let imageRef = cgImage?.cropping(to: cropRect) else {
            return nil
        }
        
        return UIImage(cgImage: imageRef, scale: 0, orientation: imageOrientation)
    }
    
    private func makeCropRect() -> CGRect? {
        guard let cgImage = cgImage else {
            return nil
        }
        
        let sideLength = min(size.width, size.height)
        let size = CGSize(width: sideLength, height: sideLength)

        let refWidth: CGFloat = CGFloat(cgImage.width)
        let refHeight: CGFloat = CGFloat(cgImage.height)

        let xOffset = (refWidth - size.width) / 2
        let yOffset = (refHeight - size.height) / 2

        return .init(x: xOffset, y: yOffset, width: size.height, height: size.width)
    }
}
