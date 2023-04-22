//
//  AppDelegate.swift
//  Final_Project_Notes_App
//
//  Created by Anastasia Neagu on 13.04.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    struct Constants {
        
//        static let appLaunchCountUserDefaultsKey = "appLaunchCountUserDefaultsKey"
        static let notesUserDefaultsKey = "notesUserDefaultsKey"
        
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        CoreDataManager.shared.load()
        
//
//        let standardUserDefaults = UserDefaults.standard
//
//        let key = "\(index)"
//
//        var notesArray = [(title: String, text : String)]()
//
//        if let existingArr = UserDefaults.standard.array(forKey: Constants.notesUserDefaultsKey) as? [(title: String, text : String)] {
//            notesArray = existingArr
//        }
//
//        if let currentCount = notesDict[key] {
//            notesDict[key] = currentCount + 1
//        }
//        else {
//            notesDict[key] = 1
//        }
        
//        UserDefaults.standard.set(notesArray, forKey: Constants.notesUserDefaultsKey)
        
        
//        let currentAppLaunchCount = standardUserDefaults.integer(forKey: Constants.appLaunchCountUserDefaultsKey)
//        standardUserDefaults.set(currentAppLaunchCount + 1, forKey: Constants.appLaunchCountUserDefaultsKey)
        
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

