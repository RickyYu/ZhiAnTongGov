//
//  NetworkTool.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2016/11/23.
//  Copyright © 2016年 safetysafetys. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD


class NetworkTool: Alamofire.Manager {
    // MARK: - 单例
    internal static let sharedTools: NetworkTool = {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var header : Dictionary =  Manager.defaultHTTPHeaders
        configuration.HTTPAdditionalHeaders = Manager.defaultHTTPHeaders
        return NetworkTool(configuration: configuration)
        
    }()
    
    //MARK: - 登陆
    func login(parameters:[String:AnyObject],finished:(login:Login!,error:String!)->()){
          SVProgressHUD.showWithStatus("正在加载...")
        let identify = ""
        var addParameters = parameters
        addParameters["client"] = "ios"
        let key = "SAFETYS_CLIENT_AUTH_KEY_2016="+identify
        let headers = [
            "Cookie": key,
            "Accept-Language" : "zh-CN,zh;q=0.8,en;q=0.6"
        ]
        //"Content-Type": "application/json;charset=UTF-8"  加上此header报type不能为空
        request(.POST, AppTools.getServiceURLWithYh("LOGIN"), parameters: addParameters, encoding: .URL, headers: headers).responseJSON(queue: dispatch_get_main_queue(), options: []){(response) in
            guard response.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(login:nil,error: "服务器异常")
                return
            }
            if let dictValue = response.result.value{
                let dict = JSON(dictValue)
                print("login.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                //  字典转成模型
                if success {
                    let login = Login(json:dict)
                    finished(login: login, error: nil)
                    
                }else{
                    
                    finished(login: nil,error: message) //success  false
                }
                SVProgressHUD.dismiss()
            }else {
                finished(login: nil,error: "数据异常")
            }
        }
        
        
        
//        sendPostRequest(AppTools.getServiceURLWithYh("LOGIN"), parameters: parameters) { (response) in
//            guard response!.result.isSuccess else {
//                SVProgressHUD.showErrorWithStatus("加载失败...")
//                finished(login:nil,error: "服务器异常")
//                return
//            }
//            if let dictValue = response!.result.value{
//                let dict = JSON(dictValue)
//                print("login.dict = \(dict)")
//                let success = dict["success"].boolValue
//                let message = dict["msg"].stringValue
//                //  字典转成模型
//                if success {
//                  let login = Login(json:dict)
//                    finished(login: login, error: nil)
//                    
//                }else{
//                    
//                    finished(login: nil,error: message) //success  false
//                }
//                SVProgressHUD.dismiss()
//            }else {
//                finished(login: nil,error: "数据异常")
//            }
//            
//            
//        }
        
    }
    //MARK: - 修改密码
    func changePwd(parameters:[String:AnyObject],finished:(login:Login!,error:String!)->()){
         SVProgressHUD.showWithStatus("正在加载...")
        sendPostRequest(AppTools.getServiceURLWithYh("CHANGE_PASSWORD"), parameters: parameters) { (response) in
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(login:nil,error: "服务器异常")
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("getArticle.dict = \(dict)")
                let login = Login(json:dict)
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                //  字典转成模型
                if success {
                        finished(login: login, error: nil)
                    
                }else{
                    finished(login: nil,error: message) //success  false
                }
                SVProgressHUD.dismiss()
            }else {
                finished(login: nil,error: "数据异常")
            }
        }

    }

     //MARK: - 行政执法-》检查记录
    //MARK: - 获取企业信息列表
    func loadCompanys(parameters:[String:AnyObject],isYh:Bool,finished:(cpyInfoModels:[CpyInfoModel]!,error:String!,totalCount:Int!)->()){
        SVProgressHUD.showWithStatus("正在加载...")
        var url : String
        if isYh{
        url = AppTools.getServiceURLWithYh("LOAD_COMPANYS")
        }else{
            url = AppTools.getServiceURLWithDa("LOAD_COMPANYS")
        }
        self.sendPostRequest(url, parameters: parameters) { (response) in
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(cpyInfoModels:nil,error: "服务器异常",totalCount: nil)
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("loadCompanys.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                let totalCount = dict["totalCount"].intValue
                //  字典转成模型
                if success {
                    if let items = dict["json"].arrayObject {
                        var cpyInfoModels = [CpyInfoModel]()
                        for item in items {
                            let homeItem = CpyInfoModel(dict: item as! [String: AnyObject])
                            cpyInfoModels.append(homeItem)
                        }
                        finished(cpyInfoModels: cpyInfoModels,error: nil,totalCount: totalCount)
                        //  保存在本地 暂无需使用
                        // CpyInfoModel.savaCpyInfoModels(cpyInfoModels)
                    }
                    
                }else{
                    finished(cpyInfoModels: nil,error: message,totalCount: nil) //success  false
                }
                SVProgressHUD.dismiss()
            }else {
                finished(cpyInfoModels: nil,error: "数据异常",totalCount: nil)
            }
            
        }
    }
    
    
    //MARK: - 更改企业信息
    func updateCompany(parameters:[String:AnyObject],finished:(cpyInfoModels:[CpyInfoModel]!,error:String!,totalCount:Int!)->()){
        SVProgressHUD.showWithStatus("正在加载...")
    
        self.sendPostRequest(AppTools.getServiceURLWithDa("UPDATE_COMPANY"), parameters: parameters) { (response) in
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(cpyInfoModels:nil,error: "服务器异常",totalCount: nil)
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("loadCompanys.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                //  字典转成模型
                if success {
//                    if let items = dict["json"].arrayObject {
//                        var cpyInfoModels = [CpyInfoModel]()
//                        for item in items {
//                            let homeItem = CpyInfoModel(dict: item as! [String: AnyObject])
//                            cpyInfoModels.append(homeItem)
//                        }
//                        finished(cpyInfoModels: cpyInfoModels,error: nil,totalCount: totalCount)
                        //  保存在本地 暂无需使用
                        // CpyInfoModel.savaCpyInfoModels(cpyInfoModels)
//                    }
                    
                }else{
                    finished(cpyInfoModels: nil,error: message,totalCount: nil) //success  false
                }
                SVProgressHUD.dismiss()
            }else {
                finished(cpyInfoModels: nil,error: "数据异常",totalCount: nil)
            }
            
        }
    }
    
    
    
    
    //MARK:获取企业经纬度
    func getPoint(parameters:[String:AnyObject],finished:(locInfoModel:LocInfoModel!,error:String!)->()){
        SVProgressHUD.showWithStatus("正在加载...")
        print(AppTools.getServiceURLWithDa("GET_POINT"))
        self.sendPostRequest(AppTools.getServiceURLWithDa("GET_POINT"), parameters: parameters) { (response) in
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(locInfoModel:nil,error: "服务器异常")
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("getPoint.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                //  字典转成模型
                if success {
    
                    let data = LocInfoModel(dict:dict["entity"].dictionaryObject!)
                    finished(locInfoModel: data, error: nil)
                }else{
                    finished(locInfoModel: nil,error: message) //success  false
                }
                SVProgressHUD.dismiss()
            }else {
                finished(locInfoModel: nil,error: "数据异常")
            }
            
        }
    }
    

    //MARK:保存企业经纬度
    func savePoint(parameters:[String:AnyObject],finished:(cpyInfoModels:[CpyInfoModel]!,error:String!,totalCount:Int!)->()){
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithDa("SAVE_POINT"), parameters: parameters) { (response) in
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(cpyInfoModels:nil,error: "服务器异常",totalCount: nil)
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("savePoint.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                let totalCount = dict["totalCount"].intValue
                //  字典转成模型
                if success {
                        finished(cpyInfoModels: nil,error: nil,totalCount: totalCount)

                }else{
                    finished(cpyInfoModels: nil,error: message,totalCount: nil) //success  false
                }
                SVProgressHUD.dismiss()
            }else {
                finished(cpyInfoModels: nil,error: "数据异常",totalCount: nil)
            }
            
        }
    }
    
    
    
    
    
    //MARK:  获取企业检查记录列表
    func loadGovRecords(parameters:[String:AnyObject],finished:(recordInfoModels:[RecordInfoModel]!,error:String!,totalCount :Int!)->()){
         SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("LOAD_GOV_RECORD_LIST"), parameters: parameters) { (response) in
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(recordInfoModels:nil,error: "服务器异常",totalCount: nil)
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("loadGovRecords.dict = \(dict)")
                let success = dict["success"].boolValue
                let message :String = dict["msg"].stringValue
                let totalCount = dict["totalCount"].intValue
                //  字典转成模型
                if success {
                if let items = dict["json"].arrayObject {
                    var recordInfoModels = [RecordInfoModel]()
                    for item in items {
                        let homeItem = RecordInfoModel(dict: item as! [String: AnyObject])
                        recordInfoModels.append(homeItem)
                    }
                    finished(recordInfoModels: recordInfoModels,error: nil,totalCount: totalCount)
                  }
                    
                }else{
                    finished(recordInfoModels: nil,error: message,totalCount: nil) //success  false
                }
                SVProgressHUD.dismiss()
                
            }else {
                finished(recordInfoModels: nil,error: "数据异常",totalCount: nil)
            }
        }
    }
    
    
    
    //MARK:  新增：检查记录 --基本信息
    func loadCompanyGrid(parameters:[String:AnyObject],finished:(data:CheckRecordInfoModel!,error:String!)->()){
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("GET_COMPANY_GRID"), parameters: parameters) { (response) in
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(data:nil,error: "服务器异常")
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("loadRecordDetail.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                //  字典转成模型
                if success {
                    let data = CheckRecordInfoModel(dict:dict)
                    finished(data: data, error: nil)
                    
                }else{
                    finished(data: nil,error: message) //success  false
                }
                SVProgressHUD.dismiss()
                
            }else {
                finished(data: nil,error: "数据异常")
            }
        }
    }
    
    
    //提交，新增检查记录
    func createCheckRecordImage(parameters:[String:AnyObject],imageArrays:[UIImage],finished:(data:CheckRecordInfoModel!,error:String!,noteId:String!)->()){
        SVProgressHUD.showWithStatus("正在加载...")
        let identify = AppTools.loadNSUserDefaultsValue("identify") as! String
        var addParameters = parameters
        addParameters["client"] = "ios"
        let key = "SAFETYS_CLIENT_AUTH_KEY_2016="+identify
        let headers = [
            "Cookie": key,
            "Accept-Language" : "zh-CN,zh;q=0.8,en;q=0.6"
        ]
 
        upload(.POST, AppTools.getServiceURLWithYh("CREATE_CHECK_RECORD"), headers:headers,multipartFormData: { (multipartFormData) in
            
            print("imageArrays.count = \(imageArrays.count)")
            if !imageArrays.isEmpty{
            for i in 0..<imageArrays.count{
                let data = UIImageJPEGRepresentation(imageArrays[i] , 0.5)
                let randomNum :Int = AppTools.createRandomMan(0, end: 100000)()
                let imageName = String(NSDate()) + "\(randomNum).jpg"
                print("imageName = \(imageName)")
                multipartFormData.appendBodyPart(data: data!, name: "file[\(i)]", fileName: imageName, mimeType: "image/jpg")
                multipartFormData.appendBodyPart(data: imageName.dataUsingEncoding(NSUTF8StringEncoding)!, name: "fileFileName[\(i)]" )
              }
            }

            // 这里就是绑定参数的地方 param 是需要上传的参数，我这里是封装了一个方法从外面传过来的参数，你可以根据自己的需求用NSDictionary封装一个param
            for (key, value) in parameters {
                print("key = \(key)value = \(value)")
                assert(value is String, "参数必须能够转换为NSData的类型，比如String")
                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key )
                
            }
            
        }) { (encodingResult) in
            switch encodingResult {
            case .Success(let upload, _, _):
                upload.responseJSON(completionHandler: { (response) in
                    //completeBlock(responseObject: response.result.value!, error: nil)
                    if let dictValue = response.result.value{
                        let dict = JSON(dictValue)
                        print("createCheckRecord.dict = \(dict)")
                        let success = dict["success"].boolValue
                        let message = dict["msg"].stringValue
                        //  字典转成模型
                        if success {
                        let json =  JSON(data: (dict["entity"].string!).dataUsingEncoding(NSUTF8StringEncoding)!)
                           finished(data: nil,error: nil,noteId: String(json["noteId"].int!)) //success  false
                          
                        }else{
                            finished(data: nil,error: message,noteId: "") //success  false
                        }
                        SVProgressHUD.dismiss()
                        
                    }else {
                        finished(data: nil,error: "数据异常",noteId: "")
                    }
                    
                })
            case .Failure( _):
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(data:nil,error: "服务器异常",noteId: "")
            }
        }
    }
    //提交一般隐患记录
