//
//  AppDelegate.swift
//  1
//
//  Created by Роман Копылов on 17.08.2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 13.0, *) {
            print("ios 13")
        } else {
            let window = UIWindow(frame: UIScreen.main.bounds)
            let mainViewController = MainViewController()
            
            if let view = mainViewController.view {
                let label = UILabel(frame: CGRect(x: view.frame.midX - 300, y: view.frame.midY, width: 200, height: 10))
                label.text = "Init form code for ios lower than 13"
                view.addSubview(label)
            }
            
            window.rootViewController = mainViewController
            window.makeKeyAndVisible()
            self.window = window
            
        }
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13,*)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13,*)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

