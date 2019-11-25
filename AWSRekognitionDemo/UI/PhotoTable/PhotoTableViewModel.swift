//
//  PhotoTableViewModel.swift
//  AWSRekognitionDemo
//
//  Created by YUE CHEN on 24/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import Foundation
import RealmSwift
import RxRealm
import RxSwift
import RxCocoa

class PhotoTableViewModel {
    var photoData: Results<RekognitionCellData>
    var sourcePhoto: BehaviorRelay<SourcePhotoData> = BehaviorRelay(value: Realm.sourcePhotoData())
    var awsRekognitionProcessCount = 0
    
    /**
    * Init view model, set photoData to Realm query collection
    */
    init() {
        photoData = Realm.defaultRealmInstance()
            .objects(RekognitionCellData.self)
            .sorted(byKeyPath: "creationDate", ascending: false)
    }
    
    /**
    * Compare face using AWS service. Find source face in all target photoes
    */
    func compareFaces() {
        for data in photoData {
            awsRekognitionProcessCount += 1
            guard let sourceImage = Realm.sourcePhotoData().retrieveImage(),
                let targetImage = data.baseImage?.retrieveImage() else {
                return
            }
            
            let awsUtil = AWSRekognitionUtils(sourceImage: sourceImage,
                                              targetImage: targetImage)
            awsUtil.compareFaces(onCompletion: { (matchingRects, unmatchingRects)  in
                self.awsRekognitionProcessCount -= 1
                DispatchQueue.main.async {
                    var resultImage = targetImage
                    resultImage = resultImage.drawRects(rects: matchingRects, color: .yellow)
                    resultImage = resultImage.drawRects(rects: unmatchingRects, color: .red)
                    
                    try? Realm.defaultRealmInstance().write {
                        let newImage = RekognitionImage()
                        newImage.setImage(image: resultImage)
                        data.resultImage = newImage
                    }
                }
            })
        }
    }
}