//    func createCheckRecord(parameters:[String:AnyObject],finished:(data:CheckRecordInfoModel!,error:String!)->()){
//                SVProgressHUD.showWithStatus("正在加载...")
//                print("AppTools.getServiceURLWithYh = \(AppTools.getServiceURLWithYh("CREATE_CHECK_RECORD"))")
//                self.sendPostRequest(AppTools.getServiceURLWithYh("CREATE_CHECK_RECORD"), parameters: parameters) { (response) in
//                    print("createCheckRecord.dict = \(response!)")
//                    guard response!.result.isSuccess else {
//                        SVProgressHUD.showErrorWithStatus("加载失败...")
//                        finished(data:nil,error: "服务器异常")
//                        return
//                    }
//                    if let dictValue = response!.result.value{
//                        let dict = JSON(dictValue)
//                        print("createCheckRecord.dict = \(dict)")
//                        let success = dict["success"].boolValue
//                        let message = dict["msg"].stringValue
//                        //  字典转成模型123
//                        if success {
//                          //  let data = CheckRecordInfoModel(dict:dict)
//                         finished(data: nil, error: nil)
//        
//                        }else{
//                            finished(data: nil,error: message) //success  false
//                        }
//                        SVProgressHUD.dismiss()
//                        
//                    }else {
//                        finished(data: nil,error: "数据异常")
//                    }
//                }
//    
//    }
    
    
    
    
    //提交一般隐患记录
