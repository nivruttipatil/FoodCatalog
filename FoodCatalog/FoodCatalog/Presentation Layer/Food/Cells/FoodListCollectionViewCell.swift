//
//  FoodListCollectionViewCell.swift
//  FoodCatalog
//
//  Created by Nivrutti on 23/07/24.
//

import UIKit

class FoodListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setFoodCategory(_ foodCategory: FoodCategory?) {
        iconImgView.image = UIImage(named: foodCategory?.imageUrl ?? FoodScreenConstant.Images.placeHolder)
    }
}
