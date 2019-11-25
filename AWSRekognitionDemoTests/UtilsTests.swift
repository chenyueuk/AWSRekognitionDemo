//
//  UtilsTests.swift
//  AWSRekognitionDemoTests
//
//  Created by YUE CHEN on 24/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import XCTest
import RealmSwift
@testable import AWSRekognitionDemo

class UtilsTests: XCTestCase {
    let testImage1 = UIImage(named: "TestImage1")

    func testImageRectDraw() {
        let imageWithRect = testImage1?.drawBoundingRect(rect: CGRect(x: 10, y: 10, width: 10, height: 10))
        XCTAssertNotNil(testImage1)
        XCTAssertNotNil(imageWithRect)
        XCTAssertNotEqual(testImage1, imageWithRect)
    }
    
    func testThumbnail() {
        let thumbnail = testImage1?.thumbnailImage()
        XCTAssertNotNil(thumbnail)
        XCTAssertEqual(thumbnail?.size.width, 480)
        XCTAssertEqual(thumbnail?.size.height, 720)
    }
}
