//
//  PhotoTableTests.swift
//  AWSRekognitionDemoTests
//
//  Created by YUE CHEN on 24/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import XCTest
import RealmSwift
@testable import AWSRekognitionDemo

class PhotoTableTests: XCTestCase {

    override func setUp() {
        Realm.resetAllObjects()
    }

    func testPhotoViewController() {
        let photoVC = PhotoTableViewController.instantiateFromStoryboard()
        photoVC.loadView()
        
        XCTAssertNotNil(photoVC.tableView)
        XCTAssertNotNil(photoVC.photoButton)
        XCTAssertNotNil(photoVC.sourcePhotoButton)
        XCTAssertNotNil(photoVC.compareButton)
        XCTAssertNotNil(photoVC.viewModel)
        XCTAssertNotNil(photoVC.disposeBag)
        
        XCTAssertEqual(photoVC.tableView.numberOfRows(inSection: 0), 0)
    }
    
    override func tearDown() {
        Realm.resetAllObjects()
    }
}
