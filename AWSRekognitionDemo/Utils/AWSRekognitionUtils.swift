//
//  AWSRekognitionUtils.swift
//  AWSRekognitionDemo
//
//  Created by YUE CHEN on 25/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import AWSRekognition

struct AWSRekognitionUtils {
    static let compressionQuality: CGFloat = 0.5
    static let similarityThreshold = NSNumber(floatLiteral: 80.0)
    
    let sourceImage: UIImage
    let targetImage: UIImage
    
    let rekognitionObject = AWSRekognition.default()
    let compareRequest: AWSRekognitionCompareFacesRequest! = AWSRekognitionCompareFacesRequest()

    let requestSourceImage = AWSRekognitionImage()
    let requestTargetImage = AWSRekognitionImage()
    
    init(sourceImage: UIImage, targetImage: UIImage) {
        self.sourceImage = sourceImage
        self.targetImage = targetImage
        requestSourceImage?.bytes = sourceImage.jpegData(compressionQuality: AWSRekognitionUtils.compressionQuality)
        requestTargetImage?.bytes = targetImage.jpegData(compressionQuality: AWSRekognitionUtils.compressionQuality)
        compareRequest.sourceImage = requestSourceImage
        compareRequest.targetImage = requestTargetImage
        compareRequest.similarityThreshold = AWSRekognitionUtils.similarityThreshold
    }
    
    func compareFaces(onCompletion: @escaping ([CGRect])->Void) {
        rekognitionObject.compareFaces(compareRequest, completionHandler: { response, error in
            guard let faceResponse = response, error == nil else {
                return
            }
            let matchingRects = self.findMatchingFaceRects(faceResponse: faceResponse, in: self.targetImage)
            onCompletion(matchingRects)
        })
    }
    
    fileprivate func findMatchingFaceRects(faceResponse: AWSRekognitionCompareFacesResponse, in image: UIImage) -> [CGRect] {
        var matchedFaces: [AWSRekognitionCompareFacesMatch]  = []
        
        if let responseMatches = faceResponse.faceMatches {
            matchedFaces = responseMatches
        }
        
        return matchedFaces.map { face in
            return getCGRect(from: face.face?.boundingBox, image: image) ?? CGRect.zero
        }
    }
    
    private func getCGRect(from boundingBox: AWSRekognitionBoundingBox?, image: UIImage) -> CGRect? {
        if let boundingBox = boundingBox,
            let boundingX = boundingBox.left?.doubleValue,
            let boundingY = boundingBox.top?.doubleValue,
            let boundingWidth = boundingBox.width?.doubleValue,
            let boundingHeight = boundingBox.height?.doubleValue{
            return CGRect(x: CGFloat(boundingX) * image.size.width,
                          y: CGFloat(boundingY) * image.size.height,
                          width: CGFloat(boundingWidth) * image.size.width,
                          height: CGFloat(boundingHeight) * image.size.height)
        }
        return nil
    }
}
