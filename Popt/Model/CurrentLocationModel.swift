//
//  CurrentLocationModel.swift
//  Popt
//
//  Created by Tomooki on 2016/05/18.
//  Copyright © 2016年 TomookiTatsuguhi. All rights reserved.
//

import UIKit
import CoreLocation

protocol CurrentLocationDelegate {
    func getedLocation()
}

class CurrentLocationModel: NSObject, CLLocationManagerDelegate {
    
    override init() {
    }
    
    var locationManeger : CLLocationManager!
    var CLDelegate  : CurrentLocationDelegate!
    var lat : CLLocationDegrees? = nil
    var lng : CLLocationDegrees? = nil
    
    
    func getLocation(){
        if self.lat != nil || self.lng != nil {
            return
        }
        self.locationManeger = CLLocationManager()
        self.locationManeger.delegate        = self
        
        let status = CLLocationManager.authorizationStatus()
        if(status == CLAuthorizationStatus.NotDetermined) {
            print("didChangeAuthorizationStatus:\(status)");
            self.locationManeger.requestAlwaysAuthorization()
        }
        self.locationManeger.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManeger.distanceFilter  = 100
        self.locationManeger.startUpdatingLocation()
    }
    
    /**
     CLLocationManagerDelegateMethod
     位置取得時に呼ばれます
     初回のみCurrentLocationDelegateで通知します
     
     - parameter manager:
     - parameter locations:
     */
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var isFirstTime = false
        if self.lat == nil || self.lng == nil {
            isFirstTime = true
        }
        
        self.lat = manager.location?.coordinate.latitude
        self.lng = manager.location?.coordinate.longitude
        
        if isFirstTime {
            self.CLDelegate.getedLocation()
        }
    }
    
    // 現状のステータス状態を表示します
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status != .AuthorizedAlways && status != .AuthorizedWhenInUse {
            ErrorUtil.shared.warning("CLAuthorizationStatus: 現在位置取得許可されていません")
        }
    }
    
    // 位置情報取得失敗時に呼ばれます
    func locationManager(manager: CLLocationManager,didFailWithError error: NSError){
        
    }


}
