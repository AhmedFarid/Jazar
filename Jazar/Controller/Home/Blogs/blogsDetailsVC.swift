//
//  blogsDetailsVC.swift
//  Jazar
//
//  Created by Ahmed farid on 8/4/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class blogsDetailsVC: UIViewController {
    
    @IBOutlet weak var imageBlog: UIImageView!
    @IBOutlet weak var titles: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    
    var singlItme: blogsData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(false)
        setUp()
    }
    
    func setUp(){
        
        titles.text = singlItme?.title
        desc.text = singlItme?.datumDescription?.html2String
        createdAt.text = singlItme?.createdAt
        
        let urlWithoutEncoding = (singlItme?.image ?? "")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        self.imageBlog.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            self.imageBlog.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
    
}
