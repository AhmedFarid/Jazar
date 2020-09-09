//
//  checkoutDetiealsVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/19/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class checkoutDetiealsVC: UIViewController,NVActivityIndicatorViewable {

    @IBOutlet weak var typeTF: UILabel!
    @IBOutlet weak var addressTF: UILabel!
    @IBOutlet weak var floorNumberTF: UILabel!
    @IBOutlet weak var homeNumberTF: UILabel!
    @IBOutlet weak var streetTF: UILabel!
    @IBOutlet weak var regionTF: UILabel!
    @IBOutlet weak var deliveryTF: UILabel!
    @IBOutlet weak var cityTF: UILabel!
    @IBOutlet weak var phoneTF: UILabel!
    @IBOutlet weak var fullNameTF: UILabel!
    @IBOutlet weak var prodctTabelView: UITableView!
    
    var products = [productsDataArray]()
    
    var address = ""
    var type = ""
    var floorNumber = ""
    var homeNumber = ""
    var street = ""
    var region = ""
    var cityId = ""
    var phone = ""
    var fullName = ""
    var promoCode = ""
    var giftId = ""
    var delivery_type = ""
    var cityName = ""
    var regionId = 0
    var receivePointsId = "0"
    var typeDelivery = ""
    var noteTF = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prodctTabelView.register(UINib(nibName: "cartCellCheckOut", bundle: nil), forCellReuseIdentifier: "cell")
        prodctTabelView.delegate = self
        prodctTabelView.dataSource = self
        setUpNavColore(false)
        setupData()

    }
    
    func setupData() {
        typeTF.text = "\(type)"
        addressTF.text = "\(address)"
        floorNumberTF.text = "\(floorNumber)"
        homeNumberTF.text = "\(homeNumber)"
        streetTF.text = "\(street)"
        regionTF.text = "\(region)"
        //let delivery = NSLocalizedString("delivery", comment: "profuct list lang")
        deliveryTF.text = "\(delivery_type)"
        cityTF.text = "\(cityName)"
        phoneTF.text = "\(phone)"
        fullNameTF.text = "\(fullName)"
    }
    
   
    
    func order() {
        loaderHelper()
        var type = ""
        if delivery_type == "fast_price" {
            type = "fast"
        }else {
            type = "slow"
        }
         
        
        checkOutApi.makeOrderApi(state_id: regionId, receive_points_id: receivePointsId, type_delivery: typeDelivery,delivery_type: type,city_id: cityId,gift_id:giftId, code: promoCode, customer_name: fullName, customer_phone: phone, customer_city: cityName, customer_region: region, customer_street: street, customer_home_number: homeNumber, customer_floor_number: floorNumber, customer_address: address, payment_method: "cacheOnDelivery"){ (error, success, message) in
                    if success {
                        if message?.success == true {
                            self.stopAnimating()
                            let vc = orderVC(nibName: "orderVC", bundle: nil)
                            vc.orderId = message?.data?.orderid ?? 0
                            vc.modalPresentationStyle = .custom
                            self.present(vc,animated: true)
                        }else {
                            let title = NSLocalizedString("Order", comment: "profuct list lang")
                            self.showAlert(title: title, message: message?.message ?? "")
                            self.stopAnimating()
                        }
                    }else {
                        let title = NSLocalizedString("Order", comment: "profuct list lang")
                        self.showAlert(title: title, message: "Check your network")
                        self.stopAnimating()
                    }
                }
    }

    @IBAction func orderBtn(_ sender: Any) {
        order()
    }
    
}

extension checkoutDetiealsVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = prodctTabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? cartCells {
            cell.configureCell(products: products[indexPath.row])
            return cell
        }else {
            return cartCells()
        }
    }
}
