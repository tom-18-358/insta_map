//
//  PlaceListModel.swift
//  Popt
//
//  Created by Tomooki on 2016/05/21.
//  Copyright © 2016年 TomookiTatsuguhi. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON
import SVProgressHUD

protocol PlacesModelDelegate {
    func getedPlaces()
}

class PlacesModel: NSObject {
    
    var list : [Place] = []
    var PMDelegate  : PlacesModelDelegate!
        
    // 場所情報と記事データ
    struct Place {
        let id       : String!
        let name     : String!
        let lat      : Double!
        let lng      : Double!
        let articles : ArticlesModel!
        func generateArticles() {
            let url = API.INSTA.BASE_URL
                + API.INSTA.PRAM.LOCATIONS
                + "/" + self.id
                + API.INSTA.PRAM.MEDIA_RECENT
                + API.INSTA.PRAM.ACCESS_TOKEN
            
            self.articles.generateArticleByUrl(url)
        }
    }
    
    /**
     緯度経度から付近の場所リストを取得
     
     - parameter lat: 緯度
     - parameter lng: 経度
     */
    func generatePlaces(lat: CLLocationDegrees, lng: CLLocationDegrees) {
        let url = API.INSTA.BASE_URL
            + API.INSTA.PRAM.LOCATIONS
            + API.INSTA.PRAM.SEARCH
            + API.INSTA.PRAM.ACCESS_TOKEN
            + API.INSTA.PRAM.LAT + "\(lat)"
            + API.INSTA.PRAM.LNG + "\(lng)"
            + API.INSTA.PRAM.DISTANCE + API.INSTA.SEARCH_DISTANCE
        
        Request.shared.request(
            HTTP_METHOD.GET,
            url: url,
            callBack: {(result : JSON) -> Void in
                self.setPlace(result)
            }
        )
    }
    
    private func setPlace(result: JSON){
        let places = result["data"]
        places.forEach{(id, place) in
            let placeStruct = Place(
                id       : place["id"].string,
                name     : place["name"].string,
                lat      : place["latitude"].double,
                lng      : place["longitude"].double,
                articles : ArticlesModel()
            )
            placeStruct.generateArticles()
            self.list.append(placeStruct)
        }
        self.PMDelegate.getedPlaces()
    }
}
