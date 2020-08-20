//
//  SceneDelegate.swift
//  2
//
//  Created by Роман Капылов on 09/08/2020.
//  Copyright © 2020 Роман Капылов. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
        let mainStoryvoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryvoard.instantiateViewController(identifier: "VC") as! ViewController
        if let url = URLContexts.first?.url.absoluteString {
            
            guard let queryItem = URLComponents(string: url)?.queryItems?.first else { return }
            switch queryItem.name {
            case "text":
                guard let text = queryItem.value else { break }
                vc.setAppLaunchMode(mode: .showText(text: text))
            case "url":
                guard let stringURL = queryItem.value, let url = URL(string: stringURL) else { break }
                vc.setAppLaunchMode(mode: .openURL(url: url))
            case "image":
                vc.setAppLaunchMode(mode: .showImage)
            default:
                print("There is no one appropriate query item name")
                break
            }
            
        }
        window?.rootViewController = vc
      
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

