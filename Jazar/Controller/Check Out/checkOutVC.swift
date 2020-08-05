//
//  checkOutVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class checkOutVC: UIViewController,NVActivityIndicatorViewable {
    
    var delviers = [cityData]()
    var status = [cityData]()
    var points = [dataTiming]()

    var deleveryType = [NSLocalizedString("Immediatelu Delivery within 30 minutes", comment: "profuct list lang"),NSLocalizedString("Schedule", comment: "profuct list lang")]
    
    
    @IBOutlet weak var promoCodeTF: textFieldView!
    @IBOutlet weak var countCats: UILabel!
    @IBOutlet weak var fullNameTF: textFieldView!
    @IBOutlet weak var phoneTF: textFieldView!
    @IBOutlet weak var cityTF: textFieldView!
    @IBOutlet weak var regionTF: textFieldView!
    @IBOutlet weak var streetTF: textFieldView!
    @IBOutlet weak var homeNumberTF: textFieldView!
    @IBOutlet weak var floorNumTF: textFieldView!
    @IBOutlet weak var delviryType: textFieldView!
    @IBOutlet weak var addressTF: textFieldView!
    @IBOutlet weak var timingTF: textFieldView!
    @IBOutlet weak var timinImage: UIImageView!
    @IBOutlet weak var timingVIew: UIView!
    @IBOutlet weak var deliveryPrice: UILabel!
    @IBOutlet weak var allTotalPrice: UILabel!
    @IBOutlet weak var subTotalPrice: UILabel!
    @IBOutlet weak var promoValues: UILabel!
    
    
    var totlaPrice = 0
    var countCart = 0
    var curancy = ""
    var promo = 0
    var delveryTotal = 0
    var promoText = ""
    var cityId = 0
    var regionId = 0
    var receivePointsId = ""
    var typeDelivery = ""
    var slow = 0
    var fast = 0
    var products = [productsDataArray]()
    var type = ""
    var delvertyTypes = ""
    var tex = 0
    var promoNext = ""
    var deliveryPrices = 0
    var ciytDrvly = 0
    
    let cityPicker = UIPickerView()
    let delviryStatePicker = UIPickerView()
    let delviryTypePicker = UIPickerView()
    let timingPicker = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(false)
        cityTF.isEnabled = false
        regionTF.isEnabled = false
        self.timingTF.isEnabled = false
        timingTF.isHidden = true
        timinImage.isHidden = true
        timingVIew.isHidden = true
        
        let Item = NSLocalizedString("Item", comment: "profuct list lang")
        self.countCats.text = "\(countCart) \(Item)"
        let LE = NSLocalizedString("LE", comment: "profuct list lang")
        self.deliveryPrice.text = "\(deliveryPrices) \(LE)"
        self.allTotalPrice.text = "\(totlaPrice + deliveryPrices) \(LE)"
        self.subTotalPrice.text = "\(totlaPrice) \(LE)"
        cityPikerFunc()
        delviryTypeFunc()
    }
    
    func cityPikerFunc() {
        cityPicker.delegate = self
        cityPicker.dataSource = self
        cityTF.inputView = cityPicker
        loaderHelper()
        checkOutApi.getCitys{ (error,success,delviers) in
            if let delviers = delviers{
                self.delviers = delviers.data ?? []
                print(delviers)
                self.cityTF.isEnabled = true
                self.cityPicker.reloadAllComponents()
                self.stopAnimating()
            }
        }
    }
    
    func timingPikerFunc() {
        timingPicker.delegate = self
        timingPicker.dataSource = self
        timingTF.inputView = timingPicker
        loaderHelper()
        checkOutApi.getReceivepoints(city_id: 0){ (error,success,points) in
            if let points = points{
                self.points = points.data ?? []
                print(points)
                self.timingTF.isEnabled = true
                self.timingPicker.reloadAllComponents()
                self.stopAnimating()
            }
        }
    }
    
    func delviryTypeFunc() {
        delviryTypePicker.delegate = self
        delviryTypePicker.dataSource = self
        delviryType.inputView = delviryTypePicker
        self.delviryTypePicker.reloadAllComponents()
        
    }
    
    func delviryStatePikerFunc(id:Int) {
        delviryStatePicker.delegate = self
        delviryStatePicker.dataSource = self
        regionTF.inputView = delviryStatePicker
        loaderHelper()
        checkOutApi.getStates(city_id: id){ (error,success,status) in
            if let status = status{
                self.status = status.data ?? []
                print(status)
                if self.status.count != 0 {
                    self.regionTF.isEnabled = true
                }
                self.delviryStatePicker.reloadAllComponents()
                self.stopAnimating()
            }
        }
    }
    
    func promoCodeCheck() {
        loaderHelper()
        checkOutApi.getPromocode(code: promoCodeTF.text ?? "") { (error, success, message,errorCode) in
            if success {
                if message?.success == true {
                    self.promoNext = self.promoCodeTF.text ?? ""
                    let title = NSLocalizedString("Promo Code", comment: "profuct list lang")
                    let messages = NSLocalizedString("You have Discount", comment: "profuct list lang")
                    self.showAlert(title: title, message: "\(messages) \(message?.data?.discount ?? 0) \(self.curancy)")
                    self.promo = message?.data?.discount ?? 0
                    if self.delveryTotal == 0 {
                        let LE = NSLocalizedString("LE", comment: "profuct list lang")
                        self.promoValues.text = "\(self.promo) \(LE)"
                        self.allTotalPrice.text = "\(self.totlaPrice + self.deliveryPrices - self.promo) \(LE)"
                    }else {
                        let LE = NSLocalizedString("LE", comment: "profuct list lang")
                        self.promoValues.text = "\(self.promo) \(LE)"
                        self.allTotalPrice.text = "\(self.totlaPrice + self.deliveryPrices - self.promo) \(LE)"
                    }
                    self.stopAnimating()
                }else {
                    print("xxx")
                }
                if errorCode?.success == false {
                    self.showAlert(title: "Promo Code", message: errorCode?.data?.code?.first ?? "")
                    self.promoCodeTF.text = ""
                    self.stopAnimating()
                }
            }else {
                self.showAlert(title: "Promo Code", message: "Check your network")
                self.stopAnimating()
            }
        }
    }
    
    
    func creatOrder() {
        
        guard let delviryTF = delviryType.text, !delviryTF.isEmpty else {
            let messages = NSLocalizedString("enter your delviry Type", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        if typeDelivery == "Schedule" || typeDelivery == "مجدول"{
            guard let timing = timingTF.text, !timing.isEmpty else {
                let messages = NSLocalizedString("enter your delviry Time", comment: "hhhh")
                let title = NSLocalizedString("order", comment: "hhhh")
                self.showAlert(title: title, message: messages)
                return
            }
        }
        
        
        guard let name = fullNameTF.text, !name.isEmpty else {
            let messages = NSLocalizedString("enter your Name", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let phones = phoneTF.text, !phones.isEmpty else {
            let messages = NSLocalizedString("enter your phone", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let citys = cityTF.text, !citys.isEmpty else {
            let messages = NSLocalizedString("enter your city", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let region = regionTF.text, !region.isEmpty else {
            let messages = NSLocalizedString("enter your region", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let streetNam = streetTF.text, !streetNam.isEmpty else {
            let messages = NSLocalizedString("enter your street name", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let appartNum = homeNumberTF.text, !appartNum.isEmpty else {
            let messages = NSLocalizedString("enter your home number", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let floorNum = floorNumTF.text, !floorNum.isEmpty else {
            let messages = NSLocalizedString("enter your floor number", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let addres = addressTF.text, !addres.isEmpty else {
            let messages = NSLocalizedString("enter your address", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        let vc = checkoutDetiealsVC(nibName: "checkoutDetiealsVC", bundle: nil)
        vc.products = products
        vc.address = addres
        let deliveryPrice = NSLocalizedString("Delivery Price:", comment: "profuct list lang")
        let subTotalPrice = NSLocalizedString("Sub Total Price:", comment: "profuct list lang")
        let promoValue = NSLocalizedString("Promo Value:", comment: "profuct list lang")
        let TotalPrice = NSLocalizedString("Total Price:", comment: "profuct list lang")
        vc.type = "\(countCats.text ?? "") \n\(deliveryPrice) \(self.deliveryPrice.text ?? "") \n\(subTotalPrice) \(self.subTotalPrice.text ?? "")\n\(promoValue) \(promo) \n\(TotalPrice) \(self.allTotalPrice.text ?? "")"
        vc.floorNumber = floorNum
        vc.homeNumber = appartNum
        vc.street = streetNam
        vc.region = region
        vc.cityId = "\(cityId)"
        vc.phone = phones
        vc.fullName = name
        vc.promoCode = promoNext
        vc.giftId = ""
        vc.delivery_type = delvertyTypes
        vc.cityName = citys
        vc.regionId = regionId
        vc.receivePointsId = receivePointsId
        vc.typeDelivery = typeDelivery
        self.navigationController!.pushViewController(vc, animated: true)
        
        
    }
    
    
    @IBAction func checkOutBtnAction(_ sender: Any) {
        creatOrder()
    }
    
    @IBAction func promoBTNAction(_ sender: Any) {
        promoCodeCheck()
    }
}


extension checkOutVC: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == cityPicker {
            return delviers.count
        }else if pickerView == delviryStatePicker  {
            return status.count
        }else if pickerView == delviryTypePicker {
            return deleveryType.count
        }else {
            return points.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == cityPicker {
            return delviers[row].name
        }else if pickerView == delviryStatePicker {
            return status[row].name
        }else if pickerView == delviryTypePicker {
            return deleveryType[row]
        }else {
            return "\(points[row].title ?? "") \(points[row].datumDescription ?? "") \(points[row].price ?? 0) LE"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if pickerView == delviryTypePicker {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 44))
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            label.text = deleveryType[row]
            label.sizeToFit()
            return label
        }else if pickerView == cityPicker {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 44))
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            label.text = delviers[row].name
            label.sizeToFit()
            return label
        }else if pickerView == delviryStatePicker {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 44))
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            label.text = status[row].name
            label.sizeToFit()
            return label
        }else {
            let label = UILabel(frame: CGRect(x: 10, y: 10, width: 300, height: 44))
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            label.text = "\(points[row].title ?? "") \(points[row].datumDescription ?? "") \(points[row].price ?? 0) LE"
            label.sizeToFit()
            return label
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == cityPicker {
            cityTF.text = delviers[row].name
            cityId = delviers[row].id ?? 0
            delviryStatePikerFunc(id: delviers[row].id ?? 0)
        }else if pickerView == delviryStatePicker {
            regionTF.text = status[row].name
            regionId = status[row].id ?? 0
            self.deliveryPrices = status[row].price ?? 0
            if typeDelivery == "Immediately" {
                self.deliveryPrices = status[row].price ?? 0
                self.deliveryPrice.text = "\(deliveryPrices) LE"
                self.allTotalPrice.text = "\(totlaPrice + (status[row].price ?? 0)  - self.promo) LE"
            }
            
            
        }else if pickerView == delviryTypePicker {
            delviryType.text = deleveryType[row]
            if deleveryType[row] == "Schedule" || deleveryType[row] == "مجدول"{
                timingTF.isHidden = false
                timinImage.isHidden = false
                timingVIew.isHidden = false
                timingTF.text = ""
                timingPikerFunc()
                typeDelivery = "Schedule"
                self.deliveryPrice.text = "\(0)"
                regionTF.text = ""
            }else {
                timingTF.isHidden = true
                timinImage.isHidden = true
                timingVIew.isHidden = true
                typeDelivery = "Immediately"
                self.deliveryPrice.text = "\(0)"
                regionTF.text = ""
            }
        }else {
            self.receivePointsId = "\(points[row].id ?? 0)"
            self.deliveryPrices = points[row].price ?? 0
            let LE = NSLocalizedString("LE", comment: "profuct list lang")
            self.deliveryPrice.text = "\(deliveryPrices) \(LE)"
            self.allTotalPrice.text = "\(totlaPrice + deliveryPrices - self.promo) \(LE)"
            timingTF.text = "\(points[row].title ?? "") \(points[row].datumDescription ?? "") \(points[row].price ?? 0) LE"
        }
        
    }
}
