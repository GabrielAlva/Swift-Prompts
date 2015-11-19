//
//  ImageSizer.swift
//  Swift-Prompts
//
//  Created by Marc Stroebel on 2015/11/19.
//  Copyright © 2015 Gabriel Alvarado. All rights reserved.
//

import UIKit

extension UIImage {

    func calculateImageSizeForConstraints(maximumWidth: CGFloat, maximumHeight: CGFloat) -> CGSize {
        let aspectRatio = self.size.height / self.size.width
        var imageSize = self.size
        
        // Try fit to the maximum width first if needed
        if imageSize.width > maximumWidth {
            imageSize.width = maximumWidth
            imageSize.height = imageSize.width * aspectRatio
        }
        
        // Otherwise react to the height limitation
        if imageSize.height > maximumHeight {
            imageSize.height = maximumHeight
            imageSize.width = imageSize.height / aspectRatio
        }
        
        return  imageSize
    }
}
