//
//  CameraSessionViewModel.swift
//  AWSRekognitionDemo
//
//  Created by YUE CHEN on 24/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import UIKit
import RealmSwift

struct CameraSessionViewModel {
    enum SessionType {
        case takeSourcePhoto, takeTargetPhoto
    }
    
    var sessionType: SessionType = .takeSourcePhoto
    var useFrontCamera = true
    var photoData: Results<RekognitionCellData>
    
    /**
    * Init view model, set photoData to Realm query collection
    */
    init() {
        photoData = Realm.defaultRealmInstance()
            .objects(RekognitionCellData.self)
            .sorted(byKeyPath: "creationDate", ascending: false)
    }
    
    /**
    * Save captured photo into RealmDB.
    *
    * @param image captured
    */
    func storeImageToRealm(image: UIImage) {
        if sessionType == .takeSourcePhoto {
            Realm.updateSourcePhotoImage(image: image)
        } else {
            let baseImage = RekognitionImage()
            baseImage.setImage(image: image)
            let newCellData = RekognitionCellData(baseImage: baseImage)
            newCellData.storeToRealm()
        }
    }
}
