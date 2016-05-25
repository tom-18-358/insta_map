//
//  PlaceCollectionView.swift
//  Popt
//
//  Created by Tomooki on 2016/05/22.
//  Copyright © 2016年 TomookiTatsuguhi. All rights reserved.
//

import UIKit
import AlamofireImage

class PlaceCollectionView: UICollectionView {
    
    var articlesCount: Int!
    var places: PlacesModel!

    // MARK: - UICollectionViewDelegate Protocol
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let customCell = collectionView.dequeueReusableCellWithReuseIdentifier("placeCell", forIndexPath: indexPath) as! PlaceCollectionViewCell
        let place : PlacesModel.Place = places.list[indexPath.row]
        guard let url: NSURL = place.articles.displayedArticle?.imgLink.thumbnailUrl else {
            return customCell
        }
        customCell.placeImg.af_setImageWithURL(url)
        let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
            size: customCell.placeImg.frame.size,
            radius: 35.0
        )
        customCell.placeImg.af_setImageWithURL(url,
                                               placeholderImage: nil,
                                               filter: filter)
        customCell.placeName.text = place.name
        
        return customCell
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articlesCount!
    }
    
}
