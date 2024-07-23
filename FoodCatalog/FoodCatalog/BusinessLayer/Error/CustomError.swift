//
//  CustomError.swift
//  FoodCatalog
//
//  Created by Nivrutti on 23/07/24.
//

import Foundation

enum CustomError: LocalizedError {
    case invalidPath
    case contentError
    case noData
    case noItemFound
    
    var errorDescription: String {
        switch self {
        case .contentError,
                .invalidPath,
                .noData:
            return FoodScreenConstant.Error.noDataFound
        case .noItemFound:
            return FoodScreenConstant.Error.noSearchMatch
        }
    }
}
