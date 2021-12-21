//
//  kaisetuViewController.swift
//  SHSinfo2019
//
//  Created by 吉川哲也 on 2019/08/09.
//  Copyright © 2019 SHS情報技術. All rights reserved.
//

import UIKit

class kaisetuViewController: UIViewController {
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var kaisetu: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var backbtn: UIButton!
    var page1Controller : mondaiViewController?
    var page2Controller : kekkaViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //buttonコーナーを丸く
        backbtn.layer.cornerRadius = 15.0
        // スクリーンの縦横サイズを取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        
        text1.frame = CGRect(x:20,y:screenHeight/10,width: 200,height: 30)
        text1.text = "〜解説〜"

        
        
        // UIImage インスタンスの生成
        let image:UIImage = UIImage(named:"q_image_ben")!
        // UIImageView 初期化
        let imageView = UIImageView(image:image)
        
        // 画像の縦横サイズを取得
        let imgWidth:CGFloat = image.size.width
        let imgHeight:CGFloat = image.size.height
        
        let amari = screenWidth-220
        print(amari)
        // 画像サイズをスクリーン幅に合わせる
        let scale:CGFloat = amari / (imgHeight)
        let rect:CGRect =
            CGRect(x:0, y:0, width:amari, height:imgHeight*scale)
        // ImageView frame をCGRectで作った矩形に合わせる
        imageView.frame = rect;
        // 画像の中心を画面の中心に設定
        imageView.center = CGPoint(x:220, y:screenHeight/8)
        // UIImageViewのインスタンスをビューに追加
        self.view.addSubview(imageView)
        // Do any additional setup after loading the view.
        
        
        /****************解説***************************/
        kaisetu.frame = CGRect(x:10,y:screenHeight/10+40,width: screenWidth-10,height: screenHeight*2/3)
        let userDefaluts = UserDefaults.standard
        let kaisetutext = userDefaluts.string(forKey: "kaisetu")
        kaisetu.text = kaisetutext
        
        /***************Nextボタン**********************/
        btn.frame = CGRect(x:10,y:screenHeight-100,width: screenWidth-10,height: 50)
        //buttonコーナーを丸く
        backbtn.layer.cornerRadius = 15.0
        
        page1Controller = createPage1ViewController()
        page2Controller = createPage2ViewController()
        
    }
    
    @IBAction func next(_ sender: Any) {
        let userDefaluts = UserDefaults.standard
        let mondaiNum = userDefaluts.integer(forKey: "mondaiCount")
        if mondaiNum > 5 {
            /*画面遷移*/
            self.displayContentController(content: self.page2Controller!, container: view)
            /************ここまで******************/
        }else{
            /*画面遷移*/
            self.displayContentController(content: self.page1Controller!, container: view)
            /************ここまで******************/
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
         self.dismiss(animated: true, completion: nil);
    }
    
    func createPage1ViewController() -> mondaiViewController{
        let sb:UIStoryboard = UIStoryboard(name: "mondaiViewController",bundle: nil)
        let sController:mondaiViewController = sb.instantiateInitialViewController() as! mondaiViewController
        return sController
    }
    
    func createPage2ViewController() -> kekkaViewController{
        let sb:UIStoryboard = UIStoryboard(name: "kekkaViewController",bundle: nil)
        let sController:kekkaViewController = sb.instantiateInitialViewController() as! kekkaViewController
        return sController
    }
    func displayContentController(content:UIViewController, container:UIView){
        container.addSubview(content.view)
        addChild(content)
        content.view.frame = container.bounds
        content.didMove(toParent: self)
    }
    
    
}
