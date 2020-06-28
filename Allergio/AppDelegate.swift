//
//  AppDelegate.swift
//  Allergio
//
//  Created by Bill Xiang on 6/11/20.
//  Copyright © 2020 billx. All rights reserved.
//

import UIKit
import Firebase
import Clarifai_Apple_SDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        let APIKey = "0b0df1b5e7e14c02ab2328113c88a87f"

        if APIKey == "<Your API Key>" {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "NO API Key FOUND", message: "Add API Key and re-install", preferredStyle: .alert)
                self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
            return true
        }

        Clarifai.sharedInstance().start(apiKey: APIKey)
        
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

