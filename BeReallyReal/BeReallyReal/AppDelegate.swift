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
        
        // Define a Parse Object
        struct GameScore: ParseObject {
            var originalData: Data?

            // Required fields
            var objectId: String?
            var createdAt: Date?
            var updatedAt: Date?
            var ACL: ParseACL?

            // Custom fields
            var score: Int?
            var playerName: String?
            var cheatMode: Bool?
        }

        // Save a test object
        Task {
            var gameScore = GameScore()
            gameScore.score = 5000
            gameScore.playerName = "Kingsley 🐶"
            gameScore.cheatMode = true

            do {
                try await gameScore.save()
                print("👩‍🔬✅ SUCCESS! Parse object saved")
            } catch {
                print("👩‍🔬❌ Error saving Parse object: \(error)")
            }
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

