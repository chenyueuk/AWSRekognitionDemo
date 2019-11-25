//
//  CameraSessionTests.swift
//  AWSRekognitionDemoTests
//
//  Created by YUE CHEN on 24/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import XCTest
import RealmSwift
@testable import AWSRekognitionDemo

class CameraSessionTests: XCTestCase {

    let cameraVC = CameraSessionViewController.instantiateFromStoryboard()
    
    override func setUp() {
        Realm.resetAllObjects()
    }

    override func tearDown() {
        Realm.resetAllObjects()
    }

    func testViewModel() {
        XCTAssertTrue(cameraVC.viewModel.useFrontCamera)
        XCTAssertEqual(cameraVC.viewModel.photoData.count, 0)
    }
}
