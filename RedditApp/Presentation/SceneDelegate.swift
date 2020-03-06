//
//  SceneDelegate.swift
//  RedditApp
//
//  Created by Manuel Munoz on 03/03/2020.
//  Copyright © 2020 Manuel Munoz. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var dependencies: AppDependencies {
        UIApplication.dependencies
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        var rootVC: UIViewController
//        if dependencies.userDefaultsHandler.accessToken != nil {
//            rootVC = PostsViewController.instantiate(storyboard: .main)
//        } else {
            rootVC = LoginViewController.instantiate(storyboard: .auth)
//        }
        window.rootViewController = rootVC
        self.window = window
        window.makeKeyAndVisible()
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

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        print("Called!")
        let redditRedirect = URLContexts.first { $0.url.absoluteString.starts(with: "memapp") }
        
        guard let url = redditRedirect?.url else { return }
        
        dependencies.redditOAuthHandler.handleRedirectURL(url)
        
//        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
//        guard let code = components?.queryItems?.first (where: { $0.name == "code" })?.value else { return }
//
//        dependencies.redditRepository.login(code: code, redirectURI: RedditOAuthHandler.redirectURI) { [unowned self] result in
//            switch result {
//            case .success(let response):
//                self.dependencies.userDefaultsHandler.accessToken = response.accessToken
//                self.dependencies.userDefaultsHandler.refreshToken = response.refreshToken
//
//                self.window?.rootViewController = PostsViewController.instantiate(storyboard: .main)
//            case .failure:
//                break
//            }
//        }
    }
}

