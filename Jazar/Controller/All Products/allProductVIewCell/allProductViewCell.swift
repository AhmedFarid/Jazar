//
//  allProductViewCell.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/7/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import Cosmos

class allProductViewCell: UICollectionViewCell {

    @IBOutlet weak var stockImage: UIImageView!
    @IBOutlet weak var stokeLb: UILabel!
    @IBOutlet weak var reviews: CosmosView!
        @IBOutlet weak var newPrice: UILabel!
        @IBOutlet weak var productImage: imageViewCostom!
        @IBOutlet weak var discountPrice: UILabel!
        @IBOutlet weak var cartBtn: UIButton!
        @IBOutlet weak var favBtn: UIButton!
        @IBOutlet weak var nameProduct: UILabel!
        @IBOutlet weak var shortDec: UILabel!
    @IBOutlet weak var type: UILabel!
    
        var addFav: (()->())?
    var addCart: (()->())?
    
        override func awakeFromNib() {
            super.awakeFromNib()
        }
        
        func configureCell(products: productsDataArray){
            stokeLb.rotate(degrees: 90)
            if products.stock == 0 {
                stockImage.isHidden = false
                let outOfStock = NSLocalizedString("Out Of Stock", comment: "profuct list lang")
                stokeLb.text = "\(outOfStock)"
            }else if products.stock ?? 0 <= 5 {
                stockImage.isHidden = false
                stockImage.image = UIImage(named: "Subtraction 20")
                let limitedQuantity = NSLocalizedString("Limited quantity", comment: "profuct list lang")
                stokeLb.text = limitedQuantity
            }else {
                stockImage.isHidden = true
                stokeLb.text = ""
            }
            type.text = "\(products.unitValue ?? 0) \(products.unit ?? "")"
            nameProduct.text = products.name
            shortDec.text = products.shortDescription
            reviews.rating = Double(products.totalRate ?? 0)
            reviews.text = "(\(products.totalNumberReview ?? 0))"
            
            if products.salePrice == 0 {
                discountPrice.isHidden = true
            }else {
                discountPrice.isHidden = false
            }
            newPrice.text = "\(products.total ?? 0) \(products.currency ?? "")"
            discountPrice.text = "\(products.salePrice ?? 0) \(products.currency ?? "")"
            discountPrice.strikeThrough(true)
            if helperAuth.getAPIToken() == nil {
                cartBtn.isHidden = true
                favBtn.isHidden = true
            }else {
                cartBtn.isHidden = false
                favBtn.isHidden = false
                if products.productInCart == 1 {
                    cartBtn.setImage(UIImage(named: "onCart"), for: .normal)
                }else {
                    cartBtn.setImage(UIImage(named: "NoCart"), for: .normal)
                }
                if products.isProductFavoirte == 1 {
                    favBtn.setImage(UIImage(named: "Group 1503"), for: .normal)
                }else {
                    favBtn.setImage(UIImage(named: "NoFave"), for: .normal)
                }
            }
            let urlWithoutEncoding = (products.image)
            let encodedLink = urlWithoutEncoding?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
            let encodedURL = NSURL(string: encodedLink!)! as URL
            productImage.kf.indicatorType = .activity
            if let url = URL(string: "\(encodedURL)") {
                productImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
            }
        }
        
        
        
        @IBAction func cartBtnAction(_ sender: Any) {
            addCart?()
        }
        
        @IBAction func favBtnAction(_ sender: Any) {
            addFav?()
        }
    }



extension UILabel {
    func rotate(degrees: CGFloat) {
        rotate(radians: CGFloat.pi * degrees / 180.0)
    }

    func rotate(radians: CGFloat) {
        self.transform = CGAffineTransform(rotationAngle: radians)
    }
}
