//
//  PlaceModel.swift
//  Popt
//
//  Created by Tomooki on 2016/05/25.
//  Copyright © 2016年 TomookiTatsuguhi. All rights reserved.
//

import UIKit

class PlaceModel: NSObject, AriticlesModelDelegate {

    let id       : String!
    let name     : String!
    let lat      : Double!
    let lng      : Double!
    let articles : ArticlesModel!
    
    init(id: String, name: String, lat: Double, lng: Double) {
        self.id   = id
        self.name = name
        self.lat  = lat
        self.lng  = lng
        self.articles = ArticlesModel()
    }
    
    // 場所IDより情報取得
    func generateArticles() {
        self.articles.ATdelefate = self
        let url = API.INSTA.BASE_URL
            + API.INSTA.PRAM.LOCATIONS
            + "/" + self.id
            + API.INSTA.PRAM.MEDIA_RECENT
            + API.INSTA.PRAM.ACCESS_TOKEN
        
        self.articles.generateArticleByUrl(url)
    }
    
    
// MARK: - AriticlesModelDelegate Protocol
    func getedArticles() {
        let n : NSNotification = NSNotification(name: "updatePlaceInfo", object: self, userInfo: ["id": self.id])
        NSNotificationCenter.defaultCenter().postNotification(n)
    }

}
