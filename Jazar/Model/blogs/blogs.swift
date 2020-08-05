//
//  blogs.swift
//  Jazar
//
//  Created by Ahmed farid on 8/4/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation


struct blogs: Codable {
    let success: Bool?
    let data: [blogsData]?
    let message: String?
}


struct blogsData: Codable {
    let title, shortDescription, datumDescription: String?
    let image: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case title
        case shortDescription = "short_description"
        case datumDescription = "description"
        case image
        case createdAt = "created_at"
    }
}
