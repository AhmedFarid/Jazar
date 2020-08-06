//
//  navHerlper.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 6/30/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//
import UIKit
import SideMenu

extension UIViewController {
    
    
    func refesHcart() {
        homeApi.productsApi(url: URLs.carts, pageName: 1, product_id: 0,category_id: "", subcategory_id: "",name: ""){ (error,success,products) in
            if products?.success == true {
                if products?.data?.data?.count == 0 {
                    if let tabItems = self.tabBarController?.tabBar.items {
                        // In this case we want to modify the badge number of the third tab:
                        let tabItem = tabItems[2]
                        //self.tabBarController?.tabBar.items![2].badgeColor = #colorLiteral(red: 0.2235294118, green: 0.6705882353, blue: 0.3215686275, alpha: 1)
                        tabItem.badgeValue = nil
                    }
                }else {
                    if let tabItems = self.tabBarController?.tabBar.items {
                        // In this case we want to modify the badge number of the third tab:
                        let tabItem = tabItems[2]
                        self.tabBarController?.tabBar.items![2].badgeColor = #colorLiteral(red: 0.2235294118, green: 0.6705882353, blue: 0.3215686275, alpha: 1)
                        tabItem.badgeValue = "\(products?.data?.data?.count ?? 0)"
                    }
                    //self.addBadge(count: products?.data?.data?.count ?? 0)
                }
            }else {
            }
        }
    }
    
    
    func setUpNavColore(_ isTranslucent: Bool){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2248471975, green: 0.6689562201, blue: 0.3207116127, alpha: 1)
        self.navigationItem.title = "Jazar"
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let textAttributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        refesHcart()
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "-e-Shape 8"), style: .done, target: self, action: #selector(notfiaction))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func notfiaction() {
        
    }
    
    
}

extension AppDelegate {
    func hideBackButton() {
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        BarButtonItemAppearance.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -200, vertical: -5), for:UIBarMetrics.default)
    }
    
}

