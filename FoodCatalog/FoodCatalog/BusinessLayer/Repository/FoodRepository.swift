//
//  FoodRepository.swift
//  FoodCatalog
//
//  Created by Nivrutti on 23/07/24.
//

import Foundation

protocol FoodRepositoryProtocol {
    func getFoods() -> Result<FoodCategoryResponse?, CustomError>
}

struct FoodRepository: FoodRepositoryProtocol {
    
    private let foodDataStorage: FoodDataStorageProtocol
    
    init(foodDataStorage: FoodDataStorageProtocol) {
        self.foodDataStorage = foodDataStorage
    }
    
    func getFoods() -> Result<FoodCategoryResponse?, CustomError> {
        return foodDataStorage.getFoods()
    }
}
