//
//  FoodScreenConstant.swift
//  FoodCatalog
//
//  Created by Nivrutti on 23/07/24.
//

import Foundation
struct FoodScreenConstant {
    
    struct JSONFile {
        static let fileName = "FoodData"
        static let fileExt = "json"
    }
    
    struct ViewIndetifire {
        static let foodListTableViewCell = "FoodListTableViewCell"
        static let CollectionCellImage = "FoodListCollectionViewCell"
        static let foodTableHeaderView = "FoodTableHeaderView"
    }
    
    struct Images {
        static let placeHolder = "Burgers"
    }
    
    struct Error {
        static let noDataFound = "No Data Found."
        static let noSearchMatch = "No Match Found."
        static let searchPlaceholder = "Search Food"
    }
    
    struct Height {
        static let sectionHeight = 50.0
        static let listItemHeight = 80.0
        static let headerRatio = 0.7
    }
    
}



