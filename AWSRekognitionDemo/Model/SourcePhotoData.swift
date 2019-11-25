//
//  SourcePhotoData.swift
//  AWSRekognitionDemo
//
//  Created by YUE CHEN on 24/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import UIKit
import RealmSwift

class SourcePhotoData: RekognitionImage {
    @objc dynamic var uuid = UUID().uuidString
    
    /**
    * Initializer for SourcePhotoData.
    *
    * @param baseImage for Rekognition service
    */
    convenience init(uuid: String) {
        self.init()
        self.uuid = uuid
    }
    
    /**
    * Set primary key for this object class.
    */
    override static func primaryKey() -> String? {
        return "uuid"
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
