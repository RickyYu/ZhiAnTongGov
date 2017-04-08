//
//  TestController.swift
//  ZhiAnTongGov
//
//  Created by Ricky on 2017/1/20.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit
import SnapKit
import UsefulPickerView
import SwiftyJSON
import Photos
class SinglePhotoViewController: BaseViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    var scrollView  = UIScrollView()
    var imageTag : Int = 0
    var leftWidth : CGFloat = 0
    var x:CGFloat = 0.0
    var y:CGFloat = 0.0
    var imagePicker = UIImagePickerController()
    let IMAGE_HEIGHT:CGFloat = 100
    let IMAGE_WIDTH :CGFloat = 100
    private var imageViews : [UIImageView] = []
    var deletedFileIds : String = ""
      private var listImageFile = [UIImage]() // 获取的所有照片
    //设置初始定位
    func setImageViewLoc(x:CGFloat,y:CGFloat){
        self.x = x
        self.y = y
        initScrollView()
    }
    
    override func viewDidLoad() {
    }
    
    func initScrollView(){
        scrollView =  UIScrollView(frame: CGRectMake(x, y, SCREEN_WIDTH, 110))
        scrollView.scrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = true
        scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 110)
    }
    
    func getTakeImages()-> [UIImage]{
        //获取图片
        if imageViews.count > 0 {
            for i in 0 ..< imageViews.count {
                let image = imageViews[i].image!
                if image.accessibilityIdentifier == nil {
                    
                    listImageFile.append(image)
                }
            }
        }
        return listImageFile
    }
    
    func takeImage() {
        if imageViews.count>=IMAGE_MAX_SELECTEDNUM{
            self.alert(NOTICE_MAX_IMAGE, handler: {
                return
            })
        }
        
        
        let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: .ActionSheet)
        // change the style sheet text color
        alert.view.tintColor = UIColor.blackColor()
    
        let actionCancel = UIAlertAction.init(title: "取消", style: .Cancel, handler: nil)
        let actionCamera = UIAlertAction.init(title: "拍照", style: .Default) { (UIAlertAction) -> Void in
            self.selectSourceType(.Camera)
        }
        let actionPhoto = UIAlertAction.init(title: "从手机照片中选择", style: .Default) { (UIAlertAction) -> Void in
            self.selectSourceType(.PhotoLibrary)
        }
        alert.addAction(actionCancel)
        alert.addAction(actionCamera)
        alert.addAction(actionPhoto)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func selectSourceType(type:UIImagePickerControllerSourceType) {
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
        self.imagePicker.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        switch type {
        case .Camera:
            self.imagePicker.sourceType = .Camera //拍照
            break
        case .PhotoLibrary:
            self.imagePicker.sourceType = .PhotoLibrary //相册
            break
        default:
            print("error")
        }
        
        self.presentViewController(self.imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageView = UIImageView()
        imageView.image = image.reSizeImage(CGSize(width: 300, height: 200))
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        self.addImageView(imageView)
    }

    func addImageView(imageView: UIImageView) {
        imageTag += 1
        imageView.userInteractionEnabled = true;
        imageView.frame = CGRectMake(leftWidth, 2.5, IMAGE_HEIGHT, IMAGE_WIDTH)
        imageView.tag = 1000 + imageTag
        imageViews.append(imageView)
        
        let closeView = UIImageView()
        closeView.frame = CGRectMake(IMAGE_WIDTH-25, 0, 25, 25)
        closeView.image = UIImage(named: "delete")
        closeView.tag = imageTag
        
        closeView.userInteractionEnabled = true;
        closeView.addOnClickListener(self, action: #selector(deleteImage))
        imageView.addSubview(closeView)
        scrollView.addSubview(imageView)
        leftWidth += IMAGE_WIDTH+5
        //设置图片占用大小
        scrollView.contentSize = CGSize(width: leftWidth + 80, height: IMAGE_HEIGHT)
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }

    func deleteImage(sender: AnyObject) {
        let tap = sender as! UITapGestureRecognizer;
        let views = tap.view!;
        let imageView = scrollView.viewWithTag(1000 + views.tag) as! UIImageView
        let id = imageView.image?.accessibilityIdentifier
        //删除图片
        if id != nil {
            self.deletedFileIds +=  id! + ","
        }
        let index = imageViews.indexOf(imageView)!
        imageViews.removeAtIndex(index)
        imageView.removeFromSuperview()
        self.leftWidth = 0
        //刷新scrollView
        if imageViews.count > 0 {
            for num in 0...imageViews.count-1 {
                imageViews[num].frame = CGRectMake(leftWidth, 0, IMAGE_HEIGHT, IMAGE_WIDTH)
                leftWidth += IMAGE_WIDTH+5
            }
            scrollView.contentSize = CGSize(width: leftWidth + 80, height: IMAGE_HEIGHT)
        }
        
    }
    
}