//    func createHiddenTrouble(parameters:[String:AnyObject],finished:(data:CheckRecordInfoModel!,error:String!)->()){
//        SVProgressHUD.showWithStatus("正在加载...")
//        self.sendPostRequest(AppTools.getServiceURLWithYh("CREATE_HIDDEN_TROUBLE"), parameters: parameters) { (response) in
//            guard response!.result.isSuccess else {
//                SVProgressHUD.showErrorWithStatus("加载失败...")
//                finished(data:nil,error: "服务器异常")
//                return
//            }
//            if let dictValue = response!.result.value{
//                let dict = JSON(dictValue)
//                print("loadRecordDetail.dict = \(dict)")
//                let success = dict["success"].boolValue
//                let message = dict["msg"].stringValue
//                //  字典转成模型
//                if success {
//                    let data = CheckRecordInfoModel(dict:dict)
//                    finished(data: data, error: nil)
//                    
//                }else{
//                    finished(data: nil,error: message) //success  false
//                }
//                SVProgressHUD.dismiss()
//                
//            }else {
//                finished(data: nil,error: "数据异常")
//            }
//        }
//    }
    //提交一般隐患
    func createHiddenTrouble(parameters:[String:AnyObject],imageArrays:[UIImage],finished:(data:CheckRecordInfoModel!,error:String!)->()){
        SVProgressHUD.showWithStatus("正在加载...")
        let identify = AppTools.loadNSUserDefaultsValue("identify") as! String
        var addParameters = parameters
        addParameters["client"] = "ios"
        let key = "SAFETYS_CLIENT_AUTH_KEY_2016="+identify
        let headers = [
            "Cookie": key,
            "Accept-Language" : "zh-CN,zh;q=0.8,en;q=0.6"
        ]
        
        upload(.POST, AppTools.getServiceURLWithYh("CREATE_HIDDEN_TROUBLE"), headers:headers,multipartFormData: { (multipartFormData) in
            
            print("imageArrays.count = \(imageArrays.count)")
            if !imageArrays.isEmpty{
                for i in 0..<imageArrays.count{
                    let data = UIImageJPEGRepresentation(imageArrays[i] , 0.5)
                    let randomNum :Int = AppTools.createRandomMan(0, end: 100000)()
                    let imageName = String(NSDate()) + "\(randomNum).jpg"
                    print("imageName = \(imageName)")
                    multipartFormData.appendBodyPart(data: data!, name: "file[\(i)]", fileName: imageName, mimeType: "image/jpg")
                    multipartFormData.appendBodyPart(data: imageName.dataUsingEncoding(NSUTF8StringEncoding)!, name: "fileFileName[\(i)]" )
                }
            }
            
            // 这里就是绑定参数的地方 param 是需要上传的参数，我这里是封装了一个方法从外面传过来的参数，你可以根据自己的需求用NSDictionary封装一个param
            for (key, value) in parameters {
                print("key = \(key)value = \(value)")
                assert(value is String, "参数必须能够转换为NSData的类型，比如String")
                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key )
                
            }
            
        }) { (encodingResult) in
            switch encodingResult {
            case .Success(let upload, _, _):
                upload.responseJSON(completionHandler: { (response) in
                    //completeBlock(responseObject: response.result.value!, error: nil)
                    if let dictValue = response.result.value{
                        let dict = JSON(dictValue)
                        print("CREATE_HIDDEN_TROUBLE.dict = \(dict)")
                        let success = dict["success"].boolValue
                        let message = dict["msg"].stringValue
                        //  字典转成模型
                        if success {
                           
                            finished(data: nil,error: nil) //success  false
                            
                        }else{
                            finished(data: nil,error: message) //success  false
                        }
                        SVProgressHUD.dismiss()
                        
                    }else {
                        finished(data: nil,error: "数据异常")
                    }
                    
                })
            case .Failure( _):
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(data:nil,error: "服务器异常")
            }
        }
    }

    
    
    //提交重大隐患
    
    func createDanger(parameters:[String:AnyObject],imageArrays:[UIImage],finished:(data:CheckRecordInfoModel!,error:String!)->()){
        SVProgressHUD.showWithStatus("正在加载...")
        let identify = AppTools.loadNSUserDefaultsValue("identify") as! String
        var addParameters = parameters
        addParameters["client"] = "ios"
        let key = "SAFETYS_CLIENT_AUTH_KEY_2016="+identify
        let headers = [
            "Cookie": key,
            "Accept-Language" : "zh-CN,zh;q=0.8,en;q=0.6"
        ]
        
        upload(.POST, AppTools.getServiceURLWithYh("CREATE_DANGER"), headers:headers,multipartFormData: { (multipartFormData) in
            
            print("imageArrays.count = \(imageArrays.count)")
            if !imageArrays.isEmpty{
                for i in 0..<imageArrays.count{
                    let data = UIImageJPEGRepresentation(imageArrays[i] , 0.5)
                    let randomNum :Int = AppTools.createRandomMan(0, end: 100000)()
                    let imageName = String(NSDate()) + "\(randomNum).jpg"
                    print("imageName = \(imageName)")
                    multipartFormData.appendBodyPart(data: data!, name: "file[\(i)]", fileName: imageName, mimeType: "image/jpg")
                    multipartFormData.appendBodyPart(data: imageName.dataUsingEncoding(NSUTF8StringEncoding)!, name: "fileFileName[\(i)]" )
                }
            }
            
            // 这里就是绑定参数的地方 param 是需要上传的参数，我这里是封装了一个方法从外面传过来的参数，你可以根据自己的需求用NSDictionary封装一个param
            for (key, value) in parameters {
                print("key = \(key)value = \(value)")
                assert(value is String, "参数必须能够转换为NSData的类型，比如String")
                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key )
                
            }
            
        }) { (encodingResult) in
            switch encodingResult {
            case .Success(let upload, _, _):
                upload.responseJSON(completionHandler: { (response) in
                    //completeBlock(responseObject: response.result.value!, error: nil)
                    if let dictValue = response.result.value{
                        let dict = JSON(dictValue)
                        print("createDanger.dict = \(dict)")
                        let success = dict["success"].boolValue
                        let message = dict["msg"].stringValue
                        //  字典转成模型
                        if success {
                            finished(data: nil,error: nil) //success  false
                            
                        }else{
                            finished(data: nil,error: message) //success  false
                        }
                        SVProgressHUD.dismiss()
                        
                    }else {
                        finished(data: nil,error: "数据异常")
                    }
                    
                })
            case .Failure( _):
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(data:nil,error: "服务器异常")
            }
        }
    }

    
    
    //MARK:  记录详情
    func loadRecordDetail(parameters:[String:AnyObject],finished:(data:RecordDetailModel!,error:String!)->()){
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("LOAD_CHECK_RECORD"), parameters: parameters) { (response) in
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(data:nil,error: "服务器异常")
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("loadRecordDetail.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                //  字典转成模型
                if success {
                    
                    let data = RecordDetailModel(dict:dict["entity"].dictionaryObject!)
                    finished(data: data, error: nil)
                    
                }else{
                    finished(data: nil,error: message) //success  false
                }
                SVProgressHUD.dismiss()
                
            }else {
                finished(data: nil,error: "数据异常")
            }
        }
    }
    
    //MARK:  记录详情->隐患详情
    func loadProDangers(parameters:[String:AnyObject],finished:(datas:[CheckHiddenModel]!,error:String!,totalCount:Int!)->()){
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("LOAD_PRO_DANGERS"), parameters: parameters) { (response) in
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(datas:nil,error: "服务器异常",totalCount: nil)
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("loadProDangers.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                 let totalCount = dict["totalCount"].intValue
                //  字典转成模型
                if success {
                    
                    if let items = dict["json"].arrayObject {
                        var listDatas = [CheckHiddenModel]()
                        for item in items {
                            let homeItem = CheckHiddenModel(dict: item as! [String: AnyObject])
                            listDatas.append(homeItem)
                        }
                        finished(datas: listDatas,error: nil,totalCount: totalCount)
                    }
                    
                }else{
                    finished(datas: nil,error: message,totalCount: nil) //success  false
                }
                SVProgressHUD.dismiss()
                
            }else {
                finished(datas: nil,error: "数据异常",totalCount: nil)
            }
        }
    }
    

    //获取行业检查记录表
    func loadIndustrySelect(parameters:[String:AnyObject],finished:(datas:[IndustrySelectModel]!,error:String!,totalCount :Int!)->()){
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("LOAD_INDUSTRY_SELECT"), parameters: parameters) { (response) in
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(datas:nil,error: "服务器异常",totalCount: nil)
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("loadIndustrySelect.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                let totalCount = dict["totalCount"].intValue
                //  字典转成模型
                if success {
                    if let items = dict["json"].arrayObject {
                        var recordInfoModels = [IndustrySelectModel]()
                        for item in items {
                            let homeItem = IndustrySelectModel(dict: item as! [String: AnyObject])
                            recordInfoModels.append(homeItem)
                        }
                        finished(datas: recordInfoModels,error: nil,totalCount: totalCount)
                    }
                    
                }else{
                    finished(datas: nil,error: message,totalCount: nil) //success  false
                }
                SVProgressHUD.dismiss()
                
            }else {
                finished(datas: nil,error: "数据异常",totalCount: nil)
            }
        }
    }
    
    
    //获取行业检查记录表
    func loadIndustrySecondSelect(parameters:[String:AnyObject],finished:(datas:[IndustrySecondSelectModel]!,error:String!,totalCount :Int!)->()){
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("LOAD_INDUSTRY_SECOND_SELECT"), parameters: parameters) { (response) in
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(datas:nil,error: "服务器异常",totalCount: nil)
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("loadIndustrySecondSelect.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                let totalCount = dict["totalCount"].intValue
                //  字典转成模型
                if success {
                    if let items = dict["json"].arrayObject {
                        var recordInfoModels = [IndustrySecondSelectModel]()
                        for item in items {
                            let homeItem = IndustrySecondSelectModel(dict: item as! [String: AnyObject])
                            recordInfoModels.append(homeItem)
                        }
                        finished(datas: recordInfoModels,error: nil,totalCount: totalCount)
                    }
                    
                }else{
                    finished(datas: nil,error: message,totalCount: nil) //success  false
                }
                SVProgressHUD.dismiss()
                
            }else {
                finished(datas: nil,error: "数据异常",totalCount: nil)
            }
        }
    }

    
    
    //MARK:  处罚模块 ->加载企业信息
    func loadCompanyInfo(parameters:[String:AnyObject],finished:(data:CompanyInfoModel!,error:String!)->()){
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("LOAD_COMPANY_INFO"), parameters: parameters) { (response) in
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(data:nil,error: "服务器异常")
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("loadCompanyInfo.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                //  字典转成模型
                if success {
                    let data = CompanyInfoModel(dict:dict["entity"].dictionaryObject!)
                    finished(data: data, error: nil)
                    
                }else{
                    finished(data: nil,error: message) //success  false
                }
                SVProgressHUD.dismiss()
                
            }else {
                finished(data: nil,error: "数据异常")
            }
        }
    }
    
    //MARK:  一般隐患查看
    func loadNormalDanger(parameters:[String:AnyObject],finished:(data:HiddenDetailModel!,error:String!)->()){
        SVProgressHUD.showWithStatus("正在加载...")
        print(AppTools.getServiceURLWithYh("LOAD_NORMAL_DANGER"))
        self.sendPostRequest(AppTools.getServiceURLWithYh("LOAD_NORMAL_DANGER"), parameters: parameters) { (response) in
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(data:nil,error: "服务器异常")
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("loadNormalDanger.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                //  字典转成模型
                if success {
                    let data = HiddenDetailModel(dict:dict["entity"].dictionaryObject!)
                    finished(data: data, error: nil)
                    
                }else{
                    finished(data: nil,error: message) //success  false
                }
                SVProgressHUD.dismiss()
                
            }else {
                finished(data: nil,error: "数据异常")
            }
        }
    }
    
    //MARK:  处罚页面  ->隐患列表
    func loadHideenTroubles(parameters:[String:AnyObject],finished:(datas:[HiddenModel]!,error: String!,totalCount:Int!)->()){
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("LOAD_HIDDEN_TROUBLES"), parameters: parameters) { (response) in
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(datas:nil,error: "服务器异常",totalCount: nil)
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("loadHideenTroubles.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                let totalCount = dict["totalCount"].intValue
                //  字典转成模型
                if success {
                    if let items = dict["json"].arrayObject {
                        var listDatas = [HiddenModel]()
                        for item in items {
                            let homeItem = HiddenModel(dict: item as! [String: AnyObject])
                            listDatas.append(homeItem)
                        }
                        finished(datas: listDatas,error: nil,totalCount: totalCount)
                        
                    }
                    
                    
                }else{
                    finished(datas: nil,error: message,totalCount: nil) //success  false
                }
                SVProgressHUD.dismiss()
            }else {
                finished(datas: nil,error: "数据异常",totalCount: nil)
            }
            
        }
    }
    
    
    
    //MARK:  处罚页面  ->历史复查记录
    func loadHistoryProduces(parameters:[String:AnyObject],finished:(datas:[HistoryReviewModel]!,error:String!,totalCount:Int!)->()){
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("LOAD_HISTORY_PRODUCE"), parameters: parameters) { (response) in
            
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(datas:nil,error: "服务器异常",totalCount: nil)
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("loadProduceCallBacks.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                let totalCount = dict["totalCount"].intValue
                //  字典转成模型
                if success {
                    if let items = dict["json"].arrayObject {
                        var listDatas = [HistoryReviewModel]()
                        for item in items {
                            let homeItem = HistoryReviewModel(dict: item as! [String: AnyObject])
                            listDatas.append(homeItem)
                        }
                        finished(datas: listDatas,error: nil,totalCount: totalCount)
                        
                    }
                }else{
                    finished(datas: nil,error: message,totalCount: nil) //success  false
                }
                SVProgressHUD.dismiss()
            }else {
                finished(datas: nil,error: "数据异常",totalCount: nil)
            }
            
        }
    }
    
    //MARK:  处罚页面  ->提交
    func  submitPunishment(parameters:[String:AnyObject],finished:(recordInfoModels:[RecordInfoModel]!,error:String!)->()){
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("CREATE_PUNISHMENT"), parameters: parameters) { (response) in
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(recordInfoModels:nil,error: "服务器异常")
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("submitPunishment.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                //  字典转成模型
                if success {
                    finished(recordInfoModels: nil,error: nil)
                }else{
                    finished(recordInfoModels: nil,error: message) //success  false
                }
                SVProgressHUD.dismiss()
                
            }else {
                finished(recordInfoModels: nil,error: "数据异常")
            }
        }
    }
    
    
    
    
    
    
    //MARK: - 信息查询模块 获取政策条款信息
    func getLawInfoList(parameters:[String:AnyObject],finished: (infos: [Info]!, error: String!,totalCount:Int!)->()) {
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithDa("GET_LAW_INFO_LIST"), parameters: parameters) { (response) in
            
            guard response!.result.isSuccess else {
               SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(infos:nil,error: "服务器异常",totalCount: nil)
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("loadCompanys.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                let totalCount = dict["totalCount"].intValue
                //  字典转成模型
                if success {
                    if let items = dict["json"].arrayObject {
                        var infos = [Info]()
                        for item in items {
                            let homeItem = Info(dict: item as! [String: AnyObject])
                            infos.append(homeItem)
                        }
                        finished(infos: infos,error: nil,totalCount: totalCount)
                        SVProgressHUD.dismiss()
                    }
                    
                    
                }else{
                    finished(infos: nil,error: message,totalCount: nil) //success  false
                }
            }else {
                finished(infos: nil,error: "数据异常",totalCount: nil)
            }

        }
    }
    
    //MARK: 获取MSDS列表
    func getMSDSInfo(parameters:[String:AnyObject],finished: (mSDSInfoModels: [MSDSInfoModel]!, error: String!,totalCount:Int!)->()) {
        
        self.sendPostRequest(AppTools.getServiceURLWithDa("LOAD_DANGEROUS_CHEMICALS"), parameters: parameters) { (response) in
            
            guard response!.result.isSuccess else {
                finished(mSDSInfoModels:nil,error: "服务器异常",totalCount: nil)
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("getMSDSInfo.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                let totalCount = dict["totalCount"].intValue
                //  字典转成模型
                if success {
                    if let items = dict["json"].arrayObject {
                        var mSDSInfoModels = [MSDSInfoModel]()
                        for item in items {
                            let homeItem = MSDSInfoModel(dict: item as! [String: AnyObject])
                            mSDSInfoModels.append(homeItem)
                        }
                        finished(mSDSInfoModels: mSDSInfoModels,error: nil,totalCount: totalCount)
                    }
                    
                }else{
                    finished(mSDSInfoModels: nil,error: message,totalCount: 0) //success  false
                }
            }else {
                finished(mSDSInfoModels: nil,error: "数据异常",totalCount: 0)
            }
            
        }
    }
    
    
    //MARK:  获取政策条款详情
    func getArticle(parameters:[String:AnyObject],finished: (info: Info!, error: String!)->()) {
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithDa("GET_LAW_INFO_LIST_DETAIL"), parameters: parameters) { (response) in
            
            guard response!.result.isSuccess else {
                 SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(info:nil,error: "服务器异常")
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("getArticle.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                //  字典转成模型
                if success {
                    if let data = dict["entity"].dictionaryObject{
                        let info = Info(dict:data)
                       finished(info: info, error: nil)
                    }
                   
                }else{
                    finished(info: nil,error: message) //success  false
                }
                 SVProgressHUD.dismiss()
            }else {
                finished(info: nil,error: "数据异常")
            }
            
        }
    }
    
    //MARK: - 获取图表页面数据
    //获取首页
    func loadGovCount(parameters:[String:AnyObject],finished: (data : ChartModel!, error: String!)->()) {
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("LOAD_GOV_COUNT"), parameters: parameters) { (response) in
            
            guard response!.result.isSuccess else {
                 SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(data:nil,error: "服务器异常")
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("loadGovCount.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                //  字典转成模型
                if success {
                    if let data = dict["entity"].dictionaryObject{
                        let dataModel = ChartModel(dict:data)
                        finished(data: dataModel, error: nil)
                    }
                    
                }else{
                    finished(data: nil,error: message) //success  false
                }
                SVProgressHUD.dismiss()
            }else {
                finished(data: nil,error: "数据异常")
            }
            
        }
    }
    
    
    //获取政府统计数据
    func loadCountGov(parameters:[String:AnyObject],finished: (data : ChartModel!, error: String!)->()) {
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("LOAD_COUNT_GOV"), parameters: parameters) { (response) in
            
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(data:nil,error: "服务器异常")
                //print("\(response!.response.)")
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("loadContGov.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                //  字典转成模型
                if success {
                    if let data = dict["entity"].dictionaryObject{
                        let dataModel = ChartModel(dict:data)
                        finished(data: dataModel, error: nil)
                    }
                    
                }else{
                    finished(data: nil,error: message) //success  false
                }
                SVProgressHUD.dismiss()

            }else {
                finished(data: nil,error: "数据异常")
            }
            
        }
    }
    
    //获取企业统计数据
    func loadCountCom(parameters:[String:AnyObject],finished: (data : ChartModel!, error: String!)->()) {
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("LOAD_COUNT_COM"), parameters: parameters) { (response) in
            
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(data:nil,error: "服务器异常")
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("loadCountCom.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                //  字典转成模型
                if success {
                    if let data = dict["entity"].dictionaryObject{
                        let dataModel = ChartModel(dict:data)
                        finished(data: dataModel, error: nil)
                    }
                    
                }else{
                    finished(data: nil,error: message) //success  false
                }
                SVProgressHUD.dismiss()
            }else {
                finished(data: nil,error: "数据异常")
            }
            
        }
    }
    
    
    //MARK:  政府复查
    //获取待复查列表
    func loadProduceCallBacks(parameters:[String:AnyObject],finished: (datas: [UnPunishmentModel]!, error: String!,totalCount:Int!)->()) {
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("LOAD_PRODUCE_CALLBACKS"), parameters: parameters) { (response) in
            
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(datas:nil,error: "服务器异常",totalCount: nil)
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("loadProduceCallBacks.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                let totalCount = dict["totalCount"].intValue
                //  字典转成模型
                if success {
                    if let items = dict["json"].arrayObject {
                        var listDatas = [UnPunishmentModel]()
                        for item in items {
                            let homeItem = UnPunishmentModel(dict: item as! [String: AnyObject])
                            listDatas.append(homeItem)
                        }
                        finished(datas: listDatas,error: nil,totalCount: totalCount)
                       
                    }
                    
                    
                }else{
                    finished(datas: nil,error: message,totalCount: nil) //success  false
                }
                 SVProgressHUD.dismiss()
            }else {
                finished(datas: nil,error: "数据异常",totalCount: nil)
            }
            
        }
    }
    
    //上传重大隐患
    func createDangerGorver(parameters:[String:AnyObject],finished: (datas: [UnPunishmentModel]!, error: String!)->()) {
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("CREATE_DANGGER_GORVER"), parameters: parameters) { (response) in
            
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(datas:nil,error: "服务器异常")
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("createDangerGorver.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
              
                //  字典转成模型
                if success {
                    finished(datas: nil,error: nil)
                    
                }else{
                    finished(datas: nil,error: message) //success  false
                }
                SVProgressHUD.dismiss()
            }else {
                finished(datas: nil,error: "数据异常")
            }
            
        }
    }
    
    //新增复查信息
    func createProduceCallBack(parameters:[String:AnyObject],imageArrays:[UIImage],finished:(data:CheckRecordInfoModel!,error:String!)->()){
        SVProgressHUD.showWithStatus("正在加载...")
        let identify = AppTools.loadNSUserDefaultsValue("identify") as! String
        var addParameters = parameters
        addParameters["client"] = "ios"
        let key = "SAFETYS_CLIENT_AUTH_KEY_2016="+identify
        let headers = [
            "Cookie": key,
            "Accept-Language" : "zh-CN,zh;q=0.8,en;q=0.6"
        ]
        
        upload(.POST, AppTools.getServiceURLWithYh("CREATE_PRODUCE_CALLBACK"), headers:headers,multipartFormData: { (multipartFormData) in
            
            print("imageArrays.count = \(imageArrays.count)")
            if !imageArrays.isEmpty{
                for i in 0..<imageArrays.count{
                    let data = UIImageJPEGRepresentation(imageArrays[i] , 0.5)
                    let randomNum :Int = AppTools.createRandomMan(0, end: 100000)()
                    let imageName = String(NSDate()) + "\(randomNum).png"
                    print("imageName = \(imageName)")
                    multipartFormData.appendBodyPart(data: data!, name: "file[\(i)]", fileName: imageName, mimeType: "image/png")
                    multipartFormData.appendBodyPart(data: imageName.dataUsingEncoding(NSUTF8StringEncoding)!, name: "fileFileName[\(i)]" )
                }
            }
            
            // 这里就是绑定参数的地方 param 是需要上传的参数，我这里是封装了一个方法从外面传过来的参数，你可以根据自己的需求用NSDictionary封装一个param
            for (key, value) in parameters {
                print("key = \(key)value = \(value)")
                assert(value is String, "参数必须能够转换为NSData的类型，比如String")
                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key )
                
            }
            
        }) { (encodingResult) in
            switch encodingResult {
            case .Success(let upload, _, _):
                upload.responseJSON(completionHandler: { (response) in
                    //completeBlock(responseObject: response.result.value!, error: nil)
                    if let dictValue = response.result.value{
                        let dict = JSON(dictValue)
                        print("createProduceCallBack.dict = \(dict)")
                        let success = dict["success"].boolValue
                        let message = dict["msg"].stringValue
                        //  字典转成模型
                        if success {
                            finished(data: nil,error: nil) //success  false
                            
                        }else{
                            finished(data: nil,error: message) //success  false
                        }
                        SVProgressHUD.dismiss()
                        
                    }else {
                        finished(data: nil,error: "数据异常")
                    }
                    
                })
            case .Failure( _):
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(data:nil,error: "服务器异常")
            }
        }
    }


    
    
    //MARK:  行政处罚
    //获取未处罚列表
    func loadUnpunLists(parameters:[String:AnyObject],finished: (datas: [UnPunishmentModel]!, error: String!,totalCount:Int!)->()) {
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("LOAD_UNPUN_LIST"), parameters: parameters) { (response) in
            
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(datas:nil,error: "服务器异常",totalCount: nil)
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("loadUnpunLists.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                let totalCount = dict["totalCount"].intValue
                //  字典转成模型
                if success {
                    if let items = dict["json"].arrayObject {
                        var listDatas = [UnPunishmentModel]()
                        for item in items {
                            let homeItem = UnPunishmentModel(dict: item as! [String: AnyObject])
                            listDatas.append(homeItem)
                        }
                        finished(datas: listDatas,error: nil,totalCount: totalCount)
                     
                    }
                }else{
                    finished(datas: nil,error: message,totalCount: nil) //success  false
                }
                   SVProgressHUD.dismiss()
            }else {
                finished(datas: nil,error: "数据异常",totalCount: nil)
            }
            
        }
    }
    
    
   
    //获取已处罚列表
    func loadPunLists(parameters:[String:AnyObject],finished: (datas: [PunishmentModel]!, error: String!,totalCount:Int!)->()) {
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("LOAD_PUN_LIST"), parameters: parameters) { (response) in
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(datas:nil,error: "服务器异常",totalCount: nil)
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("loadPunLists.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                let totalCount = dict["totalCount"].intValue
                //  字典转成模型
                if success {
                    if let items = dict["json"].arrayObject {
                        var listDatas = [PunishmentModel]()
                        for item in items {
                            let homeItem = PunishmentModel(dict: item as! [String: AnyObject])
                            listDatas.append(homeItem)
                        }
                        finished(datas: listDatas,error: nil,totalCount: totalCount)
                       
                    }
                    
                    
                }else{
                    finished(datas: nil,error: message,totalCount: nil) //success  false
                }
                 SVProgressHUD.dismiss()
            }else {
                finished(datas: nil,error: "数据异常",totalCount: nil)
            }
            
        }
    }
    
    //获取已处罚详情
    func loadPunishment(parameters:[String:AnyObject],finished: (datas: PunishmentInfoModel!, error: String!,totalCount:Int!)->()) {
        SVProgressHUD.showWithStatus("正在加载...")
        self.sendPostRequest(AppTools.getServiceURLWithYh("LOAD_PUNISHMENT"), parameters: parameters) { (response) in
            guard response!.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                finished(datas:nil,error: "服务器异常",totalCount: nil)
                return
            }
            if let dictValue = response!.result.value{
                let dict = JSON(dictValue)
                print("loadPunLists.dict = \(dict)")
                let success = dict["success"].boolValue
                let message = dict["msg"].stringValue
                let totalCount = dict["totalCount"].intValue
                //  字典转成模型
                if success {
                    let data = PunishmentInfoModel(dict:dict["entity"].dictionaryObject!)
                    finished(datas: data,error: nil,totalCount: totalCount)
         
                }else{
                    finished(datas: nil,error: message,totalCount: nil) //success  false
                }
                SVProgressHUD.dismiss()
            }else {
                finished(datas: nil,error: "数据异常",totalCount: nil)
            }
            
        }
    }
  
    
    func sendPostRequest(URL:String,parameters:[String:AnyObject],finished:(response:Response<AnyObject, NSError>!)->()){
        let identify = AppTools.loadNSUserDefaultsValue("identify") as! String
        var addParameters = parameters
        addParameters["client"] = "ios"
        let key = "SAFETYS_CLIENT_AUTH_KEY_2016="+identify
               let headers = [
            "Cookie": key,
            "Accept-Language" : "zh-CN,zh;q=0.8,en;q=0.6"
            ]
        //"Content-Type": "application/json;charset=UTF-8"  加上此header报type不能为空
          request(.POST, URL, parameters: addParameters, encoding: .URL, headers: headers).responseJSON(queue: dispatch_get_main_queue(), options: []){(response) in
               finished(response: response)
        }

    }
    
}