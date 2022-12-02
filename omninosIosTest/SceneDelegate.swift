//
//  SceneDelegate.swift
//  omninosIosTest
//
//  Created by Prince 2.O on 29/11/22.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        FirebaseManager.checkAuthState {
            // User is Logged In
            guard let addTaskVC = storyboard.instantiateViewController(withIdentifier: String(describing: TasksVC.self)) as? TasksVC else {
                debugPrint("TasksVC Not Found")
                return
            }
            self.window?.rootViewController = addTaskVC
            self.window?.makeKeyAndVisible()
        } loggedOut: {
            // User is Logged Out
            guard let loginVC = storyboard.instantiateViewController(withIdentifier: String(describing: LogInVC.self)) as? LogInVC else {
                debugPrint("LogInVC Not Found")
                return
            }
            let navController = storyboard.instantiateInitialViewController() as! UINavigationController
            navController.setViewControllers([loginVC], animated: true)
            self.window?.rootViewController = navController as UIViewController
            self.window?.makeKeyAndVisible()
        }
    }
}

func sceneDidDisconnect(_ scene: UIScene) {
    
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




