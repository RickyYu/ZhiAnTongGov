//
//  LocationSaveController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/6.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit

class LocationSaveController:UIViewController,BMKLocationServiceDelegate,BMKMapViewDelegate{
    var _mapView: BMKMapView?
    var _locService :BMKLocationService?
    var pointAnnotation: BMKPointAnnotation?
    var animatedAnnotation: BMKPointAnnotation?
    var ground: BMKGroundOverlay?
    var latitude:Double! = nil //纬度
    var longitude:Double! = nil//经度
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置定位精确度，默认：kCLLocationAccuracyBest

        _mapView = BMKMapView(frame: CGRect(x: 0, y: 134, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(_mapView!)
        self.title="企业定位"
        self.view.backgroundColor = UIColor.whiteColor()
        _locService = BMKLocationService()
        _locService?.delegate = self
        _locService?.startUserLocationService()
        _mapView!.showsUserLocation = true
        //设置位置跟踪态
        _mapView!.userTrackingMode = BMKUserTrackingModeNone
        
        //定位万金大厦
        _mapView!.centerCoordinate = CLLocationCoordinate2DMake(29.8673, 121.5995)
        _mapView!.zoomLevel=16

        
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        _mapView?.viewWillAppear()
        _mapView?.delegate = self // 此处记得不用的时候需要置nil，否则影响内存的释放
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        _mapView?.viewWillDisappear()
        _mapView?.delegate = nil // 不用时，置nil
    }
    
    func didUpdateUserHeading(userLocation: BMKUserLocation!) {
        
    }
    
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {

        latitude = userLocation.location.coordinate.latitude
        longitude = userLocation.location.coordinate.longitude
         _mapView!.updateLocationData(userLocation)
    }
    
    @IBAction func getCurrentLoc(sender: AnyObject) {
        if animatedAnnotation == nil {
            animatedAnnotation = BMKPointAnnotation()
            animatedAnnotation?.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            animatedAnnotation?.title = "当前位置"
        }
        _mapView!.addAnnotation(animatedAnnotation)
         print("当前位置 = 纬度 = \(latitude) + 经度 = \(longitude)")
    }
    
    @IBAction func modifyLoc(sender: AnyObject) {
        animatedAnnotation = BMKPointAnnotation()
        animatedAnnotation?.coordinate = CLLocationCoordinate2DMake(latitude,longitude)
        animatedAnnotation?.title = "修改定位"
        _mapView!.addAnnotation(animatedAnnotation)
        
        var coordinate :CLLocationCoordinate2D = CLLocationCoordinate2D.init()
        if animatedAnnotation != nil{
        
           coordinate = animatedAnnotation!.coordinate
            
        }
        
      print("修改定位 = 纬度 = \(coordinate.latitude) + 经度 = \(coordinate.longitude)")
        
    }
    
    func mapView(mapView: BMKMapView!, onClickedMapPoi mapPoi: BMKMapPoi!) {
        let coordinate :CLLocationCoordinate2D = mapPoi.pt
        print("onClickedMapPoi = \(coordinate.latitude) + 经度 = \(coordinate.latitude)+ 名称 = \(mapPoi.text)")
        
    }

    func mapView(mapView: BMKMapView!, onClickedMapBlank coordinate: CLLocationCoordinate2D) {
        
        if animatedAnnotation != nil{
             _mapView!.removeAnnotation(animatedAnnotation)
        }
        animatedAnnotation = BMKPointAnnotation()
        animatedAnnotation?.coordinate = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
        animatedAnnotation?.title = "修改定位"
        _mapView!.addAnnotation(animatedAnnotation)
         print("点击空白处后获得纬度 = \(coordinate.latitude) + 经度 = \(coordinate.longitude)")
    }
    
    @IBAction func saveLoc(sender: AnyObject) {
        
      
    }
}
