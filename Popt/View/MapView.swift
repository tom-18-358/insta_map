//
//  mapView.swift
//  Popt
//
//  Created by Tomooki on 2016/05/22.
//  Copyright © 2016年 TomookiTatsuguhi. All rights reserved.
//

import UIKit
import MapKit

class MapView: MKMapView {
    
    func setMap(clLat: CLLocationDegrees, clLng: CLLocationDegrees ) {
        let Coordinate : CLLocationCoordinate2D = CLLocationCoordinate2DMake(clLat, clLng)
        let LatDist    : CLLocationDistance     = Double(API.INSTA.SEARCH_DISTANCE)!
        let LonDist    : CLLocationDistance     = Double(API.INSTA.SEARCH_DISTANCE)!
        let myRegion   : MKCoordinateRegion     = MKCoordinateRegionMakeWithDistance(Coordinate, LatDist, LonDist);
        self.setRegion(myRegion, animated: true)
    }
    
    func setPin(place: PlaceModel) {
        let pin = PlacePointAnnotation()
        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(place.lat, place.lng)
        pin.coordinate = center
        pin.title      = place.name
        pin.placeId    = place.id
        self.addAnnotation(pin)
    }
    
    func selectByPlaceId(placeId: String) {
        self.annotations.forEach{annotation in
            let customAnnotation = annotation as! PlacePointAnnotation
            if customAnnotation.placeId == placeId {
                self.selectAnnotation(annotation, animated: true)
            }
        }
    }

}
