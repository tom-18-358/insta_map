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
    
    var list : [PlaceModel] = []
    var PMDelegate  : PlacesModelDelegate!

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
            body: nil,
            header: nil,
            callBack: {(result : JSON) -> Void in
                self.setPlace(result)
            }
        )
    }
    
    /**
     PlaceIdからPlaceModelを返す
     
     - parameter placeId: PlaceID
     
     - returns: PlaceModel
     */
    func getPlaceByPlaceId(placeId: String) -> PlaceModel? {
        var _place: PlaceModel?
        self.list.forEach{ place in
            if place.id == placeId {
                _place = place // FIXME: return place でなぜかエラーが出る・・・
            }
        }

        return _place
    }
    
    /**
     placeIdから該当の配列Numを返す
     
     - parameter Id: String PlaceModel.id
     
     - returns:      Int    配列の位置
     */
    func getIdRowNum(placeId: String) -> Int {
        var num: Int = 0
        self.list.forEach{place in
            if place.id == placeId {
                num = self.list.indexOf(place)!
            }
        }
        return num
    }
    
    
// MARK: - PrivateMethod
    /**
     取得した情報をPlaceModelにはめ込む
     
     - parameter result: APIより取得した場所一覧
     */
    private func setPlace(result: JSON){
        let places = result["data"]
        places.forEach{(id, place) in
            let placeModel = PlaceModel(
                id:   place["id"].string!,
                name: place["name"].string!,
                lat:  place["latitude"].double!,
                lng:  place["longitude"].double!
            )
            if placeModel.id != "0" {
                placeModel.generateArticles()
                self.list.append(placeModel)
            }
        }
        self.PMDelegate.getedPlaces()
    }
    
}
