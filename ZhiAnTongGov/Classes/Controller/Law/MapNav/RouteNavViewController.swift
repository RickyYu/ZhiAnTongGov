//
//  RouteNavViewController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/12/12.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import UIKit

class RouteNavViewController: UIViewController, BMKLocationServiceDelegate,BMKMapViewDelegate, BMKRouteSearchDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var _mapView: BMKMapView!
    @IBOutlet weak var fromAddressField: UITextField!
    @IBOutlet weak var toAddressField: UITextField!
    var animatedAnnotation: BMKPointAnnotation!
    var routeSearch: BMKRouteSearch!
    var locService :BMKLocationService!
    var latitude:Double! = nil //纬度
    var longitude:Double! = nil//经度
    var startCc2d  = CLLocationCoordinate2D() //路径起点位置
    var endCc2d  = CLLocationCoordinate2D()//路径终点位置
    //回传的CpyInfoModel
    var cpyInfoModel :CpyInfoModel!
    var isRefresh : Bool = false
    var cityName :String = "宁波"
    override func viewDidLoad() {
        super.viewDidLoad()
        routeSearch = BMKRouteSearch()
        
        // 界面初始化
    
       // fromAddressField.text = "万金大厦"
        fromAddressField.placeholder = "默认当前位置"
       // toAddressField.text = "海曙欧尚"
        toAddressField.placeholder = "默认企业位置"
        fromAddressField.delegate = self
        fromAddressField.delegate = self
        toAddressField.delegate = self
        
        
         self.navigationItem.title = "地图导航"
        // 在导航栏上添加“途径点”按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_white"), style: .Done, target: self, action: #selector(RouteNavViewController.back))
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "选择企业", style: .Plain, target: self, action: #selector(self.choiceCpy))
        
        
        locService = BMKLocationService()
        locService.delegate = self
        locService.startUserLocationService()
        _mapView!.showsUserLocation = true
        //设置位置跟踪态
        _mapView!.userTrackingMode = BMKUserTrackingModeNone
        //定位万金大厦
        _mapView!.centerCoordinate = CLLocationCoordinate2DMake(29.8673, 121.5995)
        _mapView!.zoomLevel=16
    }
    
    func choiceCpy(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("RouteCpyChoiceController")
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        
        latitude = userLocation.location.coordinate.latitude
        longitude = userLocation.location.coordinate.longitude
        startCc2d = userLocation.location.coordinate
        _mapView!.updateLocationData(userLocation)

    }
    
    func back(){
          navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        _mapView.viewWillAppear()
        _mapView.delegate = self
        routeSearch.delegate = self
        if isRefresh{
            if cpyInfoModel.y != nil {
            self._mapView!.centerCoordinate = CLLocationCoordinate2DMake(self.cpyInfoModel.y, self.cpyInfoModel.x)
            self._mapView!.zoomLevel=16
            if self.animatedAnnotation == nil {
                self.animatedAnnotation = BMKPointAnnotation()
                self.animatedAnnotation?.coordinate = CLLocationCoordinate2DMake(self.cpyInfoModel.y, self.cpyInfoModel.x)
                self.animatedAnnotation?.title = "当前位置"
            }
            self._mapView!.addAnnotation(self.animatedAnnotation)
            self.endCc2d = CLLocationCoordinate2DMake(cpyInfoModel.y, cpyInfoModel.x)
            } else {
                 self.showHint("当前企业不含地理位置信息", duration: 2, yOffset: 0)
                
                }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        _mapView.viewWillDisappear()
        _mapView.delegate = nil
        routeSearch.delegate = nil
    }
    
    // MARK: - IBAction
    
    @IBAction func busRouteSearch(sender: UIButton) {
        let loc = setLoc()
        let transitRouteSearchOption = BMKTransitRoutePlanOption()
        transitRouteSearchOption.city = cityName
        transitRouteSearchOption.from = loc.from
        transitRouteSearchOption.to = loc.to
        
        
        let flag = routeSearch.transitSearch(transitRouteSearchOption)
        if flag {
            print("公交检索发送成功")
        }else {
            print("公交检索发送失败")
        }
    }
   
    
    @IBAction func carRouteSearch(sender: UIButton) {
       let  loc = setLoc()
        
        let drivingRouteSearchOption = BMKDrivingRoutePlanOption()
        drivingRouteSearchOption.from = loc.from
        drivingRouteSearchOption.to = loc.to
        
        let flag = routeSearch.drivingSearch(drivingRouteSearchOption)
        if flag {
            print("驾乘检索发送成功")
        }else {
            print("驾乘检索发送失败")
        }
    }
    
    @IBAction func walkRouteSearch(sender: UIButton) {
    
         let loc = setLoc()
        let walkingRouteSearchOption = BMKWalkingRoutePlanOption()
        walkingRouteSearchOption.from = loc.from
        walkingRouteSearchOption.to = loc.to
        let flag = routeSearch.walkingSearch(walkingRouteSearchOption)
        
        if flag {
            print("步行检索发送成功")
        }else {
            print("步行检索发送失败")
        }
        
    }
    
    @IBAction func rideRouteSearch(sender: UIButton) {
        let loc = setLoc()
        let option = BMKRidingRoutePlanOption()
        option.from = loc.from
        option.to = loc.to
        let flag = routeSearch.ridingSearch(option)
        
        if flag {
            print("骑行检索发送成功")
        }else {
            print("骑行检索发送失败")
        }
    }
    
    
    func wayPointsRouteSearch() {
        let wayPointsRouteSearch = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("WayPointsSearchDemoViewController")
        self.navigationController!.pushViewController(wayPointsRouteSearch, animated: true)
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        fromAddressField.resignFirstResponder()
        toAddressField.resignFirstResponder()
        return true
    }
    
    //导航信息设置
    func setLoc()->(from:BMKPlanNode,to:BMKPlanNode){
        let from = BMKPlanNode()
        let to = BMKPlanNode()
        if AppTools.isEmpty(fromAddressField.text!) && AppTools.isEmpty(toAddressField.text!){
            //用经纬度查询路径
            //起点经纬度为当前位置
            from.pt = startCc2d
            //目的地经纬度为公司经纬度
            to.pt = endCc2d
        }else {
            from.name = fromAddressField.text
            from.cityName = cityName
            to.name = toAddressField.text
            to.cityName = cityName
            
        }
        return(from,to)
    }
    
    // MARK: - BMKRouteSearchDelegate
    
    /**
     *返回公交搜索结果
     *@param searcher 搜索对象
     *@param result 搜索结果，类型为BMKTransitRouteResult
     *@param error 错误号，@see BMKSearchErrorCode
     */
    func onGetTransitRouteResult(searcher: BMKRouteSearch!, result: BMKTransitRouteResult!, errorCode error: BMKSearchErrorCode) {
        print("onGetTransitRouteResult: \(error)")
        
        _mapView.removeAnnotations(_mapView.annotations)
        _mapView.removeOverlays(_mapView.overlays)
        
        if error == BMK_SEARCH_NO_ERROR {
            let plan = result.routes[0] as! BMKTransitRouteLine
            
            let size = plan.steps.count
            var planPointCounts = 0
            for i in 0..<size {
                let transitStep = plan.steps[i] as! BMKTransitStep
                if i == 0 {
                    let item = RouteAnnotation()
                    item.coordinate = plan.starting.location
                    item.title = "起点"
                    item.type = 0
                    _mapView.addAnnotation(item)  // 添加起点标注
                }else if i == size - 1 {
                    let item = RouteAnnotation()
                    item.coordinate = plan.terminal.location
                    item.title = "终点"
                    item.type = 1
                    _mapView.addAnnotation(item)  // 添加终点标注
                }
                let item = RouteAnnotation()
                item.coordinate = transitStep.entrace.location
                item.title = transitStep.instruction
                item.type = 3
                _mapView.addAnnotation(item)
                
                // 轨迹点总数累计
                planPointCounts = Int(transitStep.pointsCount) + planPointCounts
            }
            
            // 轨迹点
            var tempPoints = Array(count: planPointCounts, repeatedValue: BMKMapPoint(x: 0, y: 0))
            var i = 0
            for j in 0..<size {
                let transitStep = plan.steps[j] as! BMKTransitStep
                for k in 0..<Int(transitStep.pointsCount) {
                    tempPoints[i].x = transitStep.points[k].x
                    tempPoints[i].y = transitStep.points[k].y
                    i += 1
                }
            }
            
            // 通过 points 构建 BMKPolyline
            let polyLine = BMKPolyline(points: &tempPoints, count: UInt(planPointCounts))
            // 添加路线 overlay
            _mapView.addOverlay(polyLine)
            
            mapViewFitPolyLine(polyLine)
        }
    }
    
    /**
     *返回驾乘搜索结果
     *@param searcher 搜索对象
     *@param result 搜索结果，类型为BMKDrivingRouteResult
     *@param error 错误号，@see BMKSearchErrorCode
     */
    func onGetDrivingRouteResult(searcher: BMKRouteSearch!, result: BMKDrivingRouteResult!, errorCode error: BMKSearchErrorCode) {
        print("onGetDrivingRouteResult: \(error)")
        
        _mapView.removeAnnotations(_mapView.annotations)
        _mapView.removeOverlays(_mapView.overlays)
        
        if error == BMK_SEARCH_NO_ERROR {
            let plan = result.routes[0] as! BMKDrivingRouteLine
            
            let size = plan.steps.count
            var planPointCounts = 0
            for i in 0..<size {
                let transitStep = plan.steps[i] as! BMKDrivingStep
                if i == 0 {
                    let item = RouteAnnotation()
                    item.coordinate = plan.starting.location
                    item.title = "起点"
                    item.type = 0
                    _mapView.addAnnotation(item)  // 添加起点标注
                }else if i == size - 1 {
                    let item = RouteAnnotation()
                    item.coordinate = plan.terminal.location
                    item.title = "终点"
                    item.type = 1
                    _mapView.addAnnotation(item)  // 添加终点标注
                }
                
                // 添加 annotation 节点
                let item = RouteAnnotation()
                item.coordinate = transitStep.entrace.location
                item.title = transitStep.instruction
                item.degree = Int(transitStep.direction) * 30
                item.type = 4
                _mapView.addAnnotation(item)
                
                // 轨迹点总数累计
                planPointCounts = Int(transitStep.pointsCount) + planPointCounts
            }
            
            // 添加途径点
            if plan.wayPoints != nil {
                for tempNode in plan.wayPoints as! [BMKPlanNode] {
                    let item = RouteAnnotation()
                    item.coordinate = tempNode.pt
                    item.type = 5
                    item.title = tempNode.name
                    _mapView.addAnnotation(item)
                }
            }
            
            // 轨迹点
            var tempPoints = Array(count: planPointCounts, repeatedValue: BMKMapPoint(x: 0, y: 0))
            var i = 0
            for j in 0..<size {
                let transitStep = plan.steps[j] as! BMKDrivingStep
                for k in 0..<Int(transitStep.pointsCount) {
                    tempPoints[i].x = transitStep.points[k].x
                    tempPoints[i].y = transitStep.points[k].y
                    i += 1
                }
            }
            
            // 通过 points 构建 BMKPolyline
            let polyLine = BMKPolyline(points: &tempPoints, count: UInt(planPointCounts))
            // 添加路线 overlay
            _mapView.addOverlay(polyLine)
            mapViewFitPolyLine(polyLine)
        }
    }
    
    /**
     *返回步行搜索结果
     *@param searcher 搜索对象
     *@param result 搜索结果，类型为BMKWalkingRouteResult
     *@param error 错误号，@see BMKSearchErrorCode
     */
    func onGetWalkingRouteResult(searcher: BMKRouteSearch!, result: BMKWalkingRouteResult!, errorCode error: BMKSearchErrorCode) {
        print("onGetWalkingRouteResult: \(error)")
        _mapView.removeAnnotations(_mapView.annotations)
        _mapView.removeOverlays(_mapView.overlays)
        
        if error == BMK_SEARCH_NO_ERROR {
            let plan = result.routes[0] as! BMKWalkingRouteLine
            
            let size = plan.steps.count
            var planPointCounts = 0
            for i in 0..<size {
                let transitStep = plan.steps[i] as! BMKWalkingStep
                if i == 0 {
                    let item = RouteAnnotation()
                    item.coordinate = plan.starting.location
                    item.title = "起点"
                    item.type = 0
                    _mapView.addAnnotation(item)  // 添加起点标注
                }else if i == size - 1 {
                    let item = RouteAnnotation()
                    item.coordinate = plan.terminal.location
                    item.title = "终点"
                    item.type = 1
                    _mapView.addAnnotation(item)  // 添加终点标注
                }
                // 添加 annotation 节点
                let item = RouteAnnotation()
                item.coordinate = transitStep.entrace.location
                item.title = transitStep.entraceInstruction
                item.degree = Int(transitStep.direction) * 30
                item.type = 4
                _mapView.addAnnotation(item)
                
                // 轨迹点总数累计
                planPointCounts = Int(transitStep.pointsCount) + planPointCounts
            }
            
            // 轨迹点
            var tempPoints = Array(count: planPointCounts, repeatedValue: BMKMapPoint(x: 0, y: 0))
            var i = 0
            for j in 0..<size {
                let transitStep = plan.steps[j] as! BMKWalkingStep
                for k in 0..<Int(transitStep.pointsCount) {
                    tempPoints[i].x = transitStep.points[k].x
                    tempPoints[i].y = transitStep.points[k].y
                    i += 1
                }
            }
            
            // 通过 points 构建 BMKPolyline
            let polyLine = BMKPolyline(points: &tempPoints, count: UInt(planPointCounts))
            _mapView.addOverlay(polyLine)  // 添加路线 overlay
            mapViewFitPolyLine(polyLine)
        }
    }
    
    /**
     *返回骑行搜索结果
     *@param searcher 搜索对象
     *@param result 搜索结果，类型为BMKRidingRouteResult
     *@param error 错误号，@see BMKSearchErrorCode
     */
    func onGetRidingRouteResult(searcher: BMKRouteSearch!, result: BMKRidingRouteResult!, errorCode error: BMKSearchErrorCode) {
        print("onGetRidingRouteResult: \(error)")
        _mapView.removeAnnotations(_mapView.annotations)
        _mapView.removeOverlays(_mapView.overlays)
        
        if error == BMK_SEARCH_NO_ERROR {
            let plan = result.routes[0] as! BMKRidingRouteLine
            
            let size = plan.steps.count
            var planPointCounts = 0
            for i in 0..<size {
                let transitStep = plan.steps[i] as! BMKRidingStep
                if i == 0 {
                    let item = RouteAnnotation()
                    item.coordinate = plan.starting.location
                    item.title = "起点"
                    item.type = 0
                    _mapView.addAnnotation(item)  // 添加起点标注
                } else if i == size - 1 {
                    let item = RouteAnnotation()
                    item.coordinate = plan.terminal.location
                    item.title = "终点"
                    item.type = 1
                    _mapView.addAnnotation(item)  // 添加终点标注
                }
                // 添加 annotation 节点
                let item = RouteAnnotation()
                item.coordinate = transitStep.entrace.location
                item.title = transitStep.entraceInstruction
                item.degree = Int(transitStep.direction) * 30
                item.type = 4
                _mapView.addAnnotation(item)
                
                // 轨迹点总数累计
                planPointCounts = Int(transitStep.pointsCount) + planPointCounts
            }
            
            // 轨迹点
            var tempPoints = Array(count: planPointCounts, repeatedValue: BMKMapPoint(x: 0, y: 0))
            var i = 0
            for j in 0..<size {
                let transitStep = plan.steps[j] as! BMKRidingStep
                for k in 0..<Int(transitStep.pointsCount) {
                    tempPoints[i].x = transitStep.points[k].x
                    tempPoints[i].y = transitStep.points[k].y
                    i += 1
                }
            }
            
            // 通过 points 构建 BMKPolyline
            let polyLine = BMKPolyline(points: &tempPoints, count: UInt(planPointCounts))
            _mapView.addOverlay(polyLine)  // 添加路线 overlay
            mapViewFitPolyLine(polyLine)
        }
    }
    
    // MARK: - BMKMapViewDelegate
    
    /**
     *根据anntation生成对应的View
     *@param mapView 地图View
     *@param annotation 指定的标注
     *@return 生成的标注View
     */
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        let routeAnnotation = annotation
        if routeAnnotation is RouteAnnotation{
           return getViewForRouteAnnotation(routeAnnotation as? RouteAnnotation )
        }else{
        
        }
        

        return nil
    }
    
    /**
     *根据overlay生成对应的View
     *@param mapView 地图View
     *@param overlay 指定的overlay
     *@return 生成的覆盖物View
     */
    func mapView(mapView: BMKMapView!, viewForOverlay overlay: BMKOverlay!) -> BMKOverlayView! {
        if overlay as! BMKPolyline? != nil {
            let polylineView = BMKPolylineView(overlay: overlay as! BMKPolyline)
            polylineView.strokeColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.7)
            polylineView.lineWidth = 3
            return polylineView
        }
        return nil
    }
    
    // MARK: -
    
    func getViewForRouteAnnotation(routeAnnotation: RouteAnnotation!) -> BMKAnnotationView? {
        var view: BMKAnnotationView?
        
        var imageName: String?
        switch routeAnnotation.type {
        case 0:
            imageName = "nav_start"
        case 1:
            imageName = "nav_end"
        case 2:
            imageName = "nav_bus"
        case 3:
            imageName = "nav_rail"
        case 4:
            imageName = "direction"
        case 5:
            imageName = "nav_waypoint"
        default:
            return nil
        }
        let identifier = "\(imageName)_annotation"
        view = _mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
        if view == nil {
            view = BMKAnnotationView(annotation: routeAnnotation, reuseIdentifier: identifier)
            view?.centerOffset = CGPointMake(0, -(view!.frame.size.height * 0.5))
            view?.canShowCallout = true
        }
        
        view?.annotation = routeAnnotation
        
        let bundlePath = NSBundle.mainBundle().resourcePath?.stringByAppendingString("/mapapi.bundle/")
        let bundle = NSBundle(path: bundlePath!)
        if let imagePath = bundle?.resourcePath?.stringByAppendingString("/images/icon_\(imageName!).png") {
            var image = UIImage(contentsOfFile: imagePath)
            if routeAnnotation.type == 4 {
                image = imageRotated(image, degrees: routeAnnotation.degree)
            }
            if image != nil {
                view?.image = image
            }
        }
        
        return view
    }
    
    
    //根据polyline设置地图范围
    func mapViewFitPolyLine(polyline: BMKPolyline!) {
        if polyline.pointCount < 1 {
            return
        }
        
        let pt = polyline.points[0]
        var ltX = pt.x
        var rbX = pt.x
        var ltY = pt.y
        var rbY = pt.y
        
        for i in 1..<polyline.pointCount {
            let pt = polyline.points[Int(i)]
            if pt.x < ltX {
                ltX = pt.x
            }
            if pt.x > rbX {
                rbX = pt.x
            }
            if pt.y > ltY {
                ltY = pt.y
            }
            if pt.y < rbY {
                rbY = pt.y
            }
        }
        
        let rect = BMKMapRectMake(ltX, ltY, rbX - ltX, rbY - ltY)
        _mapView.visibleMapRect = rect
        _mapView.zoomLevel = _mapView.zoomLevel - 0.3
    }
    
    //旋转图片
    func imageRotated(image: UIImage!, degrees: Int!) -> UIImage {
        let width = CGImageGetWidth(image.CGImage)
        let height = CGImageGetHeight(image.CGImage)
        let rotatedSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(rotatedSize);
        let bitmap = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
        CGContextRotateCTM(bitmap, CGFloat(Double(degrees) * M_PI / 180.0));
        CGContextRotateCTM(bitmap, CGFloat(M_PI));
        CGContextScaleCTM(bitmap, -1.0, 1.0);
        CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), image.CGImage);
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }
}

