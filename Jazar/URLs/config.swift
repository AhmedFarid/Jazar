//
//  config.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import UIKit


struct URLs {
    
    static let main = "https://jzar1.com/api/"
    static let mainImage = "https://jzar1.com"
    
    static var mainLang = NSLocalizedString("en", comment: "profuct list lang")
    
    static let signupCustomer = main + "signupCustomer"
    static let login = main + "login"
    static let forgetPassword = main + "password/create"
    static let sliders = main + "sliders"
    static let bestSelling = main + "bestSelling"
    static let categories = main + "categories"
    static let hotDeal = main + "hotDeal"
    static let searchProduct = main + "searchProduct"
    static let addFavorite = main + "customer/addFavorite"
    static let removeFavorite = main + "customer/removeFavorite"
    static let addToCart = main + "customer/addToCart"
    static let removeFromCart = main + "customer/removeFromCart"
    static let favoirtes = main + "customer/favoirtes"
    static let carts = main + "customer/carts"
    static let makeOrder = main + "customer/makeOrder"
    static let getPromocodeDiscount = main + "customer/getPromocodeDiscount"
    static let orders = main + "customer/orders"
    static let social_login = main + "social_login"
    static let staticPages = main + "staticPages"
    static let contactUs = main + "contactUs"
    static let profile = main + "customer/profile"
    static let editCustomerProfile = main + "customer/editCustomerProfile"
    static let changePassword = main + "customer/changePassword"
    static let setReview = main + "customer/setReview"
    static let gifts = main + "customer/gifts"
    static let getGift = main + "customer/getGift"
    static let deliveries = main + "deliveries"
    static let getOrderTaxes = main + "customer/getOrderTaxes"
    static let cities = main + "cities"
    static let states = main + "states"
    static let receivepoints = main + "receivepoints"
    static let blogs = main + "blogs"
    static let offers = main + "offers"
    
}
