//
//  RekognitionImage.swift
//  AWSRekognitionDemo
//
//  Created by YUE CHEN on 24/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import UIKit
import RealmSwift

class RekognitionImage: Object {
    @objc dynamic var creationDate: Date = Date()
    @objc dynamic var imageData: Data?
    @objc dynamic var imageThumbnailData: Data?
    
    /**
    * Set image as Data in Realm RekognitionImage object.
    *
    * @param image the image to be stored
    */
    func setImage(image: UIImage) {
        imageData = image.jpegData(compressionQuality: 1.0)
        imageThumbnailData = image.thumbnailImage()?.jpegData(compressionQuality: 1.0)
    }
    
    /**
    * Get image from Data in Realm RekognitionImage object.
    *
    * @return image of RekognitionImage
    */
    func retrieveImage() -> UIImage? {
        guard let data = imageData else {
            return nil
        }
        return UIImage(data: data)
    }
    
    /**
    * Get thumbnail image from Data in Realm RekognitionImage object.
    *
    * @return image of RekognitionImage thumbnail
    */
    func retrieveThumbnailImage() -> UIImage? {
        guard let data = imageThumbnailData else {
            return nil
        }
        return UIImage(data: data)
    }
}



