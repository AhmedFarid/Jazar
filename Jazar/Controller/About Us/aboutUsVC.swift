//
//  aboutUsVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/14/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class aboutUsVC: UIViewController,NVActivityIndicatorViewable {

    @IBOutlet weak var imageAbout: UIImageView!
    @IBOutlet weak var titles: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    var pageName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(false)
        setUpView(pageName: pageName)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setUpNavColore(true)
    }
    
    func setUpView(pageName: String) {
        loaderHelper()
        aboutUsApi.aboutUsApi(pageName: pageName) { (errore, success, abouts) in
            if success {
                self.titles.text = abouts?.data?.title?.html2String ?? ""
                self.desc.text = abouts?.data?.dataDescription?.html2String ?? ""
                let urlWithoutEncoding = (abouts?.data?.image ?? "")
                let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
                let encodedURL = NSURL(string: encodedLink!)! as URL
                self.imageAbout.kf.indicatorType = .activity
                if let url = URL(string: "\(encodedURL)") {
                    self.imageAbout.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
                }
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
}
