//
//  orderVC.swift
//  Jazar
//
//  Created by Ahmed farid on 8/23/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class orderVC: UIViewController {

    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var text: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(true)
        let message = NSLocalizedString("Thanks For Your Order", comment: "profuct list lang")
        text.text = message
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap(_:))))
        popView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapPop(_:))))
    }
    
    //helperAuth.restartApp()
    @objc func onTap(_ sender:UIPanGestureRecognizer) {
           helperAuth.restartApp()

       }
       
       @objc func onTapPop(_ sender:UIPanGestureRecognizer) {
           helperAuth.restartApp()

       }

}
