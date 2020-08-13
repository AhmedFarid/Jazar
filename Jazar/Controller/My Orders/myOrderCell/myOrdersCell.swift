//
//  myOrdersCell.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import MOLH

class myOrdersCell: UICollectionViewCell {

    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var orderTotalLabel: UILabel!
    @IBOutlet weak var orderQntyLabel: UILabel!
    @IBOutlet weak var orderStatusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configureCell(products: myOrdersData){
        let orderId = NSLocalizedString("Order Id:", comment: "profuct list lang")
        orderIdLabel.text = "\(orderId) \(products.id ?? 0)"
        let totalPrice = NSLocalizedString("Total Price:", comment: "profuct list lang")
        orderTotalLabel.text = "\(totalPrice) \(products.total ?? 0) \(products.orderDetails?.first?.currency ?? "")"
        let orderQuantity = NSLocalizedString("Order Quantity:", comment: "profuct list lang")
        orderQntyLabel.text = "\(orderQuantity) \(products.orderDetails?.count ?? 0)"
        orderDateLabel.text = products.createdAt
        orderStatusLabel.text = products.status
        
        if products.status == "pendding"{
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                orderStatusLabel.text = "قيد الانتظار"
            }
        }else if products.status == "inShipment" {
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                orderStatusLabel.text = "في الطريق"
            }
        }else if products.status == "onDelivery" {
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                orderStatusLabel.text = "قيد التحضير"
            }
        }else if products.status == "completed" {
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                orderStatusLabel.text = "تم التواصل"
            }
        }else if products.status == "canceled" {
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                orderStatusLabel.text = "ألغيت"
            }
        }else if products.status == "paymentDone" {
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                orderStatusLabel.text = "تم الدفع"
            }
        }
    }
    
}
