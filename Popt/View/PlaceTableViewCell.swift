//
//  PlaceTableViewCell.swift
//  Popt
//
//  Created by Tomooki on 2016/05/22.
//  Copyright © 2016年 TomookiTatsuguhi. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var placeImg: UIImageView!
    @IBOutlet weak var placeLable: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var articleCountLabel: UILabel!
    
    func setShadow() {
        self.baseView.layer.shadowOffset = CGSizeMake(1, 2)
        self.baseView.layer.shadowOpacity = 0.4
        self.baseView.layer.shadowRadius = 1
        self.baseView.layer.cornerRadius = 2
        self.baseView.layer.cornerRadius = 2

    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
