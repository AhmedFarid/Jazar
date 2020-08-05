//
//  blogsCell.swift
//  Jazar
//
//  Created by Ahmed farid on 8/4/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class blogsCell: UICollectionViewCell {
    
    @IBOutlet weak var blogDate: UILabel!
    @IBOutlet weak var blogImage: imageViewCostom!
    @IBOutlet weak var blogTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(blogs: blogsData){
        blogDate.text = blogs.createdAt
        blogTitle.text = blogs.title
        let urlWithoutEncoding = (blogs.image)
        let encodedLink = urlWithoutEncoding?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        blogImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            blogImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
}


