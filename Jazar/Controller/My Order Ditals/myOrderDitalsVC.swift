//
//  myOrderDitalsVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class myOrderDitalsVC: UIViewController {
    
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var orderQuntetyLabel: UILabel!
    @IBOutlet weak var orderTotalLabel: UILabel!
    @IBOutlet weak var promoCodeLabel: UILabel!
    @IBOutlet weak var promoValus: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var procutesCollectionView: UICollectionView!
    @IBOutlet weak var hightConst: NSLayoutConstraint!
    @IBOutlet weak var imageStatus: UIImageView!
    @IBOutlet weak var cityDelviery: UILabel!
    @IBOutlet weak var statusDelviery: UILabel!
    @IBOutlet weak var pointsCity: UILabel!
    @IBOutlet weak var delvieyPrice: UILabel!
    @IBOutlet weak var typreOrder: UILabel!
    
    var singelItem: myOrdersData?
    var products = [productsDataArray]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavColore(false)
        self.hightConst.constant = CGFloat(self.products.count * 316)
        setUpData()
    }
    
    
    
    func setUpData() {
        self.procutesCollectionView.register(UINib.init(nibName: "allProductViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        procutesCollectionView.delegate = self
        procutesCollectionView.dataSource = self
        
        let typeDelivery = NSLocalizedString("Type Delivery:", comment: "profuct list lang")
        typreOrder.text = "\(typeDelivery) \(singelItem?.typeDelivery ?? "")"
        let City = NSLocalizedString("City:", comment: "profuct list lang")
        cityDelviery.text = "\(City) \(singelItem?.city ?? "")"
        let Region = NSLocalizedString("Region:", comment: "profuct list lang")
        statusDelviery.text = "\(Region) \(singelItem?.customerRegion ?? "")"
        let receivePoints = NSLocalizedString("Receive Points:", comment: "profuct list lang")
        pointsCity.text = "\(receivePoints) \(singelItem?.receivePoints ?? "")"
        let deliveryFees = NSLocalizedString("Receive Points:", comment: "profuct list lang")
        delvieyPrice.text = "\(deliveryFees) \(singelItem?.deliveryFees ?? 0)"
        let orderId = NSLocalizedString("Order Id:", comment: "profuct list lang")
        orderIdLabel.text = "\(orderId) \(singelItem?.id ?? 0)"
        let orderQuantity = NSLocalizedString("Order Quantity:", comment: "profuct list lang")
        orderQuntetyLabel.text = "\(orderQuantity) \(singelItem?.orderDetails?.count ?? 0)"
        let orderPrice = NSLocalizedString("Order Price:", comment: "profuct list lang")
        orderTotalLabel.text = "\(orderPrice) \(singelItem?.total ?? 0) \(singelItem?.orderDetails?.first?.currency ?? "")"
        orderDateLabel.text = singelItem?.createdAt
        
        orderStatus.text = singelItem?.status ?? ""
        
        if singelItem?.promocodeValue == 0{
            let noPromoCode = NSLocalizedString("No Promo Code", comment: "profuct list lang")
            promoCodeLabel.text = noPromoCode
            let promoValue = NSLocalizedString("Promo Value:", comment: "profuct list lang")
            promoValus.text = "\(promoValue) 0\(singelItem?.orderDetails?.first?.currency ?? "")"
        }else {
            let promoCode = NSLocalizedString("Promo Code:", comment: "profuct list lang")
            promoCodeLabel.text = "\(promoCode) \(singelItem?.promocode ?? "")"
            let promoValue = NSLocalizedString("Promo Value:", comment: "profuct list lang")
            promoValus.text = "\(promoValue) \(singelItem?.promocodeValue ?? 0) \(singelItem?.orderDetails?.first?.currency ?? "")"
        }
        
        name.text = singelItem?.customerName ?? ""
        phone.text = singelItem?.customerPhone ?? ""
        addressLabel.text = singelItem?.customerAddress ?? ""
        
        if singelItem?.status == "pendding" || singelItem?.status == "inShipment" {
            imageStatus.image = UIImage(named: "Group 1590")
        }else if singelItem?.status == "onDelivery" || singelItem?.status == "On arrival" {
            imageStatus.image = UIImage(named: "Group 15950")
        }else if singelItem?.status == "completed" {
            imageStatus.image = UIImage(named: "Group 159500")
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension myOrderDitalsVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = productDetailsVC(nibName: "productDetailsVC", bundle: nil)
        vc.singleItem = products[indexPath.row]
        vc.images = products[indexPath.row].productImages ?? []
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = procutesCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? allProductViewCell {
            cell.configureCell(products: products[indexPath.row])
            return cell
        }else {
            return allProductViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: procutesCollectionView.frame.size.width, height: 300)
        
    }
}
