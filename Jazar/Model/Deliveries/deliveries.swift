//
//  deliveries.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/19/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//


import Foundation


struct city: Codable {
    let success: Bool?
    let data: [cityData]?
    let message: String?
    
}


struct cityData: Codable {
    let id: Int?
    let name: String?
    let price: Int?
    let info_receive_point: String
}

struct states: Codable {
    let success: Bool?
    let data: [statesData]?
    let message: String?
    
}


struct statesData: Codable {
    let id: Int?
    let name: String?
    let price: Int?
}



struct TimingCity: Codable {
    let success: Bool?
    let data: [dataTiming]?
    let message: String?
}


struct dataTiming: Codable {
    let id, price: Int?
    let title, datumDescription: String?

    enum CodingKeys: String, CodingKey {
        case id, price, title
        case datumDescription = "description"
    }
}
