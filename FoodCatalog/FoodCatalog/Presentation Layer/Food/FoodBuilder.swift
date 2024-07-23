//
//  FoodBuilder.swift
//  FoodCatalog
//
//  Created by Nivrutti on 23/07/24.
//

import Foundation
import UIKit

struct FoodBuilder {
    static func build ()-> FoodListTableViewController {
        let foodStorage = FoodDataStorage(fileName: FoodScreenConstant.JSONFile.fileName,
                                          fileExtension: FoodScreenConstant.JSONFile.fileExt)
        let repository = FoodRepository(foodDataStorage: foodStorage)
        let foodUseCase = GetFoodUseCase(foodRepo: repository)
        let viewModel = FoodViewModel(foodUserCase: foodUseCase)
      
        let tableViewController = FoodListTableViewController(style: UITableView.Style.plain)
        tableViewController.viewModel = viewModel
        return tableViewController
    }
}
