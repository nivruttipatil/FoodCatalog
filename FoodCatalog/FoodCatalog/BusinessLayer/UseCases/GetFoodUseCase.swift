//
//  GetFoodUseCase.swift
//  FoodCatalog
//
//  Created by Nivrutti on 23/07/24.
//

import Foundation

protocol GetFoodUseCaseProtocol {
    func execute() -> Result<FoodCategoryResponse?, CustomError>
}

struct GetFoodUseCase: GetFoodUseCaseProtocol {

    private let foodRepo: FoodRepositoryProtocol
    
    init(foodRepo: FoodRepositoryProtocol){
        self.foodRepo = foodRepo
    }
    
    func execute() -> Result<FoodCategoryResponse?, CustomError> {
        return foodRepo.getFoods()
    }
}

