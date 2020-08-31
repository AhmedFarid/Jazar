//
//  helperAuth.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import UIKit

class helperAuth: NSObject {
    
    class func restartApp(){
    guard let window = UIApplication.shared.keyWindow else {return}
    if getAPIToken() == nil {
        let tabBarController = UITabBarController()
        let homeTabVC = homeVC(nibName: "homeVC",bundle: nil)
        let newOffersTabVC = newOffersVC(nibName:"newOffersVC",bundle: nil)
        let deliveryTabVC = allCategoursVC(nibName:"allCategoursVC",bundle: nil)
        let cartTabVC = cartVC(nibName:"cartVC",bundle: nil)
        let myAcoutnTabVC = myAccountVC(nibName: "myAccountVC",bundle: nil)

        homeTabVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Home", comment: "profuct list lang"),image: UIImage(named: "123"), selectedImage: UIImage(named: "final copy-1"))
        newOffersTabVC.tabBarItem = UITabBarItem(title: NSLocalizedString("New Offers", comment: "profuct list lang"),image:UIImage(named: "sale-1"),selectedImage: UIImage(named: "sale"))
        deliveryTabVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Categories", comment: "profuct list lang"),image: UIImage(named: "fruit-3"),selectedImage: UIImage(named: "fruit-2"))
        cartTabVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Cart", comment: "profuct list lang"),image:UIImage(named: "Group 1656") ,selectedImage: UIImage(named: "Group 1654"))
        myAcoutnTabVC.tabBarItem = UITabBarItem(title: NSLocalizedString("My Account", comment: "profuct list lang"),image:UIImage(named: "person") ,selectedImage: UIImage(named: "Group 1657"))
        let controllers = [homeTabVC,newOffersTabVC,cartTabVC,deliveryTabVC,myAcoutnTabVC].map {
            UINavigationController(rootViewController: $0)

        }
        tabBarController.tabBar.tintColor = #colorLiteral(red: 0.2235294118, green: 0.6705882353, blue: 0.3215686275, alpha: 1)
        tabBarController.tabBar.barTintColor = #colorLiteral(red: 0.9137254902, green: 0.9215686275, blue: 0.9333333333, alpha: 1)
        tabBarController.tabBar.unselectedItemTintColor = UIColor.black
        tabBarController.viewControllers = controllers
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Cairo-Regular", size: 10)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Cairo-SemiBold", size: 10)!], for: .selected)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()

    }else {
        let tabBarController = UITabBarController()
        let homeTabVC = homeVC(nibName: "homeVC",bundle: nil)
        let newOffersTabVC = newOffersVC(nibName:"newOffersVC",bundle: nil)
        let deliveryTabVC = allCategoursVC(nibName:"allCategoursVC",bundle: nil)
        let cartTabVC = cartVC(nibName:"cartVC",bundle: nil)
        let myAcoutnTabVC = myAccountVC(nibName: "myAccountVC",bundle: nil)

       homeTabVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Home", comment: "profuct list lang"),image: UIImage(named: "123"), selectedImage: UIImage(named: "final copy-1"))
        newOffersTabVC.tabBarItem = UITabBarItem(title: NSLocalizedString("New Offers", comment: "profuct list lang"),image:UIImage(named: "sale-1"),selectedImage: UIImage(named: "sale"))
        deliveryTabVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Categories", comment: "profuct list lang"),image: UIImage(named: "fruit-3"),selectedImage: UIImage(named: "fruit-2"))
        cartTabVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Cart", comment: "profuct list lang"),image:UIImage(named: "Group 1656") ,selectedImage: UIImage(named: "Group 1654"))
        myAcoutnTabVC.tabBarItem = UITabBarItem(title: NSLocalizedString("My Account", comment: "profuct list lang"),image:UIImage(named: "person") ,selectedImage: UIImage(named: "Group 1657"))
        let controllers = [homeTabVC,newOffersTabVC,cartTabVC,deliveryTabVC,myAcoutnTabVC].map {
            UINavigationController(rootViewController: $0)

        }
        tabBarController.tabBar.tintColor = #colorLiteral(red: 0.2235294118, green: 0.6705882353, blue: 0.3215686275, alpha: 1)
        tabBarController.tabBar.barTintColor = #colorLiteral(red: 0.9137254902, green: 0.9215686275, blue: 0.9333333333, alpha: 1)
        tabBarController.tabBar.unselectedItemTintColor = UIColor.black
        tabBarController.viewControllers = controllers
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Cairo-Regular", size: 10)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Cairo-SemiBold", size: 10)!], for: .selected)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    UIView.transition(with: window, duration: 0.0, options: .transitionFlipFromTop, animations: nil, completion: nil)
}

    
    class func dleteAPIToken() {
        let def = UserDefaults.standard
        def.removeObject(forKey: "user_token")
        def.synchronize()
        restartApp()
        
        
    }
    
    class func saveAPIToken(token: String) {
        let def = UserDefaults.standard
        def.setValue(token, forKey: "user_token")
        def.synchronize()
        
        
    }
    
    class func getAPIToken() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "user_token") as? String
    }
    
}
