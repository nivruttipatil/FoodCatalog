//
//  FoodListTableViewCell.swift
//  FoodCatalog
//
//  Created by Nivrutti on 23/07/24.
//

import UIKit

class FoodListTableViewCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var iconImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        lblName.font = FoodScreenTheme.Font.header
        lblName.textColor = FoodScreenTheme.Color.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setFood(_ food: Food?) {
        lblName.text = food?.name ?? ""
        iconImgView.image = UIImage(named: food?.imageUrl ?? FoodScreenConstant.Images.placeHolder)
    }
}
