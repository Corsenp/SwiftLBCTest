//
//  Service.swift
//  PierreTestLBC
//
//  Created by Pierre Corsenac on 12/03/2022.
//

import Foundation

struct Item: Identifiable, Codable {
    let id: Int?
    let category_id: Int?
    let title: String?
    let description: String?
    let price: Float?
    let images_url: ImageUrl
    let creation_date: String?
    let is_urgent: Bool?
    let siret: String?
}

struct ImageUrl: Codable {
    let small: String?
    let thumb: String?
}

struct Category: Identifiable, Codable {
    let id: Int
    let name: String
}
