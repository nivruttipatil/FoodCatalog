//
//  FoodDataStorage.swift
//  FoodCatalog
//
//  Created by Nivrutti on 23/07/24.
//

import Foundation

protocol FoodDataStorageProtocol {
    func getFoods() -> Result<FoodCategoryResponse?, CustomError>
}

struct FoodDataStorage: FoodDataStorageProtocol {
    
    private var fileName: String
    private var fileExtension: String
    
    init(fileName: String, fileExtension: String) {
        self.fileName = fileName
        self.fileExtension = fileExtension
    }
    
    func getFoods() -> Result<FoodCategoryResponse?, CustomError> {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            return .failure(CustomError.invalidPath)
        }
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(FoodCategoryResponse.self, from: data)
            return .success(response)
        } catch {
            return .failure(CustomError.contentError)
        }
    }
}
