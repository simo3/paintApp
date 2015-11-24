//
//Users/simo/Desktop/nsx.jpg/  ViewController.swift
//  paintApp
//
//  Created by 下向和紀 on 2015/11/23.
//  Copyright © 2015年 simo. All rights reserved.
//

import UIKit
import ACEDrawingView

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //UIImagePickerControllerDelegate, UINavigationControllerDelegateのデリゲートを追加
    

    @IBOutlet weak var CntV: UIView!
    
    
    @IBOutlet weak var drawView: ACEDrawingView!
    
    
    @IBOutlet weak var backgroundIV: UIImageView!
    
    //書いたものを保存
    @IBAction func saveBtn(sender: UIButton) {
        UIGraphicsBeginImageContextWithOptions(CntV.frame.size, false, 0)
        CntV.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let exportImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //アプリに保存
        UIImageWriteToSavedPhotosAlbum(exportImage, nil, nil, nil)
        
    }
    
    //Photosから読み込む
    @IBAction func loadBtn(sender: UIButton) {
        
        let alert = UIAlertController(title: "選択", message: "", preferredStyle: .ActionSheet)
        alert.addAction(UIAlertAction(title: "カメラから", style: .Default, handler: { (action) -> Void in
            self.selectResource(.PhotoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "写真から", style: .Default, handler: { (action) -> Void in
            self.selectResource(.PhotoLibrary)
        }))
            
            presentViewController(alert, animated: true, completion: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary){
            let picker = UIImagePickerController()
            picker.sourceType = .PhotoLibrary
            picker.allowsEditing = true
            picker.delegate = self
            
            presentViewController(picker, animated: true, completion: nil)
        }
    }
    
    //カメラと写真のどちらを選びますか？
    func selectResource(type:UIImagePickerControllerSourceType){
        if UIImagePickerController.isSourceTypeAvailable(type){
            let picker = UIImagePickerController()
            picker.sourceType = type
            picker.allowsEditing = true
            picker.delegate = self
            
            presentViewController(picker, animated: true, completion: nil)
        }
    }
    
    //カメラや写真選択をした時に呼ばれるデリゲートイベント
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        //背景画像を変更
        backgroundIV.image = image
        
        //お絵描きを削除する
        drawView.clear()
        
        //画面を閉じる
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawView.drawTool = ACEDrawingToolTypePen
        
        drawView.lineWidth = 4.0
        drawView.lineColor = UIColor.brownColor()
        drawView.lineAlpha = 0.8
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

