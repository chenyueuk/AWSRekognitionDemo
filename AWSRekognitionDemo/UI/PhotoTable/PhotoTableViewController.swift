//
//  PhotoTableViewController.swift
//  AWSRekognitionDemo
//
//  Created by YUE CHEN on 24/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa
import RxRealm

class PhotoTableViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sourcePhotoButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var compareButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var sourcePhotoImageView: UIImageView!
    
    var viewModel = PhotoTableViewModel()
    let disposeBag = DisposeBag()
    
    /**
    * Create a view controller instance from storyboard
    *
    * @return new PhotoTableViewController instance
    */
    static func instantiateFromStoryboard() -> PhotoTableViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoTableViewController") as! PhotoTableViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToData()
        bindSourcePhotoButton()
        bindPhotoButton()
        bindCompareButton()
        bindSourcePhotoImageView()
        bindResetButton()
    }

    /**
    * Bind and observe UITableView's data to photoData in viewModel
    */
    fileprivate func bindToData() {
        Observable.collection(from: viewModel.photoData)
            .bind(to: tableView.rx.items(cellIdentifier: "PhotoTableViewCell", cellType: PhotoTableViewCell.self)) { (row, element, cell) in
                cell.basePhoto.image = element.baseImage?.retrieveThumbnailImage()
                cell.processedPhoto.image = element.resultImage?.retrieveThumbnailImage()
        }.disposed(by: disposeBag)
    }
    
    fileprivate func bindSourcePhotoImageView() {
        Observable.from(object: Realm.sourcePhotoData()).map { sourcePhoto -> UIImage? in
            return sourcePhoto.retrieveImage()
        }.bind(to: sourcePhotoImageView.rx.image).disposed(by: disposeBag)
    }
    
    fileprivate func bindSourcePhotoButton() {
        sourcePhotoButton.rx.tap.bind {
            /// present camera view controller with default settings (sourcePhoto)
            let cameraVC = CameraSessionViewController.instantiateFromStoryboard()
            cameraVC.modalPresentationStyle = .fullScreen
            self.present(cameraVC, animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
    
    fileprivate func bindPhotoButton() {
        photoButton.rx.tap.bind {
            /// present camera view controller with back camera (take photo)
            let cameraVC = CameraSessionViewController.instantiateFromStoryboard()
            cameraVC.modalPresentationStyle = .fullScreen
            cameraVC.viewModel.useFrontCamera = false
            cameraVC.viewModel.sessionType = .takeTargetPhoto
            self.present(cameraVC, animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
    
    fileprivate func bindResetButton() {
        resetButton.rx.tap.bind {
            Realm.resetAllObjects()
            Realm.createSampleData()
        }.disposed(by: disposeBag)
    }
    
    fileprivate func bindCompareButton() {
        compareButton.rx.tap.bind { [unowned self] in
            self.viewModel.compareFaces()
        }.disposed(by: disposeBag)
    }
}
