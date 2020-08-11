//
//  SceneDelegate.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 6/30/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import MOLH

class SceneDelegate: UIResponder, UIWindowSceneDelegate,MOLHResetable {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window!.windowScene = windowScene
//        let navigationController = UINavigationController(rootViewController: homeVC())
//        window!.rootViewController = navigationController
//        print(helperAuth.getAPIToken() ?? "")
//        window!.makeKeyAndVisible()
        
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.windowScene = windowScene
        let tabBarController = UITabBarController()
        let homeTabVC = homeVC(nibName: "homeVC",bundle: nil)
        let newOffersTabVC = newOffersVC(nibName:"newOffersVC",bundle: nil)
        let deliveryTabVC = allCategoursVC(nibName:"allCategoursVC",bundle: nil)
        let cartTabVC = cartVC(nibName:"cartVC",bundle: nil)
        let myAcoutnTabVC = myAccountVC(nibName: "myAccountVC",bundle: nil)

        homeTabVC.tabBarItem = UITabBarItem(title: "",image: UIImage(named: "browser"), selectedImage: UIImage(named: "OnBrowser"))
        newOffersTabVC.tabBarItem = UITabBarItem(title: "",image:UIImage(named: "-e-Shape 4"),selectedImage: UIImage(named: "ON-e-Shape 4"))
        deliveryTabVC.tabBarItem = UITabBarItem(title: "",image: UIImage(named: "-e-Shape 6"),selectedImage: UIImage(named: "ON-e-Shape 6"))
        cartTabVC.tabBarItem = UITabBarItem(title: "",image:UIImage(named: "-e-Shape 5") ,selectedImage: UIImage(named: "On-e-Shape 5"))
        myAcoutnTabVC.tabBarItem = UITabBarItem(title: "",image:UIImage(named: "-e-Shape 7") ,selectedImage: UIImage(named: "-e-Shape 7ON"))
        let controllers = [homeTabVC,newOffersTabVC,cartTabVC,deliveryTabVC,myAcoutnTabVC].map {
            UINavigationController(rootViewController: $0)

        }
        tabBarController.tabBar.tintColor = #colorLiteral(red: 0.2235294118, green: 0.6705882353, blue: 0.3215686275, alpha: 1)
        tabBarController.tabBar.barTintColor = #colorLiteral(red: 0.9137254902, green: 0.9215686275, blue: 0.9333333333, alpha: 1)
        tabBarController.viewControllers = controllers

        window?.rootViewController = tabBarController
        window!.makeKeyAndVisible()
        
        guard let _ = (scene as? UIWindowScene) else { return }
        MOLH.shared.activate(true)
        MOLH.shared.specialKeyWords = ["Cancel","Done"]
        MOLH.setLanguageTo("ar")
        
    }
    
    func reset() {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.windowScene = windowScene
        let tabBarController = UITabBarController()
        let homeTabVC = homeVC(nibName: "homeVC",bundle: nil)
        let newOffersTabVC = newOffersVC(nibName:"newOffersVC",bundle: nil)
        let deliveryTabVC = allCategoursVC(nibName:"allCategoursVC",bundle: nil)
        let cartTabVC = cartVC(nibName:"cartVC",bundle: nil)
        let myAcoutnTabVC = myAccountVC(nibName: "myAccountVC",bundle: nil)

        homeTabVC.tabBarItem = UITabBarItem(title: "",image: UIImage(named: "browser"), selectedImage: UIImage(named: "OnBrowser"))
        newOffersTabVC.tabBarItem = UITabBarItem(title: "",image:UIImage(named: "-e-Shape 4"),selectedImage: UIImage(named: "ON-e-Shape 4"))
        deliveryTabVC.tabBarItem = UITabBarItem(title: "",image: UIImage(named: "-e-Shape 6"),selectedImage: UIImage(named: "ON-e-Shape 6"))
        cartTabVC.tabBarItem = UITabBarItem(title: "",image:UIImage(named: "-e-Shape 5") ,selectedImage: UIImage(named: "On-e-Shape 5"))
        myAcoutnTabVC.tabBarItem = UITabBarItem(title: "",image:UIImage(named: "-e-Shape 7") ,selectedImage: UIImage(named: "-e-Shape 7ON"))
        let controllers = [homeTabVC,newOffersTabVC,cartTabVC,deliveryTabVC,myAcoutnTabVC].map {
            UINavigationController(rootViewController: $0)

        }
        tabBarController.tabBar.tintColor = #colorLiteral(red: 0.2235294118, green: 0.6705882353, blue: 0.3215686275, alpha: 1)
        tabBarController.tabBar.barTintColor = #colorLiteral(red: 0.9137254902, green: 0.9215686275, blue: 0.9333333333, alpha: 1)
        tabBarController.viewControllers = controllers

        window?.rootViewController = tabBarController
        window!.makeKeyAndVisible()
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

