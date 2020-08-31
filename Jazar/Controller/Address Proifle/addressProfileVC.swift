//
//  addressProfileVC.swift
//  Jazar
//
//  Created by Ahmed farid on 8/24/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class addressProfileVC: UIViewController,NVActivityIndicatorViewable {

    @IBOutlet weak var addressTF: textFieldView!
    @IBOutlet weak var floorNumTF: textFieldView!
    @IBOutlet weak var homeNumTF: textFieldView!
    @IBOutlet weak var streetTF: textFieldView!
    @IBOutlet weak var regionTF: textFieldView!
    @IBOutlet weak var citytf: textFieldView!
    
    
    var email = ""
    var phone = ""
    var fname = ""
    
    var delviers = [cityData]()
    var status = [statesData]()
    
    var ciytDrvly = 0
    var stateId = 0
    
    let cityPicker = UIPickerView()
    let delviryStatePicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpData()
        cityPikerFunc()
        regionTF.isEnabled = false
        citytf.isEnabled = false
        
        setUpNavColore(false)
    }
    
    func cityPikerFunc() {
        cityPicker.delegate = self
        cityPicker.dataSource = self
        citytf.inputView = cityPicker
        loaderHelper()
        checkOutApi.getCitys{ (error,success,delviers) in
            if let delviers = delviers{
                self.delviers = delviers.data ?? []
                print(delviers)
                if self.delviers.count != 0 {
                    self.citytf.isEnabled = true
                }
                self.cityPicker.reloadAllComponents()
                self.stopAnimating()
            }
        }
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

    @IBAction func editAddress(_ sender: Any) {
        editAddress()
    }
    
    
    func setUpData() {
        loaderHelper()
        profileApi.getProfileApi { (error, success, profile) in
            if success {
                self.email = profile?.data?.email ?? ""
                self.phone = profile?.data?.phone ?? ""
                self.fname = profile?.data?.fullName ?? ""
                self.addressTF.text = profile?.data?.customerAddress ?? ""
                self.floorNumTF.text = profile?.data?.customerFloorNumber ?? ""
                self.homeNumTF.text = profile?.data?.customerHomeNumber ?? ""
                self.streetTF.text = profile?.data?.customerStreet ?? ""
                self.regionTF.text = profile?.data?.state?.name ?? ""
                self.citytf.text = profile?.data?.city?.name ?? ""
                self.ciytDrvly = profile?.data?.city?.id ?? 0
                self.stateId = profile?.data?.state?.id ?? 0
                self.stopAnimating()
            }
            self.stopAnimating()
        }
        
    }
    
    
    
    func editAddress() {
        loaderHelper()
        profileApi.editAddressApi(full_name: fname, email: email, phone: phone,customer_address: addressTF.text ?? "",customer_region: regionTF.text ?? "",customer_street: streetTF.text ?? "",customer_home_number: homeNumTF.text ?? "",customer_floor_number: floorNumTF.text ?? "",customer_appartment_number: "444",city: "\(ciytDrvly)",state: "\(stateId)") { (error, success, message) in
            if success {
                let title = NSLocalizedString("Edit Profile", comment: "profuct list lang")
                let message = NSLocalizedString("Success Eidt Profile", comment: "profuct list lang")
                self.showAlert(title: title, message: message)
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
    
}


extension addressProfileVC: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == cityPicker {
            return delviers.count
        }else   {
            return status.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == cityPicker {
            return delviers[row].name
        }else{
            return status[row].name
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == cityPicker {
            citytf.text = delviers[row].name
            ciytDrvly = delviers[row].id ?? 0
            delviryStatePikerFunc(id:delviers[row].id ?? 0)
        }else {
            regionTF.text = status[row].name
            stateId = status[row].id ?? 0
        }
    }
}
