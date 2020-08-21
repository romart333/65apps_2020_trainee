//
//  SceneDelegate.swift
//  1
//
//  Created by Роман Копылов on 17.08.2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import UIKit
@available(iOS 13,*)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        // Комментирвоать одну из этих строк!!
        //let (vc, labelText) = initMainVCFromXib()
        let (vc, labelText)  = initMainVCFromCode()
        //
        if let view = vc.view {
            view.backgroundColor = .white
            
            let width: CGFloat = 200
            let heigth: CGFloat = 25
            let label = UILabel(frame: CGRect(x: view.frame.midX - width / 2, y: view.frame.midY, width: width, height: heigth))
            label.text = labelText
            view.addSubview(label)
            
            window.rootViewController = vc
            window.makeKeyAndVisible()
            self.window = window
        }
    }
    
    func initMainVCFromXib() -> (mainVC: MainViewController, labelText: String) {
        return (MainViewController(), "Init from xib for ios 13")
    }
    
    func initMainVCFromCode() -> (mainVC: MainViewController, labelText: String) {
        return (MainViewController(nibName: "MainView", bundle: nil), "Init from code for ios 13")
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has mViewoved from an inactive state to an active state.
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

