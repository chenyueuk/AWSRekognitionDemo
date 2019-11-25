//
//  CameraSessionViewController+AVFoundation.swift
//  AWSRekognitionDemo
//
//  Created by YUE CHEN on 24/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import AVFoundation
import UIKit
import RealmSwift

extension CameraSessionViewController: AVCapturePhotoCaptureDelegate {
    
    func setupCameras() {
        availableCameras = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera],
                                                            mediaType: .video,
                                                            position: .unspecified).devices
        for device in availableCameras {
            if device.position == .back {
                backCamera = device
            } else if device.position == .front {
                frontCamera = device
            }
        }
    }
    
    func setupSession() {
        captureSession.beginConfiguration()
        
        for input in captureSession.inputs {
            captureSession.removeInput(input)
        }
        for output in captureSession.outputs {
            captureSession.removeOutput(output)
        }
        
        guard let detectedCamera = viewModel.useFrontCamera ? frontCamera : backCamera,
            let videoDeviceInput = try? AVCaptureDeviceInput(device: detectedCamera),
            captureSession.canAddInput(videoDeviceInput) else {
            NSLog("Error: failed to add camera input")
            return
        }
        captureSession.addInput(videoDeviceInput)
        
        let photoOutput = AVCapturePhotoOutput()
        guard captureSession.canAddOutput(photoOutput) else {
            NSLog("Error: failed to add camera output")
            return
        }
        captureSession.sessionPreset = .photo
        captureSession.addOutput(photoOutput)
        
        captureSession.commitConfiguration()
        rangeFinderView.videoPreviewLayer.session = self.captureSession
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation(),
            let image = UIImage(data: imageData)?.resizeImage(targetSize: CGSize(width: 900, height: 1200)) else {
            return
        }
        
        /// Store captured image to Realm
        viewModel.storeImageToRealm(image: image)
    }
}
