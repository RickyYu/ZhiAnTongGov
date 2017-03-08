//
//  LocationSaveController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/6.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit
//反向传值
protocol LocationParameterDelegate{
    func passParams(lng: String,lat:String)
}
class LocationSaveController:BaseViewController,BMKLocationServiceDelegate,BMKMapViewDelegate{
    var _mapView: BMKMapView?
    var _locService :BMKLocationService?
    var pointAnnotation: BMKPointAnnotation?
    var animatedAnnotation: BMKPointAnnotation?
    var ground: BMKGroundOverlay?
    var latitude:Double! = nil //纬度
    var longitude:Double! = nil//经度
    var companyId:String = ""
    var delegate : LocationParameterDelegate!
    var locInfoModel  = LocInfoModel()
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
        _mapView!.centerCoordinate = CLLocationCoordinate2DMake(29.87533950805664, 121.5977401733398)
        _mapView!.zoomLevel=16

        getData()
        
        
    }
    
    func getData(){
        
        var parameters = [String : AnyObject]()
        parameters["company.id"] = companyId
        NetworkTool.sharedTools.getPoint(parameters) { (locInfoModel, error) in
         //获取到经纬度后更新地图显示
            if error == nil{
                self.locInfoModel = locInfoModel
                self._mapView!.centerCoordinate = CLLocationCoordinate2DMake(locInfoModel.y, locInfoModel.x)
                self._mapView!.zoomLevel=16
                if self.animatedAnnotation == nil {
                    self.animatedAnnotation = BMKPointAnnotation()
                    self.animatedAnnotation?.coordinate = CLLocationCoordinate2DMake(locInfoModel.y, locInfoModel.x)
                    self.animatedAnnotation?.title = "当前位置"
                }
                self._mapView!.addAnnotation(self.animatedAnnotation)

            }else{
                self.showHint("\(error)", duration: 2, yOffset: 0)
                if error == NOTICE_SECURITY_NAME {
                    self.toLoginView()
                }
            }
            
        }
    
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
//        if animatedAnnotation == nil {
//            animatedAnnotation = BMKPointAnnotation()
//            animatedAnnotation?.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
//            animatedAnnotation?.title = "当前位置"
//        }
//        _mapView!.addAnnotation(animatedAnnotation)
        print("当前位置 = 纬度 = \(latitude) + 经度 = \(longitude)")
        if latitude != nil{
            self._mapView!.centerCoordinate = CLLocationCoordinate2DMake(latitude, longitude)
            self._mapView!.zoomLevel=16
        }else{
         self.showHint("自动定位失败，请打开百度定位权限", duration: 2, yOffset: 2)
        }
       
        
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
         print("点击空白处后获得  纬度 = \(coordinate.latitude) + 经度 = \(coordinate.longitude)")
        lng = String(coordinate.longitude)
        lat = String(coordinate.latitude)
        
    }
    
    @IBAction func saveLoc(sender: AnyObject) {
        
        var parameters = [String : AnyObject]()
        parameters["company.id"] = companyId
        parameters["point.x"] = lng
        parameters["point.y"] = lat
        NetworkTool.sharedTools.savePoint(parameters) { (cpyInfoModels, error, totalCount) in
            if error == nil{
            self.showHint("位置更新成功", duration: 1, yOffset: 0)
                if self.delegate != nil{
                 self.delegate.passParams(self.lng, lat: self.lat)
                }
                
                self.navigationController?.popViewControllerAnimated(true)
           
            }else{
            self.showHint("\(error)", duration: 2, yOffset: 0)
                if error == NOTICE_SECURITY_NAME {
                    self.alertNotice("提示", message: error, handler: {
                        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
                        self.presentViewController(controller, animated: true, completion: nil)
                    })
                }
            }
        }
        
      
    }
    
    
    var lng:String = "" //经度
    var lat:String = "" //纬度
}
