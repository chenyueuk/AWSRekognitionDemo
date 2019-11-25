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
        let imageWithRect = testImage1?.drawBoundingRect(rect: CGRect(x: 10, y: 10, width: 10, height: 10), color: .black)
        XCTAssertNotNil(testImage1)
        XCTAssertNotNil(imageWithRect)
        XCTAssertNotEqual(testImage1, imageWithRect)
    }
    
    func testThumbnail() {
        let thumbnail = testImage1?.thumbnailImage()
        XCTAssertNotNil(thumbnail)
        XCTAssertLessThanOrEqual(thumbnail?.size.width ?? 481, 480)
        XCTAssertLessThanOrEqual(thumbnail?.size.height ?? 721, 720)
    }
}
