//
//  myOrderDitalsVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import MOLH
import MapKit

class myOrderDitalsVC: UIViewController {
    
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var orderQuntetyLabel: UILabel!
    @IBOutlet weak var orderTotalLabel: UILabel!
    @IBOutlet weak var promoValus: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var procutesCollectionView: UICollectionView!
    @IBOutlet weak var hightConst: NSLayoutConstraint!
    @IBOutlet weak var imageStatus: UIImageView!
    @IBOutlet weak var cityDelviery: UILabel!
    @IBOutlet weak var statusDelviery: UILabel!
    @IBOutlet weak var typreOrder: UILabel!
    @IBOutlet var mapView: MKMapView!
    
    
    var singelItem: myOrdersData?
    var products = [productsDataArray]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        centerMapOnLocation(location: homeLocation)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavColore(false)
        self.hightConst.constant = CGFloat(self.products.count * 320)
        setUpData()
    }
    
    
    let homeLocation = CLLocation(latitude: 31.210370, longitude: 31.634919)
    let regionRadius: CLLocationDistance = 200
    func centerMapOnLocation(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    func setUpData() {
        self.procutesCollectionView.register(UINib.init(nibName: "allProductViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        procutesCollectionView.delegate = self
        procutesCollectionView.dataSource = self
        
        let typeDelivery = NSLocalizedString("Type Delivery:", comment: "profuct list lang")
        typreOrder.text = "\(typeDelivery) \(singelItem?.typeDelivery ?? "")"
        if singelItem?.typeDelivery == "Schedule" {
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                typreOrder.text = "\(typeDelivery) مجمع"
            }
        }else {
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                typreOrder.text = "\(typeDelivery) سريع"
            }
        }
        let City = NSLocalizedString("City:", comment: "profuct list lang")
        cityDelviery.text = "\(City) \(singelItem?.city ?? "")"
        let Region = NSLocalizedString("Region:", comment: "profuct list lang")
        statusDelviery.text = "\(Region) \(singelItem?.customerRegion ?? "")"
        //let receivePoints = NSLocalizedString("Receive Points:", comment: "profuct list lang")
        //pointsCity.text = "\(receivePoints) \(singelItem?.receivePoints ?? "")"
        //let deliveryFees = NSLocalizedString("Delivery Fees:", comment: "profuct list lang")
        //delvieyPrice.text = "\(deliveryFees) \(singelItem?.deliveryFees ?? 0)"
        let orderId = NSLocalizedString("Order Id:", comment: "profuct list lang")
        orderIdLabel.text = "\(orderId) \(singelItem?.id ?? 0)"
        let orderQuantity = NSLocalizedString("Order Quantity:", comment: "profuct list lang")
        orderQuntetyLabel.text = "\(orderQuantity) \(singelItem?.orderDetails?.count ?? 0)"
        let orderPrice = NSLocalizedString("Order Price:", comment: "profuct list lang")
        orderTotalLabel.text = "\(orderPrice) \(singelItem?.total ?? 0) \(singelItem?.orderDetails?.first?.currency ?? "")"
        orderDateLabel.text = singelItem?.createdAt
        
        orderStatus.text = singelItem?.status ?? ""
        
        if singelItem?.status == "pendding"{
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                orderStatus.text = "تحت الطلب"
            }
        }else if singelItem?.status == "inShipment" {
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                orderStatus.text = "جاري التحضير"
            }
        }else if singelItem?.status == "onDelivery" {
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                orderStatus.text = "في الطريق"
            }
        }else if singelItem?.status == "On arrival" {
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                orderStatus.text = "علي وشك الوصول"
            }
        }
        else if singelItem?.status == "completed" {
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                orderStatus.text = "تم الاستلام"
            }
        }else if singelItem?.status == "canceled" {
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                orderStatus.text = "تم الغاء الطلب"
            }
        }else if singelItem?.status == "paymentDone" {
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                orderStatus.text = "تم الدفع"
            }
        }
        
        if singelItem?.promocodeValue == 0{
            //let noPromoCode = NSLocalizedString("No Promo Code", comment: "profuct list lang")
            //promoCodeLabel.text = noPromoCode
            let promoValue = NSLocalizedString("Promo Value:", comment: "profuct list lang")
            promoValus.text = "\(promoValue) 0\(singelItem?.orderDetails?.first?.currency ?? "")"
        }else {
            //let promoCode = NSLocalizedString("Promo Code:", comment: "profuct list lang")
            //promoCodeLabel.text = "\(promoCode) \(singelItem?.promocode ?? "")"
            let promoValue = NSLocalizedString("Promo Value:", comment: "profuct list lang")
            promoValus.text = "\(promoValue) \(singelItem?.promocodeValue ?? 0) \(singelItem?.orderDetails?.first?.currency ?? "")"
        }
        
        name.text = singelItem?.customerName ?? ""
//        phone.text = singelItem?.customerPhone ?? ""
//        addressLabel.text = singelItem?.customerAddress ?? ""
//        
        if singelItem?.status == "pendding"  {
            imageStatus.image = UIImage(named: "Group 1646")
        }else if singelItem?.status == "inShipment" {
            imageStatus.image = UIImage(named: "Group 1647")
        }else if singelItem?.status == "On arrival" {
            imageStatus.image = UIImage(named: "Group 1649")
        }else if singelItem?.status == "onDelivery" {
            imageStatus.image = UIImage(named: "Group 1648")
        }else if singelItem?.status == "completed" {
            imageStatus.image = UIImage(named: "Group 1650")
        }else if singelItem?.status == "canceled" {
            imageStatus.image = UIImage(named: "canceld")
        }else if singelItem?.status == "paymentDone" {
            imageStatus.image = UIImage(named: "Group 1650")
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
        return CGSize(width: procutesCollectionView.frame.size.width, height: 320)
        
    }
}
