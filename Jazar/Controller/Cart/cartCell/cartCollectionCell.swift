//
//  cartCollectionCell.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/8/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class cartCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var newPrice: UILabel!
    @IBOutlet weak var productImage: imageViewCostom!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var shortDec: UILabel!
    @IBOutlet weak var qtn: UILabel!
    @IBOutlet weak var mainBtn: UIButton!
    @IBOutlet weak var totelCartPrice: UILabel!
    @IBOutlet weak var stockImage: UIImageView!
    @IBOutlet weak var stokeLb: UILabel!
    
    
    var add: (()->())?
    var min: (()->())?
    var deleteBtn: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(products: productsDataArray){
        
        stokeLb.rotate(degrees: 90)
        if products.stock == 0 {
            stockImage.isHidden = false
            stokeLb.text = "Out Of Stock"
        }else if products.stock ?? 0 <= 5 {
            stockImage.isHidden = false
            stockImage.image = UIImage(named: "Subtraction 20")
            let limitedQuantity = NSLocalizedString("Limited quantity", comment: "profuct list lang")
            stokeLb.text = limitedQuantity
        }else {
            stockImage.isHidden = true
            stokeLb.text = ""
        }
        let unitPrice = NSLocalizedString("Unit Price:", comment: "profuct list lang")
        newPrice.text = "\(unitPrice) \(products.total ?? 0) \(products.currency ?? "")"
        nameProduct.text = products.name
        shortDec.text = products.shortDescription
        qtn.text = "\(products.productInCartQty ?? 0)"
        let totalPrice = NSLocalizedString("Total Price:", comment: "profuct list lang")
        totelCartPrice.text = "\(totalPrice) \(products.productInCartTotal ?? 0) \(products.currency ?? "")"
        let urlWithoutEncoding = (products.image)
        let encodedLink = urlWithoutEncoding?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        productImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            productImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
    
    
    @IBAction func datletBtn(_ sender: Any) {
        deleteBtn?()
    }
    
    @IBAction func blusBtn(_ sender: Any) {
         add?()
    }
    
    @IBAction func mainBtn(_ sender: Any) {
        min?()
    }
}
