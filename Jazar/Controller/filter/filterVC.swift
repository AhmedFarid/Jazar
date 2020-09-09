//
//  filterVC.swift
//  Jazar
//
//  Created by Ahmed farid on 9/3/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//


protocol getFilter {
    func getFilterData(highestPrice: String,lowestPrice: String,inCart: String,inFav: String,linitedQty: String,new: String,Best: String)
}

import UIKit

class filterVC: UIViewController {
    
    @IBOutlet weak var highestPriceBtn: UIButton!
    @IBOutlet weak var lowestPriceBtn: UIButton!
    @IBOutlet weak var inCartBtn: UIButton!
    @IBOutlet weak var inFavBtn: UIButton!
    @IBOutlet weak var linitedQtyBtn: UIButton!
    @IBOutlet weak var newBtn: UIButton!
    @IBOutlet weak var BestBtn: UIButton!
    
    var highestPrice = ""
    var lowestPrice = ""
    var inCart = ""
    var inFav = ""
    var linitedQty = ""
    var new = ""
    var Best = ""
    
    var delegate: getFilter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func highestPriceBtnAction(_ sender: Any) {
        if highestPrice == "" {
            highestPrice = "true"
            self.highestPriceBtn.setImage(UIImage(named: "Group 1597"), for: .normal)
        }else if highestPrice == "true" {
            highestPrice = ""
            self.highestPriceBtn.setImage(UIImage(named: "NoGroup 1597"), for: .normal)
        }
    }
    @IBAction func lowestPriceBtnAction(_ sender: Any) {
        if lowestPrice == "" {
            lowestPrice = "true"
            self.lowestPriceBtn.setImage(UIImage(named: "Group 1597"), for: .normal)
        }else if lowestPrice == "true" {
            lowestPrice = ""
            self.lowestPriceBtn.setImage(UIImage(named: "NoGroup 1597"), for: .normal)
        }
        
    }
    @IBAction func inCartBtnAction(_ sender: Any) {
        if inCart == "" {
            inCart = "true"
            self.inCartBtn.setImage(UIImage(named: "Group 1597"), for: .normal)
        }else if inCart == "true" {
            inCart = ""
            self.inCartBtn.setImage(UIImage(named: "NoGroup 1597"), for: .normal)
        }
    }
    @IBAction func inFavBtnAction(_ sender: Any) {
        if inFav == "" {
            inFav = "true"
            self.inFavBtn.setImage(UIImage(named: "Group 1597"), for: .normal)
        }else if inFav == "true" {
            inFav = ""
            self.inFavBtn.setImage(UIImage(named: "NoGroup 1597"), for: .normal)
        }
    }
    @IBAction func linitedQtyBtnAction(_ sender: Any) {
        if linitedQty == "" {
            linitedQty = "true"
            self.linitedQtyBtn.setImage(UIImage(named: "Group 1597"), for: .normal)
        }else if linitedQty == "true" {
            linitedQty = ""
            self.linitedQtyBtn.setImage(UIImage(named: "NoGroup 1597"), for: .normal)
        }
    }
    @IBAction func newBtnAction(_ sender: Any) {
        if new == "" {
            new = "true"
            self.newBtn.setImage(UIImage(named: "Group 1597"), for: .normal)
        }else if new == "true" {
            new = ""
            self.newBtn.setImage(UIImage(named: "NoGroup 1597"), for: .normal)
        }
        
    }
    @IBAction func BestBtnAction(_ sender: Any) {
        if Best == "" {
            Best = "true"
            self.BestBtn.setImage(UIImage(named: "Group 1597"), for: .normal)
        }else if Best == "true" {
            Best = ""
            self.BestBtn.setImage(UIImage(named: "NoGroup 1597"), for: .normal)
        }
    }
    
    
    
    
    @IBAction func closeBtn(_ sender: Any) {
        
          dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func filterBtnAction(_ sender: Any) {
        delegate?.getFilterData(highestPrice: highestPrice,lowestPrice: lowestPrice,inCart: inCart,inFav: inFav,linitedQty: linitedQty,new: new,Best: Best)
         dismiss(animated: true, completion: nil)
        
    }
    
}
