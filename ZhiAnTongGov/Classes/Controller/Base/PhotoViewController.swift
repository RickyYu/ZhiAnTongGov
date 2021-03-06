//
//  PhotoViewController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/1/11.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit
import Photos

class PhotoViewController: BaseViewController,PhotoPickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    //获取到的每一个button图片
    var selectModel = [PhotoImageModel]()
    //button按钮栏
    var containerView = UIView()
    var triggerRefresh = false
    var x:CGFloat = 0.0
    var y:CGFloat = 0.0
    //获取到的图片数据
    private var listImageFile = [UIImage]()
  
    //设置初始定位
    func setLoc(x:CGFloat,y:CGFloat){
        self.x = x
        self.y = y
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.containerView)
        self.checkNeedAddButton()
        self.renderView()
    }
    
    //检查是否需要添加+号按钮
     func checkNeedAddButton(){
        if self.selectModel.count < PhotoPickerController.imageMaxSelectedNum && !hasButton() {
            selectModel.append(PhotoImageModel(type: ModelType.Button, data: nil))
        }
    }
    
    //判断是否含有button
     func hasButton() -> Bool{
        for item in self.selectModel {
            if item.type == ModelType.Button {
                return true
            }
        }
        return false
    }
    
    func removeElement(element: String?){
        if let localIdentifier = element {
                     //此处必须使用老式循环方法
            for var i=0;i<self.selectModel.count;i += 1 {
                let model = self.selectModel[i]
                if model.data?.localIdentifier == localIdentifier {
                    self.selectModel.removeAtIndex(i)
                    self.triggerRefresh = true
                }
            }
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarStyle = .Default
        self.navigationController?.navigationBar.barStyle = .Default
        
        if self.triggerRefresh {
            self.triggerRefresh = false
            self.updateView()
        }
        
    }
    
    func updateView(){
        self.clearAll()
        self.checkNeedAddButton()
        self.renderView()
    }
    
    //绘制图片展示界面
    func renderView(){
        if selectModel.count <= 0 {return;}
        
        let totalWidth = UIScreen.mainScreen().bounds.width
        let space:CGFloat = 10
        let lineImageTotal = IMAGE_MAX_SELECTEDNUM
        
        let line = self.selectModel.count / lineImageTotal
        let lastItems = self.selectModel.count % lineImageTotal
        
        let lessItemWidth = (totalWidth - (CGFloat(lineImageTotal) + 1) * space)
        let itemWidth = lessItemWidth / CGFloat(lineImageTotal)
        
        for i in 0 ..< line {
            let itemY = CGFloat(i+1) * space + CGFloat(i) * itemWidth
            for j in 0 ..< lineImageTotal {
                let itemX = CGFloat(j+1) * space + CGFloat(j) * itemWidth
                let index = i * lineImageTotal + j
                self.renderItemView(itemX, itemY: itemY, itemWidth: itemWidth, index: index)
            }
        }
        
        // last line
        for i in 0 ..< lastItems {
            let itemX = CGFloat(i+1) * space + CGFloat(i) * itemWidth
            let itemY = CGFloat(line+1) * space + CGFloat(line) * itemWidth
            let index = line * lineImageTotal + i
            self.renderItemView(itemX, itemY: itemY, itemWidth: itemWidth, index: index)
        }


        let totalLine = ceil(Double(self.selectModel.count) / Double(lineImageTotal))
        let containerHeight = CGFloat(totalLine) * itemWidth + (CGFloat(totalLine) + 1) *  space
        self.containerView.frame = CGRectMake(x, y, totalWidth,  containerHeight)
    }
    
    //获取所有图片数据
    func getListImage() ->[UIImage]{
        if listImageFile.count != 0 {
            listImageFile.removeAtIndex(0)
        }
       return self.listImageFile
    }
    
    //绘制图片按钮栏界面
    private func renderItemView(itemX:CGFloat,itemY:CGFloat,itemWidth:CGFloat,index:Int){
        let itemModel = self.selectModel[index]
        let button = UIButton(frame: CGRectMake(itemX, itemY, itemWidth, itemWidth))
        button.backgroundColor = UIColor.redColor()
        button.tag = index
        
        if itemModel.type == ModelType.Button {
            button.backgroundColor = UIColor.clearColor()
            button.addTarget(self, action: #selector(self.eventAddImage), forControlEvents: .TouchUpInside)
            button.contentMode = .ScaleAspectFill
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.init(red: 200/255, green: 200/255, blue: 200/255, alpha: 1).CGColor
            button.setImage(UIImage(named: "image_select"), forState: UIControlState.Normal)
        } else {
            listImageFile.removeAll()
            
            button.addTarget(self, action: #selector(self.eventPreview(_:)), forControlEvents: .TouchUpInside)
            if let asset = itemModel.data {  //获取招聘数据
                let pixSize = UIScreen.mainScreen().scale * itemWidth
                //asset格式数据转换成图片
                PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: CGSizeMake(pixSize, pixSize), contentMode: PHImageContentMode.AspectFill, options: nil, resultHandler: { (image, info) -> Void in
                    if image != nil {
                        self.listImageFile.append(image!)
                        button.setImage(image, forState: UIControlState.Normal)
                        button.contentMode = .ScaleAspectFill
                        button.clipsToBounds = true
                    }
                })
            }
        }
        
        self.containerView.addSubview(button)
    }
    //随机数生成器函数
    func createRandomMan(start: Int, end: Int) ->() ->Int! {
        //根据参数初始化可选值数组
        var nums = [Int]();
        for i in start...end{
            nums.append(i)
        }
        
        func randomMan() -> Int! {
            if !nums.isEmpty {
                //随机返回一个数，同时从数组里删除
                let index = Int(arc4random_uniform(UInt32(nums.count)))
                return nums.removeAtIndex(index)
            }
            else {
                //所有值都随机完则返回nil
                return nil
            }
        }
        
        return randomMan
    }
    
    private func clearAll(){
        for subview in self.containerView.subviews {
            if let view =  subview as? UIButton {
                view.removeFromSuperview()
            }
        }
    }
    
    // MARK: -  button event
    func eventPreview(button:UIButton){
        let preview = SinglePhotoPreviewViewController()
        let data = self.getModelExceptButton()
        preview.selectImages = data
        preview.sourceDelegate = self
        preview.currentPage = button.tag
        self.showViewController(preview, sender: nil)
    }
    
    
    func eventAddImage() {
        let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        // change the style sheet text color
        alert.view.tintColor = UIColor.blackColor()
        
        let actionCancel = UIAlertAction.init(title: "取消", style: .Cancel, handler: nil)
        let actionCamera = UIAlertAction.init(title: "拍照", style: .Default) { (UIAlertAction) -> Void in
            self.selectByCamera()
        }
        
        let actionPhoto = UIAlertAction.init(title: "从手机照片中选择", style: .Default) { (UIAlertAction) -> Void in
            self.selectFromPhoto()
        }
        
        alert.addAction(actionCancel)
        alert.addAction(actionCamera)
        alert.addAction(actionPhoto)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    var imagePicker:UIImagePickerController!
    /**
     拍照获取
     */
    private func selectByCamera(){
        // todo take photo task

            self.imagePicker  = UIImagePickerController()
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .Camera
            self.imagePicker.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
       
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //self.listImageFile.append((info[UIImagePickerControllerOriginalImage] as? UIImage)!)
        
        print(info)
//        let ass
//        if #available(iOS 9.0, *) {
//             = PHAssetCreationRequest.creationRequestForAssetFromImage((info[UIImagePickerControllerOriginalImage] as? UIImage)!)
//        } else {
//            self.alert("拍照支持9.0以上版本")
//        }
        
        
        self.selectModel.insert(PhotoImageModel(type: ModelType.Image, data: info[UIImagePickerControllerOriginalImage] as? PHAsset), atIndex: 0)
        if self.selectModel.count > PhotoPickerController.imageMaxSelectedNum {
            for i in 0 ..< self.selectModel.count {
                let item = self.selectModel[i]
                if item.type == .Button {
                    self.selectModel.removeAtIndex(i)
                }
            }
        }
        self.renderView()
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        renderView()
    }
    
    /**
     从相册中选择图片
     */
    func selectFromPhoto(){
        
        PHPhotoLibrary.requestAuthorization { (status) -> Void in
            switch status {
            case .Authorized:
                self.showLocalPhotoGallery()
                break
            default:
                self.showNoPermissionDailog()
                break
            }
        }
    }
    
     func showNoPermissionDailog(){
        let alert = UIAlertController.init(title: nil, message: "没有打开相册的权限", preferredStyle: .Alert)
        alert.addAction(UIAlertAction.init(title: "确定", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showLocalPhotoGallery(){
        let picker = PhotoPickerController(type: PageType.AllAlbum)
        picker.imageSelectDelegate = self
        picker.modalPresentationStyle = .Popover
        
        // max select number
        PhotoPickerController.imageMaxSelectedNum = IMAGE_MAX_SELECTEDNUM
        
        // already selected image num
        let realModel = self.getModelExceptButton()
        PhotoPickerController.alreadySelectedImageNum = realModel.count
        dispatch_async(dispatch_get_main_queue()) {
            self.showViewController(picker, sender: nil)
        }
    }
    
    func onImageSelectFinished(images: [PHAsset]) {
        self.renderSelectImages(images)
    }
    
     func renderSelectImages(images: [PHAsset]){
        for item in images {
            self.selectModel.insert(PhotoImageModel(type: ModelType.Image, data: item), atIndex: 0)
        }
        
        if self.selectModel.count > PhotoPickerController.imageMaxSelectedNum {
            for i in 0 ..< self.selectModel.count {
                let item = self.selectModel[i]
                if item.type == .Button {
                    self.selectModel.removeAtIndex(i)
                }
            }
        }
        self.renderView()
    }
    
     func getModelExceptButton()->[PhotoImageModel]{
        var newModels = [PhotoImageModel]()
        for i in 0 ..< self.selectModel.count {
            let item = self.selectModel[i]
            if item.type != .Button {
                newModels.append(item)
            }
        }
        return newModels
    }
    
}



