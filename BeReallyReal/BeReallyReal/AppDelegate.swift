//
//  AppDelegate.swift
//  BeReallyReal
//
//  Created by Trust-Worthy on 9/29/25.
//

import UIKit
import ParseSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    // main entry point to swift project: did Finish Launch With options
    // this is where services are configured: Parse , Firebase , etc
    // setup dependency injection
    // initialize app-wide state
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        // Initialize ParseSwift & Back4app
        if let appID = Bundle.main.object(forInfoDictionaryKey: "BACK4APP_APP_ID") as? String,
           let clientKey = Bundle.main.object(forInfoDictionaryKey: "BACK4APP_CLIENT_KEY") as? String {
            
            ParseSwift.initialize(
                applicationId: appID,
                clientKey: clientKey,
                serverURL: URL(string: "https://parseapi.back4app.com")!
            )
        } else {
            print("Missing Back4App credentials in Info.plist")
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

