//
//  ModelTests.swift
//  AWSRekognitionDemoTests
//
//  Created by YUE CHEN on 24/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import XCTest
import RealmSwift
@testable import AWSRekognitionDemo

class ModelTests: XCTestCase {

    var rekognitionImage = RekognitionImage()
    let testImage1 = UIImage(named: "TestImage1") ?? UIImage()
    
    override func setUp() {
        Realm.resetAllObjects()
    }
    
    func testUIImageStorage() {
        XCTAssertNil(rekognitionImage.retrieveImage())
        rekognitionImage.setImage(image: testImage1)
        let storedImage = rekognitionImage.retrieveImage()
        let storedThumbnail = rekognitionImage.retrieveThumbnailImage()
        XCTAssertNotNil(storedImage)
        XCTAssertNotNil(storedThumbnail)
        XCTAssertEqual(storedImage!.size, testImage1.size)
    }
    
    func testRekognitioinCellData() {
        rekognitionImage.setImage(image: testImage1)
        let cellData = RekognitionCellData(baseImage: rekognitionImage)
        XCTAssertNotNil(cellData)
        XCTAssertEqual(cellData.baseImage, rekognitionImage)
        XCTAssertNotNil(cellData.creationDate)
        XCTAssertNil(cellData.resultImage)
    }
    
    func testCellDataStore() {
        let cellDataCollection = Realm.defaultRealmInstance().objects(RekognitionCellData.self)
        XCTAssertEqual(cellDataCollection.count, 0)
        
        rekognitionImage.setImage(image: testImage1)
        let cellData = RekognitionCellData(baseImage: rekognitionImage)
        cellData.storeToRealm()
        XCTAssertEqual(cellDataCollection.count, 1)
    }
    
    override func tearDown() {
        Realm.resetAllObjects()
    }
}
