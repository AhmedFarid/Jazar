//
//  nottafication.swift
//  Jazar
//
//  Created by Ahmed farid on 8/27/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation

struct Nottafication: Codable {
    let success: Bool?
    let data: [nottaficationData]?
    let message: String?
}

struct nottaficationData: Codable {
    let id: Int?
    let name, datumDescription, date: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case datumDescription = "description"
        case date
    }
}

