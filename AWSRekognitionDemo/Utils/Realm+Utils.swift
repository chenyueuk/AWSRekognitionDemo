//
//  Realm+Utils.swift
//  AWSRekognitionDemo
//
//  Created by YUE CHEN on 24/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    
    static var sourcePhotoUUID = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
    
    /**
    * Resets all objects in the default Realm instance
    */
    static func resetAllObjects() {
        let cellData = defaultRealmInstance().objects(RekognitionCellData.self)
        
        try? defaultRealmInstance().write {
            defaultRealmInstance().delete(cellData)
            sourcePhotoData().imageData = nil
            sourcePhotoData().imageThumbnailData = nil
        }
    }
    
    /**
    * Returns the default realm instance, nil Realm object should be captured in the AppDelegate didFinishLaunchingWithOptions method
    */
    static func defaultRealmInstance() -> Realm {
        return try! Realm()
    }
    
    static func sourcePhotoData() -> SourcePhotoData {
        if let sourcePhoto = defaultRealmInstance().object(ofType: SourcePhotoData.self,
                                                           forPrimaryKey: sourcePhotoUUID) {
            return sourcePhoto
        }
        let newSourcePhoto = SourcePhotoData(uuid: sourcePhotoUUID)
        try? defaultRealmInstance().write {
            defaultRealmInstance().add(newSourcePhoto)
        }
        return newSourcePhoto
    }
    
    static func updateSourcePhotoImage(image: UIImage) {
        DispatchQueue.main.async {
            try? defaultRealmInstance().write {
                sourcePhotoData().setImage(image: image)
            }
        }
    }
    
    static func createSampleData() {
        // create mock
        let image1 = UIImage(named: "TestImage1") ?? UIImage()
        let image2 = UIImage(named: "TestImage2") ?? UIImage()
        let image3 = UIImage(named: "TestImage3") ?? UIImage()
        let rekogImage1 = RekognitionImage()
        rekogImage1.setImage(image: image1)
        let rekogImage2 = RekognitionImage()
        rekogImage2.setImage(image: image2)
        let rekogImage3 = RekognitionImage()
        rekogImage3.setImage(image: image3)
        
        let rekogData2 = RekognitionCellData(baseImage: rekogImage2)
        let rekogData3 = RekognitionCellData(baseImage: rekogImage3)
        
        try? defaultRealmInstance().write {
            sourcePhotoData().setImage(image: image1)
        }
        rekogData2.storeToRealm()
        rekogData3.storeToRealm()
    }
}
