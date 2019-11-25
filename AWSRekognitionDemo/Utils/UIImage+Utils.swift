//
//  UIImage+Utils.swift
//  AWSRekognitionDemo
//
//  Created by YUE CHEN on 24/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import UIKit

extension UIImage {
    
    /**
    * Draw a rectangle on the UIImage.
    *
    * @param rect the bounding frame for the rect to be drawn.
    */
    func drawBoundingRect(rect: CGRect, color: UIColor) -> UIImage {
        let imageSize = self.size
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(imageSize, false, scale)
        self.draw(at: CGPoint.zero)
        
        color.set()
        let path = UIBezierPath(rect: rect)
        path.lineWidth = (self.size.height * 0.02)
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        path.stroke()

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
    
    func drawRects(rects: [CGRect], color: UIColor) -> UIImage {
        var result = self
        for rect in rects {
            result = result.drawBoundingRect(rect: rect, color: color)
        }
        return result
    }
    
    /**
    * Create a thumbnail image for the current UIImage.
    *
    * @param targetSize to be resized.
    * @return UIImage of the result thumbnail.
    */
    func resizeImage(targetSize: CGSize) -> UIImage? {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /**
    * Create a thumbnail image for the current UIImage.
    *
    * @return UIImage of the result thumbnail.
    */
    func thumbnailImage() -> UIImage? {
        let thumbnailSize = CGSize(width: 480, height: 720)
        return resizeImage(targetSize: thumbnailSize)
    }
}
