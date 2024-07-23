//
//  Food.swift
//  FoodCatalog
//
//  Created by Nivrutti on 23/07/24.
//

import Foundation
struct FoodCategoryResponse: Decodable {
    let categories: [FoodCategory]?
}

struct FoodCategory: Decodable {
    let name: String?
    let imageUrl: String?
    let id: Int?
    let foods: [Food]?
    enum CodingKeys: String, CodingKey {
        case name = "category_name"
        case imageUrl = "category_imageUrl"
        case id = "category_id"
        case foods = "category_items"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = container.decodeSafelyIfPresent(.name)
        imageUrl = container.decodeSafelyIfPresent(.imageUrl)
        id = container.decodeSafelyIfPresent(.id)
        foods = container.decodeSafelyIfPresent(.foods)
    }
}

struct Food: Codable {
    let name: String?
    let imageUrl: String?
    let id: Int?
    enum CodingKeys: String, CodingKey {
        case name = "food_name"
        case imageUrl = "food_imageUrl"
        case id = "food_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = container.decodeSafelyIfPresent(.name)
        imageUrl = container.decodeSafelyIfPresent(.imageUrl)
        id = container.decodeSafelyIfPresent(.id)
    }
}

