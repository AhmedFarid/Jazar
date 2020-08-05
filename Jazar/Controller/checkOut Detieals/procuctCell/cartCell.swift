//
//  cartCell.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/19/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class cartCells: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var qtnLB: UILabel!
    @IBOutlet weak var unitProduct: UILabel!
    @IBOutlet weak var totalPirce: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(products: productsDataArray){
        productName.text = products.name
        let Quantity = NSLocalizedString("Quantity", comment: "profuct list lang")
        qtnLB.text = "\(Quantity) \(products.productInCartQty ?? 0)"
        let totalPrice = NSLocalizedString("Total Price", comment: "profuct list lang")
        totalPirce.text = "\(totalPrice) \(products.productInCartTotal ?? 0) \(products.currency ?? "")"
        let Price = NSLocalizedString("Price", comment: "profuct list lang")
        unitProduct.text = "\(Price) \(products.total ?? 0) \(products.currency ?? "")"
    }
    
}
