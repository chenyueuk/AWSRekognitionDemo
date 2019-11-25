//
//  RekognitionCellData.swift
//  AWSRekognitionDemo
//
//  Created by YUE CHEN on 24/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import UIKit
import RealmSwift

class RekognitionCellData: Object {
    @objc dynamic var creationDate: Date = Date()
    @objc dynamic var baseImage: RekognitionImage?
    @objc dynamic var resultImage: RekognitionImage?
    
    /**
    * Initializer for RekognitionCellData.
    *
    * @param baseImage for Rekognition service
    */
    convenience init(baseImage: RekognitionImage) {
        self.init()
        self.baseImage = baseImage
    }
    
    /**
    * Save current instance to RealmDB.
    */
    func storeToRealm() {
        try? Realm.defaultRealmInstance().write {
            Realm.defaultRealmInstance().add(self)
        }
    }
}
