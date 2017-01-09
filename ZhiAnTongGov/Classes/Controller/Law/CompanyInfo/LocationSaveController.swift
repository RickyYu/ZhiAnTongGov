//
//  LocationSaveController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/6.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit

class LocationSaveControllers:UIViewController,BMKMapViewDelegate ,BMKLocationServiceDelegate{
    var _mapView: BMKMapView?
    var topView: UIView?
    var _locService :BMKLocationService?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        _mapView = BMKMapView(frame: CGRect(x: 0, y: 134, width: self.view.frame.width, height: self.view.frame.height))

        self.view.addSubview(_mapView!)
        self.title="企业定位"
        self.view.backgroundColor = UIColor.whiteColor()
        _locService = BMKLocationService()
        _locService?.delegate = self
        _locService?.startUserLocationService()
        
        
        
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
        print("纬度 = \(userLocation.location.coordinate.latitude) + 经度 = \(userLocation.location.coordinate.longitude)")
    }
    
}
