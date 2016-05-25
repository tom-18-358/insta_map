//
//  MapViewController.swift
//  Popt
//
//  Created by Tomooki on 2016/05/18.
//  Copyright © 2016年 TomookiTatsuguhi. All rights reserved.
//

import UIKit
import MapKit
import SVProgressHUD
import SwiftyJSON
import AlamofireImage

class PlacesViewController: UIViewController, CurrentLocationDelegate, PlacesModelDelegate ,MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    private var CLLocation : CurrentLocationModel!
    @IBOutlet weak var mapView: MapView!
    @IBOutlet weak var tableView: UITableView!
    
    private var clLat: CLLocationDegrees!
    private var clLng: CLLocationDegrees!
    
    private var places: PlacesModel!
    
//MARK: - VIEW method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 現在位置取得
        self.CLLocation = CurrentLocationModel()
        self.CLLocation.CLDelegate = self
        self.CLLocation.getLocation()
        
        self.places = PlacesModel()
        self.places.PMDelegate = self
        
        self.tableView.delegate = self
        self.mapView.delegate = self
        
        self.tableView.layer.shadowOffset = CGSizeMake(-1, -2)
        self.tableView.layer.shadowOpacity = 0.6
        self.tableView.separatorStyle = .None
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PlacesViewController.updatePlaceCell(_:)), name: "updatePlaceInfo", object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().delete(self)
    }
    

//MARK: - CurrentLocationDelegate method
    // 現在位置取得成功
    func getedLocation() {
        self.clLat = self.CLLocation.lat!
        self.clLng = self.CLLocation.lng!
        self.mapView.setMap(self.clLat, clLng: clLng)
        SVProgressHUD.show()
        self.places.generatePlaces(self.clLat, lng: self.clLng)
    }
    
    
//MARK: - PlacesModelDelegate method
    // 付近の投稿情報の取得成功
    func getedPlaces() {
        self.places.list.forEach{ place in
            self.mapView.setPin(place)
        }
        self.tableView.reloadData()
        SVProgressHUD.dismiss()
    }
    
    
//MARK: - private method
    private func goArticleView(place: PlaceModel) {
        let VC = UIStoryboard(name: "ArticlesViewController", bundle: nil)
        let articlesVC: ArticlesViewController = VC.instantiateViewControllerWithIdentifier("ArticlesViewController") as! ArticlesViewController
        articlesVC.place = place
        self.presentViewController(articlesVC, animated: true, completion: nil)
    }
    

//MARK: - tapedMethod
    // tableCell tap時に記事一覧に遷移
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {        
        self.goArticleView(places.list[indexPath.row])
    }
    
    // pin tap時に記事一覧に遷移
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        let annotation = view.annotation as! PlacePointAnnotation
        self.goArticleView(annotation.place)
    }
    
    // map 長押しした箇所の投稿を取得
    @IBAction func longPress(sender: AnyObject) {
        // 長押しの最中に何度もピンを生成しないようにする.
        if sender.state != UIGestureRecognizerState.Began {
            return
        }
        self.places.list = []
        self.mapView.removeAnnotations(self.mapView.annotations)
        let tapedLocationXY = sender.locationInView(mapView)
        let tapedLocation: CLLocationCoordinate2D = mapView.convertPoint(tapedLocationXY, toCoordinateFromView: mapView)
        SVProgressHUD.show()
        self.places.generatePlaces(tapedLocation.latitude, lng: tapedLocation.longitude)
    }

    
// MARK: - ObserberMethod
    // Place情報update時にcellを更新
    func updatePlaceCell(notification: NSNotification){
        guard let placeId = notification.userInfo!["id"] else {
            return
        }
        let row = NSIndexPath(forRow: self.places.getIdRowNum(placeId as! String), inSection: 0)
        self.tableView.reloadRowsAtIndexPaths([row], withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    
// MARK: - UITableViewDelegate Protocol
    //セル数を指定
    func tableView(table: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let num: Int = self.places.list.count else {
            return 0
        }
        return num
    }
    
    //各セルの要素を設定する
    func tableView(table: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let place : PlaceModel = places.list[indexPath.row]
        let customCell = table.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath) as! PlaceTableViewCell
        customCell.placeLable.text = place.name
        customCell.setShadow()
        guard let url: NSURL = place.articles.displayedArticle?.imgLink.thumbnailUrl else {
            return customCell
        }
        let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
            size: customCell.placeImg.frame.size,
            radius: 32.0
        )
        customCell.placeImg.af_setImageWithURL(url, placeholderImage: nil, filter: filter)
        customCell.likeCountLabel.text    = String(place.articles.totalLikeCount!)
        customCell.articleCountLabel.text = String(place.articles.list.count)
        return customCell
    }

}
