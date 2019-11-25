//
//  AppDelegate.swift
//  AWSRekognitionDemo
//
//  Created by YUE CHEN on 24/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import UIKit
import RealmSwift
import AWSCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Init unauth AWS connection
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: .EUWest1,
                                                                identityPoolId: "eu-west-1:19f78919-6315-4d1a-bc60-6058a4ca6433")
        let configuration = AWSServiceConfiguration(region: .EUWest1,
                                                    credentialsProvider:credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        // Default Realm instance should not be nil, if nil found, the app should enter failure state.
        guard let _ = try? Realm() else {
            assertionFailure("Unexpected nil Realm instance, please try re-install app or call migrate function")
            return false
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

