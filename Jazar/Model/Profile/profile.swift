//
//  profile.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/14/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation


struct profile: Codable {
    let success: Bool?
    let data: profileData?
    let message: String?
}

struct profileData: Codable {
     let fullName, email, phone: String?
        let image: String?
        let firebaseToken, status, gender, promocode: String?
        let isGiftUsed: String?
        let giftid: Int?
        let city: City?
        let state: State?
        let createdAt, customerAddress, customerRegion, customerStreet: String?
        let customerHomeNumber, customerFloorNumber, customerAppartmentNumber, customerPostalCode: String?
        let customerCommentsExtra, totalWallet: String?

        enum CodingKeys: String, CodingKey {
            case fullName = "full_name"
            case email, phone, image, firebaseToken, status, gender, promocode
            case isGiftUsed = "is_gift_used"
            case giftid = "gift_id"
            case city, state
            case createdAt = "created_at"
            case customerAddress = "customer_address"
            case customerRegion = "customer_region"
            case customerStreet = "customer_street"
            case customerHomeNumber = "customer_home_number"
            case customerFloorNumber = "customer_floor_number"
            case customerAppartmentNumber = "customer_appartment_number"
            case customerPostalCode = "customer_postal_code"
            case customerCommentsExtra = "customer_comments_extra"
            case totalWallet = "total_wallet"
        }
    }

    struct City: Codable {
        let id: Int?
        let name, infoReceivePoint: String?

        enum CodingKeys: String, CodingKey {
            case id, name
            case infoReceivePoint = "info_receive_point"
        }
    }

    struct State: Codable {
        let id: Int?
        let name: String?
        let price: Int?
    }
