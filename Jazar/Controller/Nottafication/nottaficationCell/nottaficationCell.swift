//
//  nottaficationCell.swift
//  Jazar
//
//  Created by Ahmed farid on 8/27/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class nottaficationCell: UITableViewCell {

    @IBOutlet weak var dateLb: UILabel!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var decLb: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   func configureCell(products: nottaficationData){
    dateLb.text = products.date
    decLb.text = products.datumDescription
    titleLb.text = products.name
      
   }
    
}
