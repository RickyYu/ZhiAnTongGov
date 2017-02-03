//
//  ViewController.swift
//  ImagePickView
//
//  Created by lengshengren on 15/10/9.
//  Copyright © 2015年 Apress. All rights reserved.
//

import UIKit
import MobileCoreServices

class PViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate {
    
   var imageView: UIImageView!
    
    
    var imagePicker     : UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        let button1 = UIButton(frame:CGRectMake(110, 110, 36, 36))
        imageView = UIImageView(frame:CGRectMake(110, 210, 100, 100))
        button1.backgroundColor = UIColor.redColor()
        button1.setImage(UIImage(named: "daily_mgr_selected"), forState: .Normal)
        button1.addTarget(self,action:#selector(self.tapped1),forControlEvents:.TouchUpInside)
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addSubview(button1)
        self.view.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tapped1(){
        let actionSheetController: UIAlertController = UIAlertController(title: "请选择", message:nil, preferredStyle: .ActionSheet)
        
        //取消按钮
        let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        
        actionSheetController.addAction(cancelAction)
        
        //拍照
        let takePictureAction: UIAlertAction = UIAlertAction(title: "拍照", style: .Default)
        { action -> Void in
            
            [self .initWithImagePickView("拍照")];
            
        }
        
        actionSheetController.addAction(takePictureAction)
        
        //相册选择
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "相册", style: .Default)
        { action -> Void in
            
            [self .initWithImagePickView("相册")];
            
        }
        
        actionSheetController.addAction(choosePictureAction)
        
        //摄像
        let moviePictureAction: UIAlertAction = UIAlertAction(title: "摄像", style: .Default)
        { action -> Void in
            
            [self .initWithImagePickView("摄像")];
            
        }
        
        actionSheetController.addAction(moviePictureAction)
        
        self.presentViewController(actionSheetController, animated: true, completion: nil)
        

    
    }
    
    @IBAction func selectImageAction(sender: AnyObject) {
        
      let actionSheetController: UIAlertController = UIAlertController(title: "请选择", message:nil, preferredStyle: .ActionSheet)
        
        //取消按钮
        let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        
        actionSheetController.addAction(cancelAction)
        
        //拍照
        let takePictureAction: UIAlertAction = UIAlertAction(title: "拍照", style: .Default)
            { action -> Void in
            
            [self .initWithImagePickView("拍照")];
                
        }
        
        actionSheetController.addAction(takePictureAction)
        
        //相册选择
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "相册", style: .Default)
            { action -> Void in
                
            [self .initWithImagePickView("相册")];
                
        }
        
        actionSheetController.addAction(choosePictureAction)
        
        //摄像
        let moviePictureAction: UIAlertAction = UIAlertAction(title: "摄像", style: .Default)
            { action -> Void in
                
            [self .initWithImagePickView("摄像")];
                
        }
        
        actionSheetController.addAction(moviePictureAction)

        self.presentViewController(actionSheetController, animated: true, completion: nil)
        
 

    }
    

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
 
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        let compareResult = CFStringCompare(mediaType as NSString!, kUTTypeMovie, CFStringCompareFlags.CompareCaseInsensitive)
        
        if compareResult == CFComparisonResult.CompareEqualTo {
            
            let moviePath = info[UIImagePickerControllerMediaURL] as? NSURL
            
            //获取路径
            let moviePathString = moviePath!.relativePath
            
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(moviePathString!)
            {
                
                UISaveVideoAtPathToSavedPhotosAlbum(moviePathString!, nil, nil, nil)
                
            }
            
            print("视频")
            
        }
        else {
            
            print("图片")
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
       // self.imageView.image =  image;

        }

        imagePicker.dismissViewControllerAnimated(true, completion: nil)

        
    }

    func initWithImagePickView(type:NSString){
        
        self.imagePicker = UIImagePickerController()
        self.imagePicker.delegate      = self;
        self.imagePicker.allowsEditing = true;
        
        switch type{
        case "拍照":
            self.imagePicker.sourceType = .Camera
            break
        case "相册":
            self.imagePicker.sourceType = .PhotoLibrary
            break
        case "摄像":
            self.imagePicker.sourceType = .Camera
            self.imagePicker.videoMaximumDuration = 60 * 3
            self.imagePicker.videoQuality = .Type640x480
            self.imagePicker.mediaTypes = [String(kUTTypeMovie)]
            break
        default:
            print("error")
        }
        
        presentViewController(self.imagePicker, animated: true, completion: nil)
    }
    
    
}

