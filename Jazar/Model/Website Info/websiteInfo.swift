//
//  websiteInfo.swift
//  Jazar
//
//  Created by Ahmed farid on 9/3/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//


import Foundation


struct websiteInfo: Codable {
    let success: Bool?
    let data: websiteInfoData?
    let message: String?
}

struct websiteInfoData: Codable {
    let phone, whatsapp, fax, address: String?
    let socailMedia: [SocailMedia]?

    enum CodingKeys: String, CodingKey {
        case phone, whatsapp, fax, address
        case socailMedia = "socail_media"
    }
}

struct SocailMedia: Codable {
    let name: String?
    let link: String?
}
