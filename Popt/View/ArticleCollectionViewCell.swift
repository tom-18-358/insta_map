//
//  CustomCollectionViewCell.swift
//  Popt
//
//  Created by Tomooki on 2016/05/21.
//  Copyright © 2016年 TomookiTatsuguhi. All rights reserved.
//

import UIKit

class ArticleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var picImgView: UIImageView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
}
