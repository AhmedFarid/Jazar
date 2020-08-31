//
//  profileApi.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/14/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class profileApi: NSObject {
    class func getProfileApi(completion: @escaping(_ error: Error?,_ success: Bool,_ product: profile?)-> Void){
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(helperAuth.getAPIToken() ?? "")",
            "X-localization": URLs.mainLang
        ]
        let url = URLs.profile
        print(headers)
        print(url)
        
        AF.request(url, method: .post, parameters: nil, encoding: URLEncoding.queryString, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let product = try JSONDecoder().decode(profile.self, from: response.data!)
                    if product.success == true {
                        completion(nil,true,product)
                    }else {
                        completion(nil,true,product)
                    }
                }catch{
                    completion(nil,true,nil)
                    print("error")
                }
            }
        }
        
    }
    
    class func editProfielApi(full_name: String,email: String,phone: String,completion: @escaping(_ error: Error?,_ success: Bool,_ product: Messages?)-> Void){
           
           let headers: HTTPHeaders = [
               "Authorization": "Bearer \(helperAuth.getAPIToken() ?? "")",
               "X-localization": URLs.mainLang,
               "Content-Type": "application/json"
           ]
        
        let parameters = [
            "full_name": full_name,
            "email": email,
            "phone": phone,
            "requestType": "edit",
            "gender": "male"
        ]
        
           let url = URLs.editCustomerProfile
           print(headers)
           print(url)
           
           AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: headers).responseJSON{ (response) in
               switch response.result
               {
               case .failure(let error):
                   completion(error, false,nil)
                   print(error)
               case .success:
                   do{
                       print(response)
                       let product = try JSONDecoder().decode(Messages.self, from: response.data!)
                       if product.success == true {
                           completion(nil,true,product)
                       }else {
                           completion(nil,true,product)
                       }
                   }catch{
                       completion(nil,true,nil)
                       print("error")
                   }
               }
           }
           
       }
    
    class func editAddressApi(full_name: String,email: String,phone: String,customer_address: String,customer_region: String,customer_street: String,customer_home_number: String,customer_floor_number:String,customer_appartment_number: String,city: String,state: String,completion: @escaping(_ error: Error?,_ success: Bool,_ product: Messages?)-> Void){
              
              let headers: HTTPHeaders = [
                  "Authorization": "Bearer \(helperAuth.getAPIToken() ?? "")",
                  "X-localization": URLs.mainLang,
                  "Content-Type": "application/json"
              ]
           
           let parameters = [
               "full_name": full_name,
               "email": email,
               "phone": phone,
               "requestType": "edit",
               "gender": "male",
               "customer_address": customer_address,
               "customer_region": customer_region,
               "customer_street": customer_street,
               "customer_home_number": customer_home_number,
               "customer_floor_number": customer_floor_number,
               "customer_appartment_number": customer_appartment_number,
               "customer_postal_code": "1111",
               "customer_comments_extra": "xxx",
               "city_id": city,
               "state_id": state
           ]
           
              let url = URLs.editCustomerProfile
              print(headers)
              print(url)
        print(parameters)
              
              AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: headers).responseJSON{ (response) in
                  switch response.result
                  {
                  case .failure(let error):
                      completion(error, false,nil)
                      print(error)
                  case .success:
                      do{
                          print(response)
                          let product = try JSONDecoder().decode(Messages.self, from: response.data!)
                          if product.success == true {
                              completion(nil,true,product)
                          }else {
                              completion(nil,true,product)
                          }
                      }catch{
                          completion(nil,true,nil)
                          print("error")
                      }
                  }
              }
              
          }
    
    class func changePasswordApi(password: String,password_confirmation: String,old_password: String,completion: @escaping(_ error: Error?,_ success: Bool,_ product: Messages?)-> Void){
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(helperAuth.getAPIToken() ?? "")",
            "X-localization": URLs.mainLang,
            "Content-Type": "application/json"
        ]
     
     let parameters = [
         "password": password,
         "password_confirmation": password_confirmation,
         "old_password": old_password
     ]
     
        let url = URLs.changePassword
        print(headers)
        print(url)
        
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let product = try JSONDecoder().decode(Messages.self, from: response.data!)
                    if product.success == true {
                        completion(nil,true,product)
                    }else {
                        completion(nil,true,product)
                    }
                }catch{
                    completion(nil,true,nil)
                    print("error")
                }
            }
        }
        
    }
}
