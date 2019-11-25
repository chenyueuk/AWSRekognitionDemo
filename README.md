# AWSRekognitionDemo

## Abstract
This is a demo project to use AWSRekognition service. It can compare faces in two pictures. Find matching face in source photo from the faces in targeting photo.

## Requirement
Device: please run on a iOS device with Cameras, which can be an iPad, iPod or iPhone.
iOS version: 13.2 or above.

## Install
This project uses cocoapods to manage the dependencies, make sure to run 'pod install' before using the project.

## How to use
### Main view controller
There are 2 areas which displays photo:
1. Top area displays 'Source photo'.
2. Middle area is a table view which displays 'Target photos'.
![main view]()

There are 4 buttons in this view controller:
1. 'Capture souce' button which presents a camera view controller allow user to take and update 'Source photo'.
2. 'Capture targe' button which presents a camera view controller allow user to take and update 'Target photos'.
3. 'Reset' button which clears all user 'Source photo' and 'Target photos', and load with a 'Test image set'.
4. 'Find face matches' button which calls AWS Rekognition service and draw bounding boxes around matching and unmatching faces if there is any.

### Camera session
There are two types of Camera session:
1. 'Capture souce' which allows user to capture and update 'Source photo'. This session does NOT have result preview.
2. 'Capture target' which allows user to capture and update 'Target photos'. This session have a result preview collection view, which allows user to see what has been captured in the 'Target photos'.

There are three buttonsin the camera session:
1. 'Flip camera' button which allows user to flip front/back camera.
2. 'Capture' button which captures photo and store it into Realm.
3. 'Done' button which dismisses the camera view.

## License
This project is on MIT open source license.
