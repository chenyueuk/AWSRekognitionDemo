//
//  CameraSessionViewController.swift
//  AWSRekognitionDemo
//
//  Created by YUE CHEN on 24/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import UIKit
import AVFoundation
import RxSwift
import RxCocoa

class CameraSessionViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var rangeFinderView: PreviewView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flipCameraButton: UIButton!
    
    var captureSession: AVCaptureSession = AVCaptureSession()
    var frontCamera: AVCaptureDevice?
    var backCamera: AVCaptureDevice?
    var availableCameras: [AVCaptureDevice] = []
    
    var viewModel = CameraSessionViewModel()
    fileprivate let disposeBag = DisposeBag()
    
    /**
    * Create a view controller instance from storyboard
    *
    * @return new CameraSessionViewController instance
    */
    static func instantiateFromStoryboard() -> CameraSessionViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CameraSessionViewController") as! CameraSessionViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.isHidden = viewModel.useFrontCamera
        setupCameras()
        setupSession()
        bindToData()
        bindDoneButton()
        bindCaptureButton()
        bindFlipCameraButton()
        captureSession.startRunning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        captureSession.stopRunning()
        super.viewWillAppear(animated)
    }
    
    /**
    * Bind and observe UICollectionView's data to photoData in viewModel
    */
    fileprivate func bindToData() {
        Observable.collection(from: viewModel.photoData)
            .bind(to: collectionView.rx.items(cellIdentifier: "PhotoCollectionViewCell", cellType: UICollectionViewCell.self)) { (row, element, cell) in
            cell.backgroundView = UIImageView(image: element.baseImage?.retrieveImage())
        }.disposed(by: disposeBag)
    }
    
    fileprivate func bindDoneButton() {
        doneButton.rx.tap.bind { [unowned self] in
            self.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
    
    /**
    * Bind capture button event, when button tapped, fire a AVCapture output call
    */
    fileprivate func bindCaptureButton() {
        captureButton.rx.tap.bind { [unowned self] in
            let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
            if self.captureSession.outputs.count > 0,
                let output = self.captureSession.outputs[0] as? AVCapturePhotoOutput {
                output.capturePhoto(with: settings, delegate: self)
            }
        }.disposed(by: disposeBag)
    }
    
    fileprivate func bindFlipCameraButton() {
        flipCameraButton.rx.tap.bind { [unowned self] in
            self.captureSession.stopRunning()
            self.viewModel.useFrontCamera = !self.viewModel.useFrontCamera
            self.setupSession()
            self.captureSession.startRunning()
        }.disposed(by: disposeBag)
    }
}

class PreviewView: UIView {
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    /// Convenience wrapper to get layer as its statically known type.
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
}
