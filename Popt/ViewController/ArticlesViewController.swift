//
//  ArticleCollectionViewController.swift
//  Popt
//
//  Created by Tomooki on 2016/05/18.
//  Copyright © 2016年 TomookiTatsuguhi. All rights reserved.
//

import UIKit
import SVProgressHUD
import AlamofireImage

class ArticlesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var place : PlaceModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.place.articles.generateNextArticles()
    }
    
    @IBAction func closePage(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
// MARK: - UICollectionViewDelegate Protocol
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let customCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ArticleCollectionViewCell
        let articles : ArticlesModel.Article = self.place.articles.list[indexPath.row]
        customCell.picImgView.af_setImageWithURL(articles.imgLink.thumbnailUrl)
        return customCell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.place.articles.list.count;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let url = place.articles.list[indexPath.row].link
        let VC = UIStoryboard(name: "WebViewController", bundle: nil)
        let webVC = VC.instantiateViewControllerWithIdentifier("WebViewController") as! WebViewController
        webVC.url = url
        self.presentViewController(webVC, animated: true, completion: nil)
    }
    
}
